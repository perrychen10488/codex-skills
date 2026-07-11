# Codex Skills

Reusable skills for Codex.

## Available skills

- `create-linguistics-project`: scaffold a structured linguistics research project.

## Install

Clone this repository, then copy or link the desired skill directory into your Codex skills directory.

On PowerShell:

```powershell
git clone https://github.com/perrychen10488/codex-skills.git
Copy-Item -Recurse .\codex-skills\create-linguistics-project "$HOME\.codex\skills\"
```

Restart Codex after installation. You can then ask Codex to create a linguistics research project, or invoke `$create-linguistics-project` explicitly.
