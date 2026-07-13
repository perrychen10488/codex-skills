# Style mapping and preservation checklist

## Authority map

| Element | Authority |
| --- | --- |
| Names, contact details, prose, dates, institutions | Source CV |
| Section names and order | Source CV |
| Entry and bullet order | Source CV |
| Paper size and margins | Reference document |
| Typography and hierarchy | Reference document |
| Rules, columns, indentation, spacing | Reference document |
| Natural versus explicit page breaks | Reference style, constrained by readable output |

## Source content ledger

Record each item before implementation:

- header lines and link targets
- section heading spelling and order
- every entry in order
- every bullet in order
- left/right metadata pairs
- bold and italic spans that carry meaning
- page-boundary content that may be accidentally omitted

Pay special attention to text split across PDF pages. A bullet that begins on one page and continues on the next remains one bullet unless the source visibly treats it otherwise.

## Reference style ledger

Measure or estimate:

- physical page dimensions
- top, bottom, left, and right margins
- body font and size
- name/header font and size
- section heading size, case, weight, and rule thickness
- vertical space before and after headings
- bullet symbol, left margin, and hanging indent
- right-column width and alignment
- entry spacing
- link color and decoration
- header/footer and page numbering

## Content verification

Before delivery, confirm:

- no source section was added, removed, renamed, or reordered
- no entry or bullet was added, removed, merged, or split semantically
- dates and locations remain verbatim
- punctuation, capitalization, and spelling remain verbatim
- URLs still target the original destinations
- Unicode characters render correctly

## Visual verification

Inspect every rendered page at readable zoom:

- headings do not collide with horizontal rules
- right-aligned dates do not wrap unnecessarily
- institution names and locations remain visually paired
- bullets align consistently
- no text crosses margins
- no heading is stranded at a page bottom
- page breaks do not lose list items or duplicate content
- blank space is consistent with the reference's density
