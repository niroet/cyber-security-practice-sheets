#import "template.typ": setup, sheet, cover
#import "ch1.typ": ch1
#import "ch2.typ": ch2a, ch2b
#import "ch3.typ": ch3a, ch3b, ch3c
#import "ch4.typ": ch4
#import "ch5.typ": ch5a, ch5b
#import "ch6.typ": ch6
#import "ch7.typ": ch7a, ch7b

#let tot(s) = s.items.fold(0, (a, it) => a + it.points)

// Cover rows: (chapter-number, label, max-points)
#let chapter-rows = (
  (1, "Foundations", tot(ch1)),
  (2, "Requirements Engineering", tot(ch2a) + tot(ch2b)),
  (3, "Human Security Factors", tot(ch3a) + tot(ch3b) + tot(ch3c)),
  (4, "Empirical Security Research", tot(ch4)),
  (5, "Injection Attacks", tot(ch5a) + tot(ch5b)),
  (6, "Cryptography", tot(ch6)),
  (7, "Authorization", tot(ch7a) + tot(ch7b)),
)

#show: setup

#cover(chapters: chapter-rows)

#let sheets = (ch1, ch2a, ch2b, ch3a, ch3b, ch3c, ch4, ch5a, ch5b, ch6, ch7a, ch7b)
#for s in sheets {
  pagebreak()
  sheet(..s)
}
