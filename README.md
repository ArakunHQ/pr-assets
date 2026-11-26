# pr-assets

Screenshots and recordings for pull requests in [ArakunHQ/arakun](https://github.com/ArakunHQ/arakun)
and [ArakunHQ/arakun.dev](https://github.com/ArakunHQ/arakun.dev).
GitHub has no API to attach images to a pull request, so they live here and the
pull request links them.

## Uploading

From a checkout of either repository, name each image:

```sh
tools/pr-assets.sh "$TMPDIR/before.png" "$TMPDIR/after.png"
```

It puts them in a new folder, pushes, and prints the Markdown to paste into the
pull request. The script's header says how folders are named. Folders made before
the script existed (`cloudflare-overview-narrow`, `pr-macos-dynamic-icon`,
`pr-server-app`) keep their names, since pull requests link to them.

## Cleanup

Every Monday, the `Clean up old assets` workflow deletes upload folders older
than 90 days, unless an open pull request in either repository still links
them. After that, merged and closed pull requests show broken images. The
three older folders above are never deleted. To see what would go, run
`tools/cleanup.sh` (a dry run), or start the workflow by hand with `dry_run`
checked. Deleted files stay in git history, so the repository's clone size
does not shrink.

Screenshots are public: use made-up data, not real accounts, tokens, emails or
home-directory paths.
