# academic_assistant integration

Use `academic-paper-fetch` as an external CLI. Do not copy its Python implementation
into `academic_assistant` and do not write directly to the project's repository or
Supabase tables.

## Resolve the paper

Prefer the normalized `Article.doi`. If it is absent, inspect `landing_url`,
`source_record_id`, or other source metadata for a DOI. Do not infer a DOI from title
similarity without verifying it through a scholarly metadata source.

## Resolve the output path

Read `PDF_STORAGE_DIR` from the project's active environment or `.env`; default to
`<project-root>/pdfs`. Create a stable filename from the DOI unless the user requests
a title-based filename:

```text
<PDF_STORAGE_DIR>/<source>/<DOI with unsafe path characters replaced>.pdf
```

The CLI creates parent directories and atomically replaces only when `--force` is
explicitly passed.

## CLI contract

Call:

```powershell
uv run --project "<CLI_PROJECT_DIR>" academic-paper-fetch fetch "<DOI>" --output "<PATH>" --json
```

Resolve `<CLI_PROJECT_DIR>` using `ACADEMIC_PAPER_FETCH_DIR` or a unique sibling
checkout, as described in the parent skill. The checkout must contain
`pyproject.toml`, `uv.lock`, and `.python-version`.

Parse exactly one JSON object from stdout. Schema version 1 contains:

- `ok`, `doi`, `route`, `tried`, `attempts`
- `path`, `bytes`, `sha256`
- `resolver_url`, `error_category`, `message`, `elapsed_s`

Exit codes are `0` success/cache, `1` input/config, `2` exhausted, `3` transient,
and `4` filesystem. Preserve this boundary if a future `academic_assistant` adapter
invokes the CLI through `subprocess`.
