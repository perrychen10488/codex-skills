# Codex Skills

Reusable skills for Codex.

## Available skills

- `create-linguistics-project`: scaffold a structured linguistics research project.
- `fetch-academic-paper`: retrieve a legitimate academic PDF by DOI through the
  separately installed `academic-paper-fetch` CLI.
- `rebuild-cv-in-latex`: rebuild a CV as an editable Overleaf project using a reference document's visual style while preserving the source content.

## Install

Clone this repository, then copy or link the desired skill directory into your Codex skills directory.

On PowerShell:

```powershell
git clone https://github.com/perrychen10488/codex-skills.git
Copy-Item -Recurse .\codex-skills\create-linguistics-project "$HOME\.codex\skills\"
```

Restart Codex after installation. You can then ask Codex to create a linguistics research project, or invoke `$create-linguistics-project` explicitly.

## Fetch academic papers

Set up the sibling `academic-paper-fetch` uv project:

```powershell
cd ..\academic-paper-fetch
uv python install 3.11
uv sync
$env:ACADEMIC_PAPER_FETCH_DIR=(Resolve-Path .).Path
uv run academic-paper-fetch doctor --json
```

The CLI pins Python 3.11 in `.python-version` and dependencies in `uv.lock`. Set
`ACADEMIC_PAPER_FETCH_DIR` before launching Codex, or keep the CLI as a uniquely
identifiable sibling checkout so the skill can resolve it.

Configure Unpaywall and any optional publisher API keys through environment
variables:

```powershell
$env:UNPAYWALL_EMAIL="you@example.com"
$env:ELSEVIER_API_KEY="..."
$env:WILEY_TDM_TOKEN="..."
$env:SPRINGER_API_KEY="..."
```

Install the skill into Codex:

```powershell
cd ..\codex-skills
Copy-Item -Recurse .\fetch-academic-paper "$HOME\.codex\skills\"
```

Restart Codex, then invoke it explicitly or ask naturally:

```text
Use $fetch-academic-paper to fetch 10.1186/s12984-023-01168-x.
幫我下載 DOI 10.1186/s12984-023-01168-x 的論文 PDF。
```

The CLI can also be called directly:

```powershell
uv run --project "$env:ACADEMIC_PAPER_FETCH_DIR" academic-paper-fetch fetch `
  10.1186/s12984-023-01168-x --json
```
