# Resume Improvement TODO — Google L4 Target
> Branch: `sanjeevs/google` | Google L4 = strong coder, technically deep, independently ships features.  
> Key shift from L5: **technical depth + problem-solving > business strategy + org leadership**

---

## What Google L4 actually looks for
- **Coding ability** — DS&A, competitive programming, clean code. This is the primary filter.
- **Technical ownership** — You built X, you solved the hard problem in X, you made the technical decisions for X.
- **Scope** — Independently owns features/components. Not org-wide initiatives.
- **Collaboration** — Works well with a team. Doesn't need to *lead* it.

> Your competitive programming background (LeetCode Knight, top-ranked contests) is your **single biggest L4 differentiator**. It's currently buried. That needs to change.

---

## 🔴 Critical

- [ ] **C1 — Promote Achievements to the top of the right column**
  - Move `\section{Achievements}` ABOVE `\section{Skills}` in the right column
  - Google L4 recruiters scan for competitive programming signal immediately
  - This is stronger for you than any bullet point in Experience

- [ ] **C2 — Name the coding contests explicitly**
  - Replace *"major coding competitions"* with real contest names
  - If any are Google-run (Code Jam, Kick Start, Hash Code) → name them first, they carry outsized weight
  - Format: *"Ranked 49th / 22,000 in [Contest Name, Year]"*
  - Add total problems solved count if it's 1,500+

- [ ] **C3 — Replace Objective with a short technical Summary**
  - Delete `\section{Objective}` entirely — generic filler, hurts more than it helps
  - Replace with `\section{Summary}` — 2 lines, technical framing, not seniority framing:
    > *"Software Engineer with 5+ years building large-scale frontend systems. Strong problem-solver with competitive programming background (LeetCode Knight, max rating 2000+). Experienced in generative AI features, performance optimization, and component architecture."*

- [ ] **C4 — Add a Projects section**
  - This is table stakes for L4 — Google wants to see what you build outside work
  - Add `\section{Projects}` to right column below Achievements
  - 2–3 entries: project name, tech stack, the interesting technical problem you solved
  - Pull from GitHub (`sudo-sanjeev`) — public repos only
  - No projects? Even a well-described personal tool counts

- [ ] **C5 — Split the Text-to-Template bullet and lead with the technical challenge**
  - Line 59 is 4 achievements crammed into one — split it
  - For L4 framing, lead each bullet with **what was technically hard**, not just what was built:
    - Bullet A: *"Architected end-to-end UI for Text-to-Template AI feature in Adobe Express using [tech stack] — served to X million users across desktop and mobile"*
    - Bullet B: *"Diagnosed and resolved critical memory leaks during mobile optimization — reduced memory footprint by X%, eliminated OOM crashes on low-end devices"* (the debugging/profiling story is pure L4 signal)
    - Bullet C: *"Built credit-based metering system for generative AI usage — designed the [state machine / rate-limiting logic / specific technical approach]"*

- [ ] **C6 — Delete 2 filler Nagarro bullets**
  - Delete: *"Actively participated in code reviews and debugging..."* — describes minimum expected behaviour
  - Delete: *"Collaborated in continuous improvement initiatives..."* — vague, zero signal
  - Use the freed space to add a technical detail to a remaining bullet

---

## 🟡 Important

- [ ] **I1 — Reframe experience bullets around technical decisions, not just outcomes**
  - L4 reviewers ask: *"What was the hard part? What trade-offs did you make? What would you do differently?"*
  - For each bullet, add one technical detail: which algorithm, what data structure, what pattern, what constraint
  - Example: Component library bullet → add *"built on Web Components / Lit, tree-shakeable, zero runtime dependencies"*

- [ ] **I2 — Give the memory leak / performance work its own bullet with specifics**
  - Performance debugging is extremely high signal for L4
  - Add: profiling tools used, root cause found, fix applied, measurable outcome
  - Example: *"Used Chrome DevTools and heap snapshots to identify retained DOM references in animation callbacks — fixed by [approach], reducing memory by X%"*

- [ ] **I3 — Fix Skills section errors**
  - Remove duplicate `Design Patterns` (listed twice in Architecture & APIs)
  - Remove `Creative Editing Software` from Soft Skills — no signal for Google
  - Move `OOP` out of Soft Skills — it's a paradigm, put it in Programming Languages or drop it
  - Replace the `Soft Skills` subsection entirely — Google doesn't care, use the space for a technical skill
  - Keep `Data Structures \textbullet{} Algorithms` — unlike L5, this IS worth showing for L4 (signals you take it seriously)

- [ ] **I4 — Add the ML/Recommendations as a standalone bullet**
  - Currently buried at end of the Recents & Suggestions bullet
  - Separate it with the technical angle: *"Integrated ML recommendation model — designed the data pipeline / feature vector / API contract between frontend and model serving layer"*

- [ ] **I5 — "Currently developing" bullet → rewrite or cut**
  - Line 64 signals unfinished work — red flag for any level
  - If shipped to any % of users: convert to past tense and describe the technical approach
  - If not shipped: cut it, use the line for a technical detail elsewhere

- [ ] **I6 — Fix header subtitle**
  - Change: `Senior Software Engineer - Full-Stack Developer`
  - To: `Software Engineer | Frontend Systems & Generative AI`
  - Drop "Senior" from the subtitle (your title is fine, but L4 doesn't need to lead with seniority positioning)
  - "Full-Stack Developer" reads junior/generalist — replace with your actual domain

- [ ] **I7 — Add country code to phone number**
  - Change: `628-420-7388` → `+1 628-420-7388`

- [ ] **I8 — Add relocation signal**
  - Indian address + US number with no context → confusing to US-based Google recruiter
  - Add *"Open to relocation — Bay Area / Seattle / NYC"* in Summary if applicable

- [ ] **I9 — Quantify the platform scale at Nagarro**
  - *"e-commerce platform supporting millions of users"* is vague
  - Add one concrete number: daily active users, requests/day, orders/month, or data volume
  - Even a rough order of magnitude is better than "millions"

---

## 🟢 Nice-to-have

- [ ] **N1 — Add technical writing context to Medium link or drop it**
  - If articles are about DS&A, system design, or frontend internals → keep and describe: *"Technical articles on [topic] — XK views"*
  - Otherwise drop the link entirely — noise without context

- [ ] **N2 — Fix deprecated LaTeX command**
  - Replace `\bf` with `\textbf{}` in Links section (lines 149–151)

- [ ] **N3 — Remove the inline comment from source**
  - Delete: `% Hacky fix for awkward extra vertical space` (line 57)

- [ ] **N4 — Enable `\lastupdated`**
  - Uncomment `% \lastupdated` on line 21
  - Small but visible freshness signal for active job search

- [ ] **N5 — Compress Education section**
  - Fix `Punjab Technical \newline University` formatting hack
  - 2 lines max — experience is the story now, not education

- [ ] **N6 — LeetCode handle display text**
  - `Sanjeev1709912` in the URL looks auto-generated
  - Display it as something cleaner: `\href{...}{\bf LeetCode}` if the URL can't change

- [ ] **N7 — Check GitHub repos are public and presentable**
  - The GitHub link is on the resume — make sure at least 2–3 pinned repos are clean, have READMEs, and reflect real work
  - An empty or messy GitHub with a resume link is worse than no link

---

## L4 Priority Order (suggested sequence)
Work through in this order for maximum impact per edit:

1. `C1` — Move Achievements up (5 min, highest ROI for L4)
2. `C2` — Name the contests (10 min)
3. `C3` — Replace Objective with Summary (15 min)
4. `C5` — Split Text-to-Template bullet (20 min)
5. `C6` — Delete filler Nagarro bullets (5 min)
6. `C4` — Add Projects section (depends on what's on GitHub)
7. `I1` → `I9` — In order
8. `N1` → `N7` — In order

---

## Progress

| Priority | Total | Done | Remaining |
|----------|-------|------|-----------|
| 🔴 Critical | 6 | 0 | 6 |
| 🟡 Important | 9 | 0 | 9 |
| 🟢 Nice-to-have | 7 | 0 | 7 |
| **Total** | **22** | **0** | **22** |
