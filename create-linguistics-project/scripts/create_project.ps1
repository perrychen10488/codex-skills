[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$ProjectName,

    [string]$BaseDirectory = (Join-Path ([Environment]::GetFolderPath('MyDocuments')) 'Project')
)

$invalidChars = [System.IO.Path]::GetInvalidFileNameChars()
if ($ProjectName.IndexOfAny($invalidChars) -ge 0 -or $ProjectName -in @('.', '..')) {
    throw "ProjectName must be a valid folder name without path separators."
}

$projectDir = Join-Path $BaseDirectory $ProjectName
if (Test-Path -LiteralPath $projectDir) {
    throw "Project '$ProjectName' already exists at $projectDir"
}

$folders = @(
    'data/raw',
    'data/processed',
    'scripts',
    'notebooks',
    'results',
    'figures',
    'references'
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Path (Join-Path $projectDir $folder) -Force | Out-Null
}

$readme = @"
# $ProjectName

## Overview

A linguistics research project.

## Project structure

- `data/raw/`: original, unmodified data
- `data/processed/`: cleaned and transformed data
- `scripts/`: analysis and utility scripts
- `notebooks/`: Jupyter or R Markdown notebooks
- `results/`: output files and analysis results
- `figures/`: generated plots and visualizations
- `references/`: papers, dictionaries, and reference materials

## Data sources

- [ ] Describe the corpus or dataset.

## Methodology

- [ ] Describe the linguistic analysis methods.

## Setup

    pip install -r requirements.txt

## References

- [ ] Add references.
"@
Set-Content -LiteralPath (Join-Path $projectDir 'README.md') -Value $readme -Encoding utf8

$requirements = @'
# Core data science
pandas>=2.0
numpy>=1.24
scipy>=1.11
scikit-learn>=1.3

# NLP and linguistics
nltk>=3.8
spacy>=3.7
gensim>=4.3
conllu>=4.5
lxml>=4.9
beautifulsoup4>=4.12

# Visualization and notebooks
matplotlib>=3.7
seaborn>=0.12
plotly>=5.15
jupyter>=1.0
notebook>=7.0
ipykernel>=6.25
'@
Set-Content -LiteralPath (Join-Path $projectDir 'requirements.txt') -Value $requirements -Encoding utf8

$gitignore = @'
data/raw/
*.csv
*.tsv
*.json
*.xml
*.zip
*.gz
__pycache__/
*.py[cod]
*.egg-info/
.env
.venv/
venv/
.ipynb_checkpoints/
.Rhistory
.RData
*.Rproj.user/
.DS_Store
Thumbs.db
'@
Set-Content -LiteralPath (Join-Path $projectDir '.gitignore') -Value $gitignore -Encoding utf8

Set-Content -LiteralPath (Join-Path $projectDir 'scripts/README.md') -Encoding utf8 -Value @'
# Scripts

Place analysis and utility scripts here. Use numbered prefixes when execution order matters.
'@

Set-Content -LiteralPath (Join-Path $projectDir 'notebooks/README.md') -Encoding utf8 -Value @'
# Notebooks

Place Jupyter or R Markdown notebooks here. Use numbered prefixes to show the intended order.
'@

Write-Output $projectDir
