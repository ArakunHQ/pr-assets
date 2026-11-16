# pr-assets

Screenshots and recordings for pull requests in [ArakunHQ/arakun](https://github.com/ArakunHQ/arakun).
GitHub has no API to attach images to a pull request, so they live here and the
pull request links them.

## Uploading

From an Arakun checkout, name each image:

```sh
tools/pr-assets.sh "$TMPDIR/before.png" "$TMPDIR/after.png"
```

It puts them in a new folder, pushes, and prints the Markdown to paste into the
pull request. The script's header says how folders are named. Folders made before
the script existed (`cloudflare-overview-narrow`, `pr-macos-dynamic-icon`,
`pr-server-app`) keep their names, since pull requests link to them.

Screenshots are public: use made-up data, not real accounts, tokens, emails or
home-directory paths.
