# Cybersecurity Exam Practice Sheets

Foldable, self-correcting practice sheets built from the *Exemplary Exam Questions* in
`handout_cyber_security.pdf` (Security of Mobile and Web-based Applications, SoSe 2026,
[Prof. Dr. Thomas Hutzelmann](https://github.com/hutzelmann), TH Ingolstadt — source slides CC BY 4.0).

## What this is

`practice_sheets.pdf` — 13 A4 pages:

- **Page 1** — cover with a per-chapter score table and the grading key.
- **Pages 2–13** — one sheet per exam-question block (Chapters 1–7). Chapter 2 (9 parts)
  and Chapter 7 (6 detailed parts) are each split across two sheets so the answers stay
  readable; every other block is a single sheet.

Answer text is **auto-fit** to the bottom half — the template scales the font down only
as much as needed so answers always stay inside the printable area (verified: every page
keeps ≥17 mm clear of the bottom edge, well within any printer's margins).

Each sheet has the **questions on the top half** and **model answers on the bottom half**,
split by a dashed fold line at the exact paper middle.

## How to use

1. Print single-sided (A4).
2. **Fold each page along the dashed `✂ fold here` line** so the answer half goes behind
   the question half.
3. Answer the questions, then unfold to self-correct.
4. Score each part with the `___/N` fields, total per chapter, and read off your grade
   from the cover's grading key.

Each answer **bolds the key terms**, gives a `✓ Likely graded:` line (what earns marks),
and cites the source slide(s) as `[p.NNN]` so you can check against the original deck.

> Point values are an estimate for self-assessment — the real exam weighting is not
> published. One answer (Ch.6 d, "actually arrives and was read") is partly outside the
> slides and is marked `(not on slides)`.

## Rebuild

Requires [Typst](https://typst.app) (built with 0.14.2):

```sh
typst compile main.typ practice_sheets.pdf
```

## Files

| File | Purpose |
|------|---------|
| `main.typ` | assembles the cover + all sheets in order |
| `template.typ` | layout: the foldable `sheet(...)` function, `cover(...)`, styling |
| `ch1.typ … ch7.typ` | question + answer content per chapter (`ch3`/`ch5` hold several sheets) |
| `practice_sheets.pdf` | the built booklet |

## License & attribution

The exam questions are © Prof. Dr. Thomas Hutzelmann (TH Ingolstadt), from his lecture
*Security of Mobile and Web-based Applications*, published under **CC BY 4.0**. This
repository is an unofficial derivative study aid (his questions + added answers and
typesetting). It is released under the same **CC BY 4.0** license. See [LICENSE.md](LICENSE.md)
for full attribution, terms, and disclaimer.

## Editing

To change wording, points, or answers, edit the relevant `chN.typ` and recompile. The
answer font auto-fits per sheet, so you don't need to tune sizes by hand. If you change
the page margins in `template.typ` (`setup`), update the `content-w` / `answer-h`
constants next to the auto-fit code so the fit stays accurate.
