# ecodex

ecodex is a minimal CLI wrapper around the Codex CLI that lets you run GPT-5 prompts and capture the results in GitHub issues or comments. Each post records the ecodex version (from `git describe`) and the timestamp so you can trace responses back to the binary that produced them.

## Prerequisites
- [Codex CLI](https://github.com/openai/codex-cli) (`codex` command) configured for the `gpt-5` model
- [GitHub CLI](https://cli.github.com/) (`gh`) authenticated for the target repository
- [`jq`](https://stedolan.github.io/jq/) for parsing issue payloads
- Optional: `script` command (from util-linux) for Codex fallback execution

## Installation
```sh
./setup.sh           # installs into /usr/local/bin by default
# or
make install         # honours PREFIX, e.g. make install PREFIX=$HOME/.local/bin
```

## Usage
Run with an inline prompt and create a new issue:
```sh
ecodex --prompt "Summarise the open pull requests" --repo owner/repo --title "Codex summary"
```

Pipe a prompt from stdin:
```sh
echo "List next actions" | ecodex --repo owner/repo
```

Use an existing issue as the prompt source and comment back on it:
```sh
ecodex --prompt-issue https://github.com/owner/repo/issues/42 --attach-prompt
```

Background mode runs the request under `nohup`, writes logs to `~/.ecodex/logs/<RUN_ID>.log`, and prints the identifiers:
```sh
ecodex --prompt "Generate release notes" --repo owner/repo --bg
# RUN_ID=20240101123000-12345
# LOG=/home/user/.ecodex/logs/20240101123000-12345.log
```
Follow the logs with:
```sh
ecodex-log 20240101123000-12345
```

Dry-run to inspect the GitHub body without posting:
```sh
ecodex --prompt "Draft a changelog" --dry-run
```

## Testing
A quick integration test is available:
```sh
ecodex --test
```
The test invokes Codex, embeds the current ecodex version and UTC timestamp in the prompt, writes the transcript to `~/.ecodex/logs/last-run.log`, and prints a `hello world` response without touching GitHub.
