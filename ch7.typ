#import "template.typ": item

// Chapter 7 is split across two foldable sheets (6 detailed parts don't fit one half-page).

#let ch7a = (
  chapter: "7",
  title: "Authorization",
  part: "Part 1 of 2 (a–c)",
  tag: "7.6",
  slide: 748,
  items: (
    item("a", 3,
      [Name three distinct types of factors that can be combined in *multi-factor authentication (MFA)*. Give an example for each.],
      [Any combination of authentication factors from *different* categories (so one stolen factor is not enough):
        #linebreak()1. *Something you know* — “*knowledge factors*”, e.g. password, PIN, security questions.
        #linebreak()2. *Something you have* — “*ownership factors*”, e.g. ID card, security token, cellphone (Mobile TANs / OTP).
        #linebreak()3. *Something you are* — “*inherence factors*” (biometric), e.g. fingerprint, retinal scan, voice.
        #linebreak() (The slides also list *location-based* and *time-based* factors.)],
      graded: [three *distinct categories* — knowledge / ownership / inherence (not three passwords) — each with a valid example.],
      cite: "315"),
    item("b", 3,
      [Name the permission system that is used under Linux and macOS for authorizing local file accesses. Explain the main reason for this design decision.],
      [The *Access Control List (ACL)*. An ACL stores, *attached to each file/object*, who may do what — it is *the columns of the access control matrix* (permissions kept per object). Main reason: file systems are *object-centric* — the permissions live *in the file-system attributes next to each file*, which makes object permissions *easy to express and easy to change* per file (add/remove a file with its rights). On Linux it is implemented compactly as three `rwx` octets for *owner, group and other* (e.g. `750` = `rwx r-x ---`), giving a simple, maintainable per-file scheme.],
      graded: [name *ACL*; reason = permissions stored per object (column of the matrix), inside the file-system attributes, making per-object permissions easy/efficient to set and change.],
      cite: "708"),
    item("c", 3,
      [(Mobile operating systems like iOS or Android describe permissions using *Capability Lists*.) Name concrete “elements” assigned to subject, object and permission in this context.],
      [Mapping for the Android/iOS permission model:
        #linebreak()• *Subject* — the *app* (the application / process requesting access).
        #linebreak()• *Object* — the protected *resource or data*, e.g. camera, microphone, location, contacts, media files, network.
        #linebreak()• *Permission* — the granted *capability / access right* on that resource, e.g. `READ_CALENDAR`, `CAMERA`, `ACCESS_FINE_LOCATION` (the action the app may perform on the object).],
      graded: [subject = the app; object = the device resource / data (camera, contacts, location…); permission = the specific access right / capability granted on it.],
      cite: "741, 742"),
  ),
)

#let ch7b = (
  chapter: "7",
  title: "Authorization",
  part: "Part 2 of 2 (d–f)",
  tag: "7.6",
  slide: 748,
  items: (
    item("d", 3,
      [Explain why capability lists are better suited in this scenario than the permission system of access control lists (Access Control Lists - ACLs).],
      [A *capability list* stores permissions *per subject* (the rows of the matrix) — exactly what a phone needs, since the natural question is *“what may THIS app do?”* and each app is checked/managed individually. Advantages that fit mobile:
        #linebreak()• *Easy, efficient permissions per subject* — each app carries its own (small) set of capabilities.
        #linebreak()• *Easy to change a subject’s permissions* — grant/revoke for one app without touching every object.
        #linebreak()• *Works well with variable subjects* — apps are constantly installed/removed.
        #linebreak()• *Decentral storage and control* — capabilities travel with the app.
        #linebreak()ACLs are object-centric, so per-subject (per-app) management would be inefficient and hard to change here.],
      graded: [capability list = per-subject (rows); mobile asks “what may this app do?”; cite easy/efficient per-subject perms, easy to change a subject, good with variable subjects, decentral control.],
      cite: "709, 710"),
    item("e", 2,
      [(Android distinguishes between 1) “installation time” and 2) “runtime permission”.) Give an example for both types of permission.],
      [1. *Install-time permission* — granted automatically at install, low risk, e.g. *network/internet access* (or “run at startup”).
        #linebreak()2. *Runtime permission* (“dangerous” permission) — e.g. *use the camera* or *access media files* / location.],
      graded: [one valid install-time example (e.g. network access) and one runtime/“dangerous” example (e.g. camera, media files, location).],
      cite: "741"),
    item("f", 2,
      [Describe when and how the user decides about these permission grants.],
      [• *Install-time permissions*: the user effectively *accepts them up front when installing the app* — they are declared in the app’s *manifest* and granted automatically at install (no per-use prompt).
        #linebreak()• *Runtime permissions*: the user is *asked at runtime, the first time the feature is used*, via a *system dialog* and explicitly allows or denies it (and can later change it in the permission manager / settings). This gives the user *control and transparency* (Implicit Deny — nothing without explicit allowance).],
      graded: [install-time = accepted at install via the manifest declaration; runtime = explicit user confirmation in a system dialog when the feature is first used (revocable in settings).],
      cite: "741, 742"),
  ),
)
