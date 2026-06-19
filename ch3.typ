#import "template.typ": item

#let ch3a = (
  chapter: "3",
  title: "Human Security Factors",
  part: "Secure Passwords",
  tag: "3.6",
  slide: 353,
  items: (
    item("a", 3,
      [Explain why using readable *passphrases* consisting only of lowercase letters is generally considered a better alternative to passwords that contain a random mix of letters, numbers, and special characters.],
      [Entropy grows *logarithmically with the alphabet size, but linearly with the length* (`H(ω) = n · log₂|Ω|`). Adding character classes only enlarges the alphabet a little, whereas a long passphrase wins many characters of length — so a long lowercase phrase reaches *more entropy* than a short mixed password. It is also *memorable and easy to type*, so users do not fall back on weak optimisations: the simple "throwing-in-special-characters" passwords are exactly the *patterns/common words* that crackers (e.g. `zxcvbn`) expect, since users are *bad random number generators* and prefer characters they can type. A readable phrase that is long therefore beats a short random string in both real strength and usability.],
      graded: [length beats alphabet size for entropy (linear vs. log) + passphrases are long → high entropy; usable/memorable so users do not pick weak predictable patterns crackers expect.],
      cite: "311, 313, 316"),
    item("b", 2,
      [Name two advantages of *passphrases* (natural-language words) compared to *passwords* (random strings that may include numbers and special characters).],
      [(1) They are *easier to memorise and to type*, since they use natural-language words a user can actually remember. (2) They are *generally longer*, and length contributes linearly to entropy, so they achieve *higher entropy / are harder to guess* while staying user-friendly.],
      graded: [any two of: easier to remember; easier/faster to type; longer ⇒ more entropy / harder to guess.],
      cite: "316, 311"),
    item("c", 3,
      [A common requirement is that passwords be changed regularly, e.g. every 90 days. Assess this requirement regarding its impact on *security* and *user behavior*.],
      [The *intended security gain*: if password hashes leak, forced rotation makes them useless to an attacker after a while. *But the gain is largely undermined by user behaviour*: users cope with frequent changes by using *patterns* to derive similar successor passwords (e.g. incrementing a number). An attacker who knows one old password can then *more easily guess the new ones* (documented by Zhang et al. on a campus SSO system). Forced rotation thus pushes users toward predictable, weaker passwords. *Conclusion (NIST 2024):* do *not* require periodic changes; only force a change after *indicators of compromise*.],
      graded: [name intended benefit (leaked hash becomes stale) BUT users react with predictable patterns/incremental passwords (Zhang campus study) → easier to guess; conclude NIST: change only on evidence of compromise.],
      cite: "314"),
  ),
)

#let ch3b = (
  chapter: "3",
  title: "Human Security Factors",
  part: "User-Centric IT Security",
  tag: "3.7",
  slide: 354,
  items: (
    item("a", 4,
      [Scenario: after a wrong password the login screen shows a large red message: "Warning! `AuthErr\#42`. Contact phone support immediately (Mondays only, 7:00–7:30 a.m.). This error may result in criminal charges!" Below it a single "Agree" button. Name *two* guidelines for user-centric IT security that are violated, and briefly explain each violation.],
      [*G1 — Understandability (open for all users):* the message `AuthErr\#42` is a *short, cryptic error code* with no plain-language explanation; users are not security experts and cannot understand what went wrong or what to do. *G7 — Fearless system:* threatening "criminal charges!" *uses fear to motivate the user* and makes them anxious, instead of promoting a positive, cooperative attitude. (Also defensible: *G8 — educated reaction on user errors* — a cryptic message with no healing action and only an "Agree" button gives no step-by-step guidance for the simple error of mistyping a password.)],
      graded: [two distinct guidelines named + matched to scenario: G1 (cryptic code, not understandable) and G7 (fear-mongering "criminal charges"); G8 (no helpful guidance/healing on a user error) also accepted.],
      cite: "320, 322, 329, 330"),
    item("b", 4,
      [Scenario: opening `https://example.org` the browser shows only a red box "Warning! `TLS Error \#13`." — no other buttons or controls. Refer to a violated guideline for user-centric IT security, explain why it is violated, and give a specific proposal to fix it.],
      [Violated: *G5 — Only informed decisions.* The user is *given no information* (just a cryptic code) and *no way to act* — yet is effectively forced to abandon the task without understanding the risk; the system neither provides the necessary information nor lets the user make an informed choice. *(G1 understandability is likewise violated by the cryptic code.)* *Proposal:* follow the slide's example of *browser certificate warnings* — explain in plain language what is wrong (e.g. the site's TLS certificate could not be verified, so the connection may be insecure) *and* offer real options: a "Go back to safety" button and an "Advanced / proceed anyway" option, so the user can make an informed decision.],
      graded: [name G5 (no information + no possible decision) [G1 acceptable too]; concrete fix = plain-language explanation of the risk plus actionable buttons (back / proceed), like browser certificate warnings.],
      cite: "320, 326, 327"),
  ),
)

#let ch3c = (
  chapter: "3",
  title: "Human Security Factors",
  part: "Attacking Human Weaknesses",
  tag: "3.8",
  slide: 355,
  items: (
    item("a", 4,
      [The *Robin Sage* example shows social engineering on a social network to obtain contacts and sensitive information. Name *two* of *Cialdini's Principles of Persuasion* and describe how attackers apply each when creating a fake profile.],
      [*Authority:* people tend to obey authority figures. The fake "Robin Sage" listed *high-status credentials* (a "Cyber threat analyst" at the Naval Network Warfare Command, MIT graduate, 10 years' experience), so targets trusted and complied with the seemingly senior expert. *Consensus / social proof:* people conform to their group's norms. After connecting with a few real professionals, the *visible list of mutual, reputable contacts* (executives at NSA, DOD, Global 500 firms) made the profile look legitimate, so others followed and accepted requests too. *(Also applicable: Liking — an attractive 25-year-old persona makes people more willing to be persuaded.)*],
      graded: [two distinct Cialdini principles named + concrete Robin-Sage application each: e.g. Authority (fake elite credentials/job) and Consensus/social proof (chain of reputable mutual contacts); Liking/Scarcity etc. also valid if tied to the profile.],
      cite: "344, 345, 347"),
    item("b", 3,
      [Outline a social engineering attack on a *university campus* based on one of Cialdini's Principles of Persuasion. Name the principle and describe the attack in one or two sentences.],
      [*Principle: Authority.* The attacker walks the campus *dressed as IT support staff* (badge/lanyard), tells a student their account shows a problem and that "the dean's office needs it fixed now", and asks them to log in or hand over their password on a prepared laptop — the assumed authority and urgency make the student comply. *(Alternatives: Reciprocity — hand out free USB sticks/coffee then ask a "small favour"; Liking — a friendly peer asks to "borrow" library/exam access.)*],
      graded: [one principle clearly named + a coherent campus attack that actually uses it (e.g. Authority via fake IT/staff impersonation); brief and concrete.],
      cite: "344"),
  ),
)
