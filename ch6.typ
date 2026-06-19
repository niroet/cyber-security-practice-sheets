#import "template.typ": item

#let ch6 = (
  chapter: "6",
  title: "Cryptography",
  tag: "6.9",
  slide: 696,
  items: (
    item("a", 2,
      [Describe briefly the difference between point-to-point encryption (P2PE) and end-to-end encryption (E2EE).],
      [*P2PE* secures the link only between two points on the network (e.g. client–server), so *every intermediate* (server/relay) can read the content; security depends on trusting those intermediates. Easier to deploy and scale — e.g. `TLS`, Teams. *E2EE* secures the channel *between sender and receiver* directly, so *no intermediate can read* the content; trust is needed only in the receiver, but the initial trust is hard to establish — e.g. `PGP`, `S/MIME`, Signal.],
      graded: [P2PE = intermediates can read / trust the server, scalable (TLS); E2EE = only endpoints can read / trust only the receiver (PGP, S/MIME, Signal).],
      cite: "674"),
    item("b", 3,
      [Explain why modern cryptographic protocols use a combination of symmetric and asymmetric encryption rather than 1) symmetric encryption alone or 2) asymmetric encryption alone.],
      [*Symmetric* alone: it requires a *pre-shared secret*, but there is no safe way to exchange that key over an insecure channel — key distribution is the core problem (and it scales badly, a key per pair). *Asymmetric* alone: it needs *no shared secret* and distributes keys easily, but the calculation is *expensive and slow*, unsuitable for bulk data. *Hybrid:* use the slow *asymmetric* cryptography only to exchange (or agree, via Diffie-Hellman) a *symmetric session key*, then use *fast symmetric* encryption for the actual data — combining easy key distribution with high performance.],
      graded: [symmetric alone = unsolved key exchange / shared secret needed; asymmetric alone = too slow for bulk data; hybrid = asymmetric to exchange a symmetric session key, then symmetric for the payload.],
      cite: "631, 652, 656"),
    item("c", 4,
      [Alice opens the website `https://example.org` using the current version of TLS. List all cryptographic keys required to establish a secure connection and describe their purpose.],
      [▶ The server's *asymmetric key pair* (*private key* plus *public key* in its `X.509` certificate): authenticates the server and proves it owns the certificate, so Alice knows she is not talking to a man-in-the-middle. ▶ The *CA's keys* (root / intermediate): the certificate is *signed* by a trusted Certificate Authority, whose signature Alice verifies up the chain of trust. ▶ The *Diffie-Hellman (ephemeral) key shares* (`DHE`): exchanged to derive a fresh shared secret without ever transmitting it (perfect forward secrecy). ▶ The *symmetric session key* (e.g. `AES_256`): derived from the exchange and used for fast encryption of the actual traffic. ▶ A *MAC/HMAC key* (e.g. `SHA384`): keys the integrity check of each message. (Cipher suite `TLS_DHE_AES_256_GCM_SHA384` names these parts.)],
      graded: [server asymmetric key pair (authentication) + CA signing keys (chain of trust) + Diffie-Hellman shares (derive shared secret, PFS) + symmetric session key (bulk traffic) + MAC/HMAC key (integrity).],
      cite: "634, 641, 672, 681, 684"),
    item("d", 6,
      [Alice sends an end-to-end encrypted email with a large attachment to Bob (e.g. using `S/MIME` or `PGP`). Name the necessary keys and describe how such a protocol ensures that: (1) the email can be sent and read quickly; (2) no one but Bob can read the message; (3) Bob received the complete, unchanged message from Alice; (4) the email actually arrives and was read.],
      [*Keys:* Bob's *public/private key pair*, Alice's *public/private key pair*, and a one-time *symmetric session key*.
      *(1) Speed:* hybrid encryption — the large attachment is encrypted *once* with the fast *symmetric session key*; only that small session key is encrypted asymmetrically, avoiding slow asymmetric operations on bulk data.
      *(2) Confidentiality:* the *session key* is encrypted with *Bob's public key*, so only *Bob's private key* can recover it and decrypt the message.
      *(3) Integrity + authenticity:* Alice computes a *hash* of the message and signs it with *her private key* (*digital signature*); Bob verifies it with *Alice's public key*, confirming the message is complete, unchanged and truly from Alice (non-repudiation).
      *(4) Arrival/read:* not guaranteed — the slides state that *receipt can be confirmed but not assured* (availability); cryptography cannot force delivery. A signed read-receipt could confirm reading but the recipient may refuse it (not on slides).],
      graded: [keys (Bob's pair, Alice's pair, session key); (1) hybrid = symmetric for attachment, asymmetric only for the key; (2) session key encrypted with Bob's public key; (3) Alice signs a hash with her private key = digital signature; (4) delivery cannot be assured (receipt confirmed, not assured).],
      cite: "602, 643, 656, 663, 674"),
  ),
)
