# GitHub Action: Run credo with reviewdog

[![Release](https://img.shields.io/github/release/red-shirts/reviewdog-action-credo.svg?maxAge=43200)](https://github.com/red-shirts/reviewdog-action-credo/releases)

This action runs [credo](https://github.com/rrrene/credo) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

## Prerequisites

As of `v7`, this is a **composite action** that runs inside your existing
Elixir/OTP toolchain rather than a pinned Docker image. Before invoking it,
your workflow must:

1. Check out the repository.
2. Set up Elixir/OTP via [`erlef/setup-beam@v1`](https://github.com/erlef/setup-beam)
   so the consumer's exact toolchain is used.
3. Install Hex dependencies with `mix deps.get`. `credo` must be in your `mix.exs`
   deps (typically `{:credo, "~> 1.7", only: [:dev, :test], runtime: false}`).

This removes the version-drift problems that plagued the Docker-based versions —
the action now uses whatever Elixir/OTP/credo version your project uses.

## Inputs

### `github_token`

**Required**. Must be in form of `github_token: ${{ secrets.github_token }}`.

### `level`

Optional. Report level for reviewdog [`info`, `warning`, `error`]. Defaults to
`error`. Same as `-level` flag of reviewdog. Also controls `-fail-level` so the
job fails when issues at or above this level are reported.

### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`, `github-pr-review`].
Defaults to `github-pr-check`. `github-pr-review` can use Markdown and adds a
link to the rule page in reviewdog reports.

## Example usage

### `.github/workflows/reviewdog.yml`

```yml
name: reviewdog
on: [pull_request]

permissions:
  contents: read
  pull-requests: write
  checks: write

jobs:
  credo:
    name: runner / credo
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: erlef/setup-beam@v1
        with:
          otp-version: "28.1"
          elixir-version: "1.19.5"
      - name: Install dependencies
        run: mix deps.get
      - name: credo
        uses: red-shirts/reviewdog-action-credo@v7
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          reporter: github-pr-review
          level: warning
```

## Migrating from v6

* The action no longer ships its own Elixir, OTP, rebar3, or credo. Add an
  `erlef/setup-beam@v1` step and a `mix deps.get` step (most workflows already
  have these).
* Input names are unchanged — bumping the tag from `@v6` to `@v7` is otherwise
  a drop-in upgrade.
