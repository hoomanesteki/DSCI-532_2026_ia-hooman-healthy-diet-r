# Contributing

Contributions of all kinds are welcome and greatly appreciated. Every bit helps, and credit will always be given.

## Report Bugs

Report bugs by opening an issue at https://github.com/hoomanesteki/DSCI-532_2026_ia-hooman-healthy-diet-r/issues.

When reporting a bug, please include:

- Your operating system and version
- Your R version (`R.version$version.string`)
- A clear description of what you expected to happen vs what actually happened
- Steps to reproduce the problem

The more detail you provide, the faster it can be resolved.

## Suggest Features or Improvements

Open an issue at https://github.com/hoomanesteki/DSCI-532_2026_ia-hooman-healthy-diet-r/issues and label it `enhancement`. Describe what you have in mind and why it would be useful.

## Fix Bugs or Implement Features

Look through the open issues. Anything labelled `bug` or `enhancement` with `help wanted` is open for contributions. To work on one:

1. Fork the repository on GitHub
2. Clone your fork locally

    ```bash
    git clone https://github.com/YOUR_USERNAME/DSCI-532_2026_ia-hooman-healthy-diet-r.git
    cd DSCI-532_2026_ia-hooman-healthy-diet-r
    ```

3. Create a branch from `main` using a descriptive prefix

    ```bash
    git checkout main
    git checkout -b fix-name-of-your-bugfix
    # or
    git checkout -b feat-name-of-your-feature
    ```

4. Make your changes, then commit using semantic commit messages

    ```bash
    git add .
    git commit -m "fix: short description of what you fixed"
    git push -u origin fix-name-of-your-bugfix
    ```

5. Open a pull request on GitHub from your branch to `main`

## Pull Request Guidelines

Before submitting a pull request:

- Make sure the app still runs locally with `shiny::runApp()`
- If you added new packages, update the `DESCRIPTION` file and regenerate `manifest.json` with `rsconnect::writeManifest()`
- Keep the pull request focused on one thing so it is easier to review

## Write Documentation

If you notice something unclear in the README or want to improve comments in `app.R`, feel free to open an issue or submit a pull request directly.
