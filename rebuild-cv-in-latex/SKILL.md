---
name: rebuild-cv-in-latex
description: Rebuild a CV or academic resume as an editable Overleaf LaTeX project by extracting content from a source PDF or document and reproducing the visual system of a separate reference PDF. Use when an agent must preserve the CV's wording and section order, transfer only the reference's typography and layout, compile the result, and verify the rendered PDF page by page.
---

# Rebuild a CV in LaTeX

Create an editable, portable Overleaf project whose content comes from the source CV and whose visual system comes from the reference document.

## Establish the contract

Identify these inputs before editing:

- source CV: authoritative content
- reference document: authoritative presentation
- requested output: normally a ZIP containing `main.tex` and required assets, plus a compiled PDF preview

Treat “keep the content unchanged” as a strict constraint. Preserve wording, capitalization, punctuation, dates, section order, URLs, and item order. Do not silently correct grammar, normalize dates, add sections, remove details, or rewrite bullets. Ask before making content changes.

## Inspect both documents

Use PDF/document inspection tools appropriate to the environment. For PDFs:

1. Run `pdfinfo` to record page size, page count, and metadata.
2. Run `pdftotext -layout` to recover text and approximate alignment.
3. Render every page to PNG at about 144 DPI with `pdftoppm`.
4. Inspect the rendered pages visually.

Build two separate inventories:

- Content inventory from the source: header fields, sections, entries, bullets, dates, locations, emphasis, links, and deliberate page breaks.
- Style inventory from the reference: paper size, margins, font families, approximate font sizes, line spacing, heading rules, indentation, bullet geometry, left/right columns, emphasis, link appearance, density, and pagination behavior.

Read [references/style-mapping.md](references/style-mapping.md) for the mapping and preservation checklist.

## Implement the Overleaf project

Create a minimal project:

```text
project/
├── main.tex
└── assets/        # only when required
```

Do not add a README unless the user requests one. Keep dependencies available in a standard Overleaf installation.

Prefer reusable LaTeX commands for repeated structures such as section headings, left/right entry rows, dated entries, and bullet lists. Keep content as plain, editable LaTeX rather than embedding source pages as images.

Choose the compiler intentionally:

- Use XeLaTeX or LuaLaTeX when system/OpenType fonts or Unicode text require them.
- Use pdfLaTeX when standard TeX fonts are sufficient and portability is better.

If the exact reference font is unavailable, choose a metrically and visually similar Overleaf-safe font. Do not bundle a commercial font without permission. Record the required compiler in the handoff.

Escape LaTeX special characters without changing visible content. Preserve URLs as clickable links when possible, matching the reference's visible color and decoration.

## Separate content from style

Apply only presentation changes from the reference:

- page geometry and paper size
- fonts, sizes, weights, and italics
- heading treatment and rules
- alignment and columns
- spacing, indentation, and bullet style
- link styling
- page-break strategy

Never infer that a reference section such as `SUMMARY`, `PUBLICATIONS`, or `ACTIVITIES` should be added to the source CV. Never reorder the source sections merely because the reference uses a different order, unless the user explicitly asks.

## Compile and visually verify

Compile with the selected engine twice. Stop on LaTeX errors. Then:

1. Confirm page size and page count with `pdfinfo`.
2. Check the log for overfull boxes, missing glyphs, substituted fonts, and broken links.
3. Render every output page to PNG.
4. Inspect every page for collisions, clipped text, awkward wrapping, orphan headings, excessive blank space, incorrect alignment, and unintended page breaks.
5. Compare the output with both authorities: text against the source CV and appearance against the reference.
6. Iterate until there are no visible defects.

Use text extraction or a normalized text diff as an additional content check. Account for expected extraction differences caused by bullets, ligatures, line wrapping, and URL encoding; investigate all substantive differences.

## Deliver

Package only the files needed by Overleaf. Provide:

- Overleaf-ready ZIP
- compiled PDF preview
- `main.tex` separately when useful
- one concise compiler instruction

State any unavoidable font substitution or material layout deviation. Do not claim pixel-perfect reproduction when source font data or editable originals are unavailable.
