#!/usr/bin/env bash
# Deletes upload folders that are older than KEEP_DAYS and that no open pull
# request in ArakunHQ/arakun or ArakunHQ/arakun.dev still links.
#
#   tools/cleanup.sh            # list what would go, change nothing
#   tools/cleanup.sh --apply    # git rm those folders (the caller commits)
#
# Only folders named by tools/pr-assets.sh count: they end in
# -<UTC YYYYMMDDHHMMSS>-<process ID>, and that time is the folder's age.
# Older folders without it (cloudflare-overview-narrow, pr-macos-dynamic-icon,
# pr-server-app) are never touched. A folder is linked when its name appears in
# an open pull request's description, comments or reviews.
#
# KEEP_DAYS (default 90) and SOURCE_REPOS (space separated) override the
# defaults. Needs gh signed in; GH_TOKEN works in Actions.
set -euo pipefail
export LC_ALL=C

KEEP_DAYS=${KEEP_DAYS:-90}
SOURCE_REPOS=${SOURCE_REPOS:-"ArakunHQ/arakun ArakunHQ/arakun.dev"}

apply=false
case "${1:-}" in
  --apply) apply=true ;;
  "") ;;
  *)
    echo "usage: tools/cleanup.sh [--apply]" >&2
    exit 2
    ;;
esac

[[ $KEEP_DAYS =~ ^[0-9]+$ ]] || {
  echo "cleanup: KEEP_DAYS must be a whole number" >&2
  exit 2
}

cd "$(git rev-parse --show-toplevel)"

# GNU date on the runner, BSD date on a Mac.
cutoff=$(date -u -d "$KEEP_DAYS days ago" +%Y%m%d%H%M%S 2>/dev/null ||
  date -u -v-"${KEEP_DAYS}"d +%Y%m%d%H%M%S)

# All text of every open pull request. A failed request stops the script, so
# an outage never reads as "nothing is linked".
linked=$(mktemp)
trap 'rm -f "$linked"' EXIT
for repo in $SOURCE_REPOS; do
  gh pr list -R "$repo" --state open --limit 1000 \
    --json body,comments,reviews \
    --jq '.[] | .body, (.comments[].body), (.reviews[].body)' >>"$linked"
done

removed=0
kept_linked=0
for dir in */; do
  folder=${dir%/}
  [[ $folder =~ -([0-9]{14})-[0-9]+$ ]] || continue
  stamp=${BASH_REMATCH[1]}
  [[ $stamp < $cutoff ]] || continue
  if grep -qF -- "/$folder/" "$linked"; then
    kept_linked=$((kept_linked + 1))
    echo "keep $folder (linked from an open pull request)"
    continue
  fi
  echo "remove $folder"
  removed=$((removed + 1))
  if [ "$apply" = true ]; then
    git rm -rq -- "$folder"
  fi
done

echo "cleanup: $removed folder(s) older than $KEEP_DAYS days to remove," \
  "$kept_linked kept for open pull requests"
[ "$apply" = true ] || echo "cleanup: dry run, pass --apply to delete"
