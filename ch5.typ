#import "template.typ": item

#let ch5a = (
  chapter: "5",
  title: "Injection Attacks",
  part: "Foundations",
  tag: "5.7",
  slide: 540,
  items: (
    item("a", 1,
      [Name the vulnerability that is checked for by entering the following string: `<script>alert(1);</script>`],
      [*Cross-Site Scripting (XSS)* (CWE-79). The `<script>` tag is injected HTML that, if reflected unescaped into the page, makes the browser *execute the attacker's JavaScript*.],
      graded: [naming *Cross-Site Scripting (XSS)*.],
      cite: "509, 510, 511"),
    item("b", 3,
      [You suspect a SQL Injection vulnerability in a text input field. Provide a string you would submit to test your suspicion and describe briefly which server behavior would confirm the vulnerability.],
      [Submit a string that breaks out of the SQL string literal, e.g. a single `'` or the classic `' OR 1=1 -- `. *Confirmation:* a lone `'` produces a *SQL syntax error* (e.g. an error page / DB error message), and `' OR 1=1 -- ` *returns more rows than expected* (e.g. logs you in / lists all records). Either shows the input is interpreted as *code, not data*.],
      graded: [a payload with `'` (and/or `OR 1=1 -- `) + the confirming behavior: SQL error from the broken quote, or extra/all rows returned.],
      cite: "522, 525, 531"),
    item("c", 3,
      [You suspect a Cross-Site-Scripting (XSS) vulnerability in a text input field. Name a string you could submit to test your suspicion and describe briefly which server behavior would confirm the vulnerability.],
      [Submit `<script>alert(1);</script>` (or an event handler such as `<svg onload=alert(1)>`). *Confirmation:* the application *reflects/stores the string unescaped* into the page so the browser *runs the script* — i.e. the `alert(1)` popup appears. If instead it is returned as escaped text (`&lt;script&gt;`), it is *not* vulnerable.],
      graded: [a `<script>`/event-handler payload + the confirming behavior: the script executes (popup) because the input is reflected unescaped into the page.],
      cite: "510, 511, 514"),
    item("d", 6,
      [Classify the impact a SQL Injection vulnerability in a SELECT query could have on 1) confidentiality, 2) integrity and 3) availability of the data, and describe briefly a concrete action an attacker can take to cause each impact.],
      [*1) Confidentiality:* attacker *reads data not intended for them* — e.g. append `UNION SELECT username, password FROM users` to dump the credential table.
      *2) Integrity:* attacker *alters data* — by *stacking* a second statement (`; UPDATE users SET ...` / `; DELETE FROM ...`) the query is misused to modify or delete records.
      *3) Availability:* attacker *exhausts server resources* — e.g. inject `OR SLEEP(...)` or a very heavy/expensive query so the DB thread is blocked, causing a denial of service.],
      graded: [each of the three attributes named with one concrete action: read foreign data (UNION SELECT), modify/delete data (stacked UPDATE/DELETE), exhaust resources (SLEEP / heavy query → DoS).],
      cite: "524, 525, 527"),
  ),
)

#let ch5b = (
  chapter: "5",
  title: "Injection Attacks",
  part: "Advanced",
  tag: "5.8",
  slide: 541,
  intro: [After a security incident in a web app, the database logs show many recent database queries like the following:
  #v(3pt)
  `SELECT * FROM session WHERE key = 'abc' OR SLEEP(4*7*24*60*60) --';`
  #v(3pt)
  (Note: abc is a valid session key. This is not relevant for the answers.)],
  items: (
    item("a", 2,
      [Mark the complete payload inserted by the attacker.],
      [The injected part after the legitimate value `'abc'`, namely: `OR SLEEP(4*7*24*60*60) --` (a space follows the `--`). It adds an always-evaluated condition and comments out the rest of the original query.],
      graded: [identifying `OR SLEEP(4*7*24*60*60) --` (the part after `'abc'`) as the payload, including the trailing `--` comment.],
      cite: "522, 525"),
    item("b", 2,
      [Name the exact type of attack that was executed here.],
      [A *(time-based) Blind SQL Injection*. The query has no visible output (a session lookup), so the attacker abuses the *timing side-effect* of `SLEEP()`.],
      graded: [naming *SQL Injection*; full marks for *time-based blind SQL injection*.],
      cite: "525, 527, 530"),
    item("c", 3,
      [Describe briefly what this single request and what numerous such requests in a short period of time can cause on the server.],
      [`SLEEP(4*7*24*60*60)` = `4*7*24*60*60` seconds ≈ *4 weeks*. A single request blocks one DB connection/thread asleep for ~4 weeks. *Many* such requests in a short time *occupy all available connections/threads*, *exhausting the server's resources* → the database becomes unresponsive — a *denial of service (DoS)*.],
      graded: [single request = one thread blocked ~4 weeks (4·7·24·60·60 s); many requests = resource/connection exhaustion → DoS / server unresponsive.],
      cite: "527, 532"),
    item("d", 1,
      [Name the security attribute that these queries violate.],
      [*Availability.*],
      graded: [naming *Availability*.],
      cite: "524, 527"),
    item("e", 4,
      [Describe briefly two additional, distinct damages an attacker can inflict based on the underlying vulnerability.],
      [The underlying flaw is *SQL injection* (input used as code), so beyond DoS the attacker can also:
      *1)* harm *confidentiality* — read/dump data not intended for them, e.g. extract the whole database via `UNION SELECT` or bit-by-bit through blind techniques.
      *2)* harm *integrity* — modify or destroy data, e.g. stack `; UPDATE/DELETE/DROP` to change records or drop tables.],
      graded: [two distinct damages from the same SQLi flaw: confidentiality (read/dump foreign data) and integrity (modify/delete/drop data).],
      cite: "524, 525"),
    item("f", 3,
      [Describe briefly how this vulnerability can be fixed in the web application so such attacks are no longer possible.],
      [Use *Prepared Statements / parameterized queries*: the query *structure is sent and "compiled" first*, then the data is *bound* separately (e.g. `prepare("... WHERE key = ?")` + `bind_param`). Because *code and data are strictly separated*, input can never change the query's structure, so injection is impossible. (Manual escaping is insufficient — it only protects quoted strings, not other datatypes.)],
      graded: [naming *Prepared Statements / parameterized queries* and the reason: separate query structure from data so input is never interpreted as code.],
      cite: "534, 536"),
  ),
)
