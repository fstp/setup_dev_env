# Global agent notes

## DeepSeek harness (dsh)

- `dsh` (CLI) and `@deepseek-harness-tui/dsh-tui` (TUI bundle) are installed globally with npm.
- Launch the TUI with `dsh --profile dsh-tui`.
- Profiles live in `~/.dsh/profiles/<name>/`: a `cordis.yml` root entry list (usually `[]`)
  plus `cordis.patch.yml`, applied after every bundle layer.
- Patch entries either override an existing row by id (`- id: x` with `disabled` / `config`)
  or append rows with a top-level `- insert:` list. A bare row carrying a new id is silently
  ignored — that mistake costs an hour when it bites.
- The `dsh-tui` profile's `cordis.patch.yml` is a symlink into this repo; edit the repo copy,
  not the one under `~/.dsh`. That patch enables the `agent-instructions` row, which is why
  this file (and project `AGENTS.md` files from repo root down to cwd) load each session,
  capped at 64 KB.
- Transcripts live in `~/.dsh/sessions/<cwd-slug>/<session-id>/session.v4.jsonl.zstd`. They
  are **concatenated zstd frames**, so decompress with `zstd -dc`; a single-frame decompressor
  silently returns only the first line. Resume with `dsh tui --resume <session-id>`.
- Credentials: `DEEPSEEK_API_KEY` is read from `~/.dsh/.env`.

## Memory (cavemem)

- Local SQLite store at `~/.cavemem/data.db`; exposed to the agent as MCP tools
  `mcp__cavemem__search`, `mcp__cavemem__timeline`, `mcp__cavemem__get_observations`,
  `mcp__cavemem__list_sessions`.
- cavemem has no hook into dsh, so **nothing is captured automatically**. Store a fact with:
  `printf '%s' '{"session_id":"manual","prompt":"<fact>"}' | cavemem hook run user-prompt-submit`
- Search memory before asking the user to repeat something from an earlier session.
- Semantic ranking needs `@xenova/transformers` resolvable from cavemem's install (the
  playbook installs it globally). A fresh MCP process loads the embedder in ~2 s; one started
  before that package existed stays keyword-only until it restarts.

## Workstation extras (not created by the playbook)

Check that these exist before relying on them — they are only on fstp's workstation:

- `~/.pw/pw.mjs` — Playwright CLI attached to the real Chrome on `http://127.0.0.1:9222`.
  That Chrome carries the user's profile, cookies and logins: treat it as their live browser
  and never launch a second one (a fresh profile has no logins).
  Commands: `pages | goto <url> [--new] | text | eval <expr> | shot <out.png> [--full] |
  click <selector> | fill <selector> <value> | press <key> | wait <selector>`, plus
  `--page=<url substring>` to pick a tab. Selectors are Playwright engines: CSS, `text=`,
  `role=button[name="Send"]`, `xpath=`.
- `~/bin/mem` — `mem add "<fact>"` / `mem search "<query>"`, wrapping the cavemem hook.
- `~/bin/mem-wrap` — heuristic end-of-session digest, run by `~/bin/dsh-tui` after the TUI
  exits. Deduped per session; `--dry-run` previews, `--force` re-stores.

Gotchas learned the hard way:

- **Telegram Web ignores synthetic `el.click()`** — it needs real mouse events. Playwright's
  `click` works; `element.click()` silently does nothing.
- **Screenshots:** Playwright's `shot` works even when the window is minimised; raw CDP
  `Page.captureScreenshot` can hang forever in that state.
- **SPAs** (e.g. ICA.se) may ignore query-string search. Their real data is often embedded in
  `window.__INITIAL_DATA__` / `__NEXT_DATA__` — read it with `eval` instead of scraping DOM.
- Each `bash` tool call gets its **own private `/tmp`**; files written there do not survive to
  the next call. Write scratch files into the workspace instead.

## Context

- Timezone `Europe/Stockholm`; the user works with Swedish services (e.g. ICA.se) but usually
  writes to the agent in English.
