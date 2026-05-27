# Resume Improvement TODO — Google Target
> Branch: `sanjeevs/google` | Work through these one by one before submitting.

---

## 🔴 Critical

- [ ] **C1 — Replace Objective with Summary**
  - Delete the `\section{Objective}` block entirely
  - Add a `\section{Summary}` with 2 lines leading with: 5+ years, Adobe, generative AI, 100M+ users, LeetCode Knight / competitive programming signal

- [ ] **C2 — Split the Text-to-Template bullet (line 59)**
  - Currently 1 bullet covering 4 achievements — split into 3–4 separate bullets
  - Bullet A: end-to-end UI build, flagship product, MAU count
  - Bullet B: mobile optimization — memory leaks resolved, quantify (crash rate %, memory footprint %)
  - Bullet C: "Bring Your Own Image" functionality — user impact
  - Bullet D: credit-based metering system — monetization outcome ($revenue, paid conversions)

- [ ] **C3 — Delete 2 filler Nagarro bullets**
  - Delete: *"Actively participated in code reviews and debugging..."*
  - Delete: *"Collaborated in continuous improvement initiatives..."*
  - Add metrics to remaining bullets (requests/day, orders/month for the platform scale claim)

- [ ] **C4 — Fix "Currently developing" bullet (line 64)**
  - Either convert to past tense if any version is in production
  - Or cut it and replace with a stronger shipped accomplishment

- [ ] **C5 — Add a Projects section**
  - Add `\section{Projects}` to right column (below Achievements)
  - 2–3 bullets with project name, tech stack, and outcome/link
  - Pull from GitHub (`sudo-sanjeev`) — add only public, meaningful repos

- [ ] **C6 — Add cloud / infrastructure keywords**
  - Weave into experience bullets naturally: AWS/GCP, CDN, CI/CD, bundle size, web workers, caching
  - At minimum describe deployment outcomes: *"deployed to CDN serving X regions"*, *"reduced bundle Xkb → Ykb"*
  - Add relevant terms to Skills section under Architecture

---

## 🟡 Important

- [ ] **I1 — Fix years of experience (4+ → 5+)**
  - Timeline is Jan 2021 → May 2026 = 5.3 years
  - Update in the new Summary section

- [ ] **I2 — Rewrite header subtitle**
  - Change: `Senior Software Engineer - Full-Stack Developer`
  - To: `Senior Software Engineer | Frontend Platform & Generative AI`

- [ ] **I3 — Fix Skills section errors**
  - Move `Data Structures` + `Algorithms` out of skills — replace with `Distributed Systems`, `Web Workers`, `WebAssembly`, `Event-Driven Architecture`
  - Move `OOP` out of Soft Skills — it's a programming paradigm, not a soft skill
  - Remove `Creative Editing Software` from Soft Skills — zero signal for Google
  - Remove duplicate `Design Patterns` entry (listed twice in Architecture & APIs)

- [ ] **I4 — Name the coding contests**
  - Replace *"major coding competitions"* with actual contest names
  - If any are Google-run (Code Jam, Kick Start, Hash Code) — name them explicitly
  - Format: *"Ranked 49th/22,000 in [Contest Name]"*

- [ ] **I5 — Give ML/Recommendations its own bullet**
  - Currently buried at end of Recents & Suggestions bullet
  - Separate it: *"Integrated ML recommendation model for asset suggestions — improved click-through by X%"*

- [ ] **I6 — Quantify the component library bullet**
  - Add: how many teams/products consume it, whether it replaced a previous system
  - If used across Express + Firefly or multiple Adobe products, call that out explicitly

- [ ] **I7 — Quantify the authoring framework bullet**
  - Add: how many features use this framework, % of paid conversion touchpoints it gates

- [ ] **I8 — Add country code to phone number**
  - Change: `628-420-7388` → `+1 628-420-7388`

- [ ] **I9 — Add relocation / remote flexibility**
  - If open to Bay Area / remote US, state it in header or summary
  - Indian address + US number without clarity confuses US recruiters

---

## 🟢 Nice-to-have

- [ ] **N1 — Remove the hacky comment from source**
  - Delete: `% Hacky fix for awkward extra vertical space` (line 57)

- [ ] **N2 — Fix deprecated LaTeX command**
  - Replace `\bf` with `\textbf{}` in Links section (lines 149–151)

- [ ] **N3 — Quantify Medium or drop the link**
  - If articles have 10K+ views or notable reach → add follower/view count
  - Otherwise drop the Medium link entirely — it's noise without context

- [ ] **N4 — Enable `\lastupdated`**
  - Uncomment `% \lastupdated` on line 21
  - Freshness signal shows recruiter you're actively looking

- [ ] **N5 — Compress Education section**
  - Fix the `Punjab Technical \newline University` formatting hack
  - Reduce to 2 lines max — 5-year engineer doesn't need verbose education block

- [ ] **N6 — LeetCode handle consistency**
  - `Sanjeev1709912` looks auto-generated vs `sudo-sanjeev` / `@sanjeev-singh` everywhere else
  - Change the display text to something cleaner if the URL can't be changed

---

## Progress

| Priority | Total | Done | Remaining |
|----------|-------|------|-----------|
| 🔴 Critical | 6 | 0 | 6 |
| 🟡 Important | 9 | 0 | 9 |
| 🟢 Nice-to-have | 6 | 0 | 6 |
| **Total** | **21** | **0** | **21** |
