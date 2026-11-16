# pr-assets

Screenshots and recordings for pull requests in [ArakunHQ/arakun](https://github.com/ArakunHQ/arakun).
GitHub has no API to attach images to a pull request, so they live here and the
pull request links them.

## Layout

One folder per change, named after its branch (`/` becomes `-`):

```
<branch>/before-<what>.png
<branch>/after-<what>.png
```

Embed one in a pull request with its raw URL:

```markdown
![After, 1072×800](https://raw.githubusercontent.com/ArakunHQ/pr-assets/main/<branch>/after-1072x800.png)
```

Screenshots are public: use made-up data, not real accounts or tokens.
