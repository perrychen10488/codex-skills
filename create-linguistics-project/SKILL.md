---
name: create-linguistics-project
description: Create a structured linguistics research project with folders for data, scripts, notebooks, results, figures, and references. Use when Codex is asked to create, initialize, scaffold, or set up a new project for linguistic, corpus, NLP, or language-data analysis.
---

# Create a linguistics project

1. Obtain the project name if the user did not provide one.
2. Use `scripts/create_project.ps1` to create the project:

   ```powershell
   pwsh -File "<SKILL_DIR>/scripts/create_project.ps1" -ProjectName "<PROJECT_NAME>"
   ```

3. If the user specifies a parent directory, pass it with `-BaseDirectory`:

   ```powershell
   pwsh -File "<SKILL_DIR>/scripts/create_project.ps1" -ProjectName "<PROJECT_NAME>" -BaseDirectory "<PARENT_DIRECTORY>"
   ```

4. Report the full path and summarize the generated structure.

The default parent directory is `Project` inside the current user's Documents folder. Never overwrite an existing project. If the destination exists, report the conflict and ask the user for another name or location.
