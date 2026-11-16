# pr-assets

Screenshots and recordings for pull requests in [ArakunHQ/arakun](https://github.com/ArakunHQ/arakun).
GitHub has no API to attach images to a pull request, so they live here and the
pull request links them.

## Layout

Each upload gets a new folder named after the branch (any character but letters, digits, `.`, `_` and `-`
becomes `-`, so it is safe in a URL), its commit,
the UTC time and the uploading shell's process ID, so no two uploads share one and
nothing is overwritten:

```
<branch>-<commit>-<YYYYmmddHHMMSS>-<pid>/before-<what>.png
<branch>-<commit>-<YYYYmmddHHMMSS>-<pid>/after-<what>.png
```

Copy each file by name, not with a glob, so no stale capture is published.

Embed one in a pull request with its raw URL:

```markdown
![After, 1072×800](https://raw.githubusercontent.com/ArakunHQ/pr-assets/main/<folder>/after-1072x800.png)
```

Screenshots are public: use made-up data, not real accounts or tokens.
