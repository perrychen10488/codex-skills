# Codex Skills

Reusable skills for Codex.

## Available skills

- `create-linguistics-project`: scaffold a structured linguistics research project.
- `fetch-academic-paper`: retrieve a legitimate academic PDF by DOI through the
  separately installed `academic-paper-fetch` CLI.

## Install

Clone this repository, then copy or link the desired skill directory into your Codex skills directory.

On PowerShell:

```powershell
git clone https://github.com/perrychen10488/codex-skills.git
Copy-Item -Recurse .\codex-skills\create-linguistics-project "$HOME\.codex\skills\"
```

Restart Codex after installation. You can then ask Codex to create a linguistics research project, or invoke `$create-linguistics-project` explicitly.

## Fetch academic papers

Create the companion CLI environment from the sibling `academic-paper-fetch` repo:

```powershell
cd ..\academic-paper-fetch
conda env create -f environment.yml
conda activate academic-paper-fetch
academic-paper-fetch doctor --json
```

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
conda run -n academic-paper-fetch academic-paper-fetch fetch `
  10.1186/s12984-023-01168-x --json
```
