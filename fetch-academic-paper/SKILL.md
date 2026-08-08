---
name: fetch-academic-paper
description: Fetch a legitimate academic full-text PDF by DOI through the academic-paper-fetch CLI, using open-access sources first and optional official publisher APIs. Use when Codex is asked to download, retrieve, obtain, or troubleshoot an academic paper PDF, including a paper selected from an academic_assistant project or Article record.
---

# Fetch an academic paper

Use the separately checked-out `academic-paper-fetch` uv project. Do not implement
download routes inside this skill.

## Workflow

1. Obtain a DOI from the request, a DOI URL, or the selected paper's `doi` field. Ask
   for a DOI only when none can be found.
2. Determine the output path:
   - Honor a path explicitly supplied by the user.
   - For an `academic_assistant` project, read `PDF_STORAGE_DIR` from its environment
     configuration and place the PDF there.
   - Otherwise allow the CLI to use its configured `output_dir`.
3. Resolve the CLI project directory. Prefer `ACADEMIC_PAPER_FETCH_DIR`; otherwise
   locate a sibling `academic-paper-fetch` checkout. Require `pyproject.toml`,
   `uv.lock`, and `.python-version`. Ask for the path if no unique checkout exists.
4. Verify the CLI configuration before the first fetch:

   ```powershell
   uv run --project "<CLI_PROJECT_DIR>" academic-paper-fetch doctor --json
   ```

5. Fetch exactly one paper and require JSON output:

   ```powershell
   uv run --project "<CLI_PROJECT_DIR>" academic-paper-fetch fetch "<DOI>" --json
   ```

   Add `--output "<PATH>"` when an explicit path was selected. Add `--force` only
   when the user explicitly asks to replace or re-download an existing valid PDF.
6. Parse the single JSON envelope from stdout. Treat stderr as diagnostic text, not
   as an API response.
7. Report the saved path, successful route, byte count, and SHA-256. On failure,
   distinguish configuration errors, exhausted routes, transient failures, and
   filesystem errors using `error_category` and the process exit code.

Use the current local checkout. Do not run `git pull`, change branches, or update the
CLI repository unless the user explicitly requests an update. `uv run` may synchronize
the project environment from its committed lockfile.

## Failure handling

- Exit `1`: correct the DOI or non-secret configuration. Never request that a user
  paste API keys into chat.
- Exit `2`: report that all configured legitimate routes were exhausted. Offer the
  returned `resolver_url` for manual library access when present.
- Exit `3`: retry once after respecting any reported rate-limit delay. Stop after a
  repeated transient failure.
- Exit `4`: verify the exact output directory and permissions before retrying.

Read [references/academic-assistant-integration.md](references/academic-assistant-integration.md)
when the request involves an `academic_assistant` project or its `Article` records.

## Safety boundaries

- Fetch only a user-requested paper; do not batch or parallelize downloads.
- Use only open-access sources and official publisher APIs configured by the user.
- Never add or suggest Sci-Hub, credential sharing, paywall bypasses, or rate-limit
  evasion.
- Never print, log, commit, or place API keys in command arguments.
- Do not claim that failure means the paper does not exist or that the user lacks
  entitlement; it only means the configured routes did not return a valid PDF.
