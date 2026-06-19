// template.typ — styling + foldable practice-sheet layout.
// One sheet = one A4 page: questions in the TOP half, answers in the BOTTOM half,
// a dashed fold line at the exact paper middle. Fold the bottom half behind the top
// to hide the answers, unfold to self-correct.

#let accent = rgb("#005599")
#let gradedcol = rgb("#1a7f37")

// Symmetric vertical margins => content midline == paper's physical fold line.
#let setup(body) = {
  set page(paper: "a4", margin: (x: 15mm, y: 12mm))
  set text(font: ("Libertinus Serif", "Liberation Serif", "DejaVu Serif"), size: 10pt, lang: "en")
  set par(justify: false, leading: 0.55em)
  body
}

// One question/answer record.
#let item(label, points, q, a, graded: none, cite: none) = (
  label: label, points: points, q: q, a: a, graded: graded, cite: cite,
)

#let ptag(n) = box(text(fill: accent, weight: "bold", size: 0.82em)[(#n P)])

#let labelcell(l) = text(weight: "bold", fill: accent)[#l)]

// a fill-in blank (underline) of given width
#let blank(w) = box(width: w, stroke: (bottom: 0.6pt + gray), outset: (bottom: 1pt))

// The fold line drawn across the seam between the two halves.
#let foldline = {
  place(top + left, dy: 50%, dx: -15mm,
    box(width: 100% + 30mm)[
      #set align(horizon)
      #grid(columns: (1fr, auto, 1fr), column-gutter: 4pt,
        line(length: 100%, stroke: (paint: gray, dash: "dashed", thickness: 0.5pt)),
        text(size: 8pt, fill: gray)[✂ fold here],
        line(length: 100%, stroke: (paint: gray, dash: "dashed", thickness: 0.5pt)),
      )
    ])
}

#let sheet(chapter: "", title: "", tag: "", slide: 0, items: (), part: none, intro: none, answer-size: 10pt) = {
  let total = items.fold(0, (s, it) => s + it.points)

  // ---- TOP HALF: header + questions ----
  let tophalf = {
    grid(columns: (1fr, auto), align: (left + bottom, right + bottom),
      [#text(size: 13pt, weight: "bold", fill: accent)[Ch.#chapter · #title]
       #if part != none [ #text(size: 11pt, fill: gray)[ — #part]]],
      [#text(size: 9pt, fill: gray)[#tag · slide p.#slide · max #total P]],
    )
    v(2pt)
    line(length: 100%, stroke: (paint: accent, thickness: 1pt))
    v(6pt)
    if intro != none {
      block(width: 100%, inset: 5pt, radius: 3pt, fill: rgb("#f4f4f4"))[#intro]
      v(5pt)
    }
    text(size: 8pt, fill: gray, style: "italic")[Answer in the space below each question; fold along the line to check.]
    v(6pt)
    for it in items {
      grid(columns: (auto, 1fr), column-gutter: 6pt, align: (left + top, left + top),
        labelcell(it.label),
        [#it.q #h(3pt) #ptag(it.points)],
      )
      v(6pt)        // minimum separation
      v(1fr)        // flexible pen-writing space, spread evenly down the half
    }
  }

  // ---- BOTTOM HALF: answers (auto-fit to the half so it never reaches the page edge) ----
  let head = {
    text(size: 9pt, weight: "bold", fill: gradedcol)[ANSWERS]
    h(6pt)
    text(size: 8pt, fill: gray)[(your score: #blank(10mm) / #total P)]
  }
  // answer items; vertical spacing is em-relative so it scales with the font size
  let answers-content = {
    for it in items {
      grid(columns: (auto, 1fr), column-gutter: 6pt, align: (left + top, left + top),
        labelcell(it.label),
        [#it.a
         #if it.graded != none [#linebreak()#text(fill: gradedcol, weight: "bold", size: 0.85em)[✓ Likely graded:] #text(size: 0.9em)[#it.graded]]
         #if it.cite != none [ #text(size: 0.8em, fill: gray)[\[p.#it.cite\]]]
         #h(1fr) #text(fill: accent, size: 0.85em)[#blank(7mm)/#it.points]
        ],
      )
      v(0.5em)
    }
  }
  // Geometry constants for the auto-fit (derived from the page setup below):
  //   A4 210mm wide, x-margin 15mm  -> content width 180mm
  //   A4 297mm tall, y-margin 12mm  -> content 273mm; each fold-half 136.5mm
  //   minus the "ANSWERS" header + gaps -> ~126mm of answer height per half.
  // If you change the page margins in `setup`, update these two values.
  let content-w = 180mm
  let answer-h = 126mm
  // clip is a hard safety net; auto-fit aims to make it unnecessary
  let bottomhalf = block(width: 100%, height: 100%, clip: true)[#context {
    let base = answer-size
    let needed = measure(box(width: content-w, text(size: base, answers-content))).height
    let fsize = if needed > answer-h { calc.max(base * (answer-h / needed), 8pt) } else { base }
    v(7pt)            // clear the fold line
    head
    v(4pt)
    set text(size: fsize)
    answers-content
  }]

  block(width: 100%, height: 100%)[
    #foldline
    #grid(columns: 1, rows: (1fr, 1fr), row-gutter: 0pt,
      tophalf,
      bottomhalf,
    )
  ]
}

// ---- Cover / title sheet with the grading key ----
#let cover(chapters: ()) = {
  let grand = chapters.fold(0, (s, c) => s + c.at(2))
  set align(center)
  v(10mm)
  text(size: 22pt, weight: "bold", fill: accent)[Cybersecurity — Exam Practice Sheets]
  v(3mm)
  text(size: 12pt)[Security of Mobile and Web-based Applications · SoSe 2026]
  v(1mm)
  text(size: 10pt, fill: gray)[Prof. Dr. Thomas Hutzelmann · TH Ingolstadt · source slides CC BY 4.0]
  v(8mm)
  set align(left)

  block(width: 100%, inset: 8pt, radius: 4pt, fill: rgb("#eef4fa"))[
    #text(weight: "bold")[How to use]
    #v(2pt)
    Each sheet has the questions on the top half and model answers on the bottom half.
    *Fold the page along the dashed line* to hide the answers while you practice, then unfold
    to self-correct. Score each part using the `____/N` fields, total per chapter, and look up
    your grade below. Slide citations `[p.NNN]` point back to the source deck.
  ]
  v(6mm)

  grid(columns: (1fr, 1fr), column-gutter: 8mm,
    // chapter score table
    [
      #text(weight: "bold", fill: accent)[Your score per chapter]
      #v(3pt)
      #table(columns: (auto, 1fr, auto, auto, auto), inset: 5pt, align: (left, left, center, center, center),
        stroke: 0.5pt + gray,
        table.header([*\#*], [*Chapter*], [*Max*], [*Mine*], [*Grade*]),
        ..chapters.map(c => (str(c.at(0)), c.at(1), [#c.at(2) P], [], [])).flatten(),
        [*Σ*], [*Total*], [*#grand P*], [], [],
      )
    ],
    // grade key
    [
      #text(weight: "bold", fill: accent)[Grading key (% of max points)]
      #v(3pt)
      #table(columns: (auto, auto), inset: 4pt, align: (center, center), stroke: 0.5pt + gray,
        table.header([*≥ %*], [*Grade*]),
        [95], [1.0 — sehr gut],
        [90], [1.3],
        [85], [1.7],
        [80], [2.0 — gut],
        [75], [2.3],
        [70], [2.7],
        [65], [3.0 — befriedigend],
        [60], [3.3],
        [55], [3.7],
        [50], [4.0 — ausreichend],
        [< 50], [5.0 — nicht bestanden],
      )
      #v(3pt)
      #text(size: 8pt, fill: gray)[Point values are an estimate for self-assessment; the real exam weighting is not published.]
    ],
  )
}
