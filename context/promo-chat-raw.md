# Promotion Case — Raw Data from Cursor Chat
> Source: Cursor AI conversation — promotion case research (Slack + GitHub + JIRA sweep)
> Window: May 2024 – Apr 2026 (24 months)
> Case: P20 (MTS 2) → P30 (Computer Scientist 1)
> Team: Adobe Express — PLG / Engagement
> Purpose: Raw facts for resume bullets. Do not polish here — keep everything factual.

---

## Headline Numbers (all verifiable)
- **113 PRs authored** (99 in Horizon/hz monorepo) — ~85+ merged
- **95 PRs reviewed** across ~20 distinct engineers
- **211 JIRA issues touched**, including **13 Epics owned end-to-end**
- **12+ FCC Operational Readiness Plans authored** — every shipped feature had full rollback, monitoring, killswitch coverage
- Solo or primary engineer on ~all major PLG/Engagement experiments shipped in the last 18 months

---

## Major Epics Owned (with JIRA IDs)

| Epic | JIRA ID | Status |
|------|---------|--------|
| NBA \| RTP \| Post-Export Multi-CTA + Resurrection | CCEX-287242 | In Development (Blocker priority) |
| JDI \| CBT for Mobile Web | CCEX-243407 | Done / Rollout |
| CBT V4 — Mobile | CCEX-228722 | Done |
| CBT V4 — Desktop | CCEX-139568 | Done |
| CBT Sophia → Attribute Store Migration | CCEX-228723 | Done |
| Replace Content Using Your Uploads | CCEX-190042 | Done |
| Replace Content — Test Restart | CCEX-262525 | Done |
| Open Express as You Left It | CCEX-146395 | Done |
| Live Preview for QA CDT | CCEX-146401 | Done |
| Recent Content (Editor) | CCEX-119210 | Done / RTP |
| Your Stuff Empty State | CCEX-139559 | Done |
| CBT for Mobile Download in Progress | CCEX-246503 | Done |
| CBT Resize V2 (perf) | CCEX-203170 | Done |

---

## Detailed Achievement Breakdown

### 1. RTP Skill — Owned the team's AI automation tooling
**What:** Authored and maintains the `/rtp` skill — the prompt-driven automation the entire PLG group uses to roll out winning experiments to production. This is infrastructure, not feature work.

**Technical details:**
- Refactored a 1,112-line monolith `SKILL.md` into reference-loaded structure with `rtp-patterns.md` and `input-format.md`
- Added kill-switch as default (safety)
- Enforced experiment-PR linkage
- Added confirmation gates to prevent accidental deletions
- Built subpart architecture for maintainability

**JIRA:** CCEX-286471, CCEX-286551 ([RTP Skill] Break into subparts), CCEX-286553 ([RTP Skill] a11y support), CCEX-284343, CCEX-288320

**PRs:**
- `#276301` (merged) — kill-switch + variant confirmation + mandatory experiment PR linkage
- `#277442` — references file architecture for the skill

**File:** `tools/prompt-catalog/skills/shared/teams/plg/rtp/SKILL.md`

**Why above-level:** Wrote a tool that other engineers depend on. Every PLG engineer running an RTP now goes through a safer, faster, more auditable flow.

---

### 2. CBT V4 — ML Model Integration (Desktop + Mobile)
**What:** Integrated the new ML-based personalization model powering "Continue Building This" post-export recommendations. Owned both Desktop and Mobile arms end-to-end including ALS model wiring, attribute-store integration, and migration off deprecated Sophia backend.

**Hard deadline:** Sophia decommissioned 8/28/2025 — this was on the critical path.

**Technical details:**
- ALS model wiring
- Attribute-store integration
- Migration off Sophia backend (entire pipeline)
- Pure backend plumbing, no UI changes

**JIRA:**
- Desktop: CCEX-139568
- Mobile: CCEX-228722
- Migration: CCEX-228723
- Stories: CCEX-227177, CCEX-225558, CCEX-227137, CCEX-224236, CCEX-230839

**PRs:**
- `#200306` — Mobile CBT V4 experiment
- `#215045` — Desktop CBT V4
- `#183794`, `#190741`, `#190739` — Sophia → Attribute Store migration

**Why above-level:** Solo-owned a backend integration with ML pipeline under a hard deadline. Prevented production breakage when Sophia was decommissioned.

---

### 3. Post-Export Multi-CTA + Resurrection RTP (CCEX-287242)
**What:** Most complex post-export rollout in the team's roadmap. Unifies THREE prior experiments (CBT Resurrection, CBT Multi-CTA, CBT Cooldown on Mobile) into one rollout with a new unified cooldown model, file-format guards, and resurrection cohort logic.

**Blocker priority epic.**

**Technical approach:**
- Broke this down into 7 implementation stories (CCEX-292231 → CCEX-292240)
- Covers: UISync types, ViewModel generators, eligibility guards, Multi-CTA priority matrix, on-click behavior, unit testing
- Designed unified cooldown — skipped migration for older per-action keys, used resize CBT as primary key
- Proposed this design in Slack (#tmp-cbt-multi-cta), walked team through trade-offs

**JIRA:** CCEX-287242, CCEX-292231–CCEX-292240, CCEX-288317 (POC), CCEX-288320 (Skill), CCEX-288321 (Fixes)

**PRs:**
- `#279243` (open) — Remove migration logic, unify cooldown

**Why above-level:** "Merge three winning experiments without breaking anyone" is real production architecture work under ambiguity. Independently scoped + broke down the work.

---

### 4. Open Express as You Left It (CCEX-146395)
**What:** Express-wide returning-user feature that auto-opens the user's last project. Touched 4 sub-systems owned by different teams.

**Technical details:**
- Integrated with dialog orchestrator
- Deeplink handling for SUSI/TOU edge cases
- A.com cross-domain test support
- Lazy asset load exploration (CCEX-179370)

**JIRA:** CCEX-146395, CCEX-170167, CCEX-172993, CCEX-179370, CCEX-172249, CCEX-181882

**PRs:** `#108554`, `#115672` (dialog orchestrator integration), `#116949` (bug fix), `#117607` (modal disable in editor), `#118968` (logging), `#124839` (deeplink for LOE without TOU)

**Why above-level:** Required cross-team negotiation across 4 sub-systems (home + editor + auth + dialog orchestrator), each owned by a different team.

---

### 5. Recent Content (Editor) — CCEX-119210
**What:** Built Recent Content in the Express editor end-to-end.

**Key technical decision:** No API existed for this feature. Instead of blocking, used **user storage** as the backing store. This unblocked the team, experiment shipped on schedule, and it is now RTP'd.

**JIRA:** CCEX-119210

**PRs:** `#94825`, `#98035`, `#99633`, `#101426`, `#101430`, `#102264`, `#102672`, `#102825`, `#106453`, `#129709`

**FCC:** CCEX-172646

**PM:** Tal

**Why above-level:** No API → pragmatic alternative → shipped. Judgment call a P30 is expected to make independently.

---

### 6. Replace Content Using Your Uploads (CCEX-190042 + CCEX-262525)
**What:** Engineering for inserting users' uploaded content into the Replace flow on the editor. Includes thumbnail integration, View-All workflow, and a test-restart epic.

**JIRA:** CCEX-190042, CCEX-262525, CCEX-237574, CCEX-242071, CCEX-242021, CCEX-242072, CCEX-245081, CCEX-245082, CCEX-245083, CCEX-245089

**PRs:** `#218582`, `#227259`, `#220075`, `#266881`

---

### 7. CBT for Mobile Web (CCEX-243407)
**What:** Extended CBT Resonance to Mobile Web and Tablets. JDI epic, rolled to production.

**JIRA:** CCEX-243407, CCEX-252459
**FCC:** CCEX-254035
**PR:** `#236267`

---

### 8. CBT for Mobile Download in Progress (CCEX-246503)
**What:** CBT feature for mobile users in the "download in progress" state.

**JIRA:** CCEX-246503

---

### 9. Your Stuff Empty State (CCEX-139559)
**What:** Engineered the empty state experience for the "Your Stuff" section.

**JIRA:** CCEX-139559

---

### 10. Live Preview for QA CDT (CCEX-146401)
**What:** Built live previews for Quick Actions Embed SDK. Spans Engagement + Quick Actions Platform components.

**JIRA:** CCEX-146401, CCEX-199491 (POC), CCEX-207390
**PRs:** `#146592`, `#163773` (CSS fix), `#164493` (debug log fix)

---

### 11. Performance + Tech Debt
- Added perf marker for Resize V2: CCEX-203170, PR `#178041`
- Refactored Inspire Recent Brick: CCEX-187878, PR `#127940`
- Feature-flag cleanup for shipped experiments: CCEX-289487, CCEX-282400
- Multiple main-branch break fixes: PRs `#265217`, `#265527`, `#263508`, `#176537` (all `[MAIN FIX]`)

**Why above-level:** Fixed things I didn't break, including unblocking the entire monorepo's main branch.

---

## Helpful Nature / Force-Multiplier Evidence

### PR Reviews
- Reviewed **95 PRs** across ~20 engineers
- Notable reviewees: abaggarwal (12), shiksha (7), iabbas, dhansingh, mahaksht, lkhong, arshjain, lonianandas, yloubry, hajoshi, damin, vineesha, rajp, ecocoru, iuta, shairilk, tenjer, ghidel, rishabha
- Mix of juniors (mentorship signal) + seniors from adjacent teams (trust signal)

### Mentoring — Mahak (junior engineer)
Slack message (#engagement-plg-dev, 2026-04-15) defending a junior from PM pressure + suggesting platform extension:
> "Hi @vivekm, this task was assigned to mahaksht last Thursday. I spoke with him recently, and he is almost ready to raise the PR… On the skill side, this looks like a JDI use case. I am not sure whether the RTP skill has already been used for this or not, but it may be possible to use it for JDI as well… A better long-term approach may be to enhance RTP to handle this case or create a dedicated JDI skill."

Three signals in one message: (a) shielding a junior from pressure, (b) thinking platform-first not feature-workaround, (c) proposing tooling investment direction above day-to-day.

### Team Estimation / Planning Lead
Slack (#engagement-plg-dev, 2026-04-14):
> "I've added the estimates. For the auto-installation trigger, there's still some uncertainty — I need a bit more time to validate the approach. For now, I've made reasonable assumptions and factored that into the estimate. @jaggrawa, please take a look…"

Slack (#engagement-plg-dev, 2025-12-16) — sizing guidance to peer (lonianandas):
> "Contextual means the options will not follow a static order… Estimation: S — This is a small change. We only need to store the order in UDS or localStorage and update the UI accordingly."

**Above-level:** Doing planning and scoping for others, not just self.

### Peer / Pair Testing (assigned repeatedly as trusted tester)
JIRA: CCEX-156812, CCEX-154860, CCEX-166888, CCEX-219290, CCEX-233196, CCEX-257010, CCEX-229678, CCEX-211259, CCEX-209325, CCEX-210084, CCEX-245089

### Cross-Team Coordination
- Worked with PMs (mguthmann, vivekm) on RTP scope decisions
- Coordinated CBT/QR team reviews (Slack 2026-04-28)
- Proposed unified-cooldown design in #tmp-cbt-multi-cta, walked team through trade-offs (Slack 2026-04-13)

### Operational Readiness — 15 FCC plans authored
Every shipped feature paired with full rollback/monitoring/killswitch plan:
CCEX-119402, CCEX-122692, CCEX-124498, CCEX-132156, CCEX-140623, CCEX-156364, CCEX-161131, CCEX-185230, CCEX-188146, CCEX-210351, CCEX-219332, CCEX-240212, CCEX-254035, CCEX-280257, CCEX-288518

---

## Key Links (for reviewers)
- GitHub: https://git.corp.adobe.com/sanjeevs
- JIRA filter: `assignee = currentUser() AND updated >= -730d`

### Top PRs
- `#276301` — RTP Skill kill-switch + experiment-PR enforcement
- `#277442` — RTP Skill references file architecture
- `#279243` — Multi-CTA RTP unified cooldown
- `#200306` + `#215045` — CBT V4 Mobile + Desktop
- `#183794` + `#190741` + `#190739` — Sophia → Attribute Store migration
- `#115672` — Open Express as You Left It (dialog orchestrator)
- `#218582` + `#227259` — Replace Content Using Your Uploads
- `#146592` — Live preview for QA CDT

---

## Recommendation Messages Drafted

### To Tal (PM for Recent Content / CCEX-119210)
```
Hi Tal,
I'm working on my promotion case (MTS 2 → Computer Scientist 1) and "Recent Content (Editor)"
(CCEX-119210) is one of the pieces of work I'd like to highlight — I built that feature end-to-end
while you were the PM.

You might remember: there was no API for it, so I used user storage instead. That kept us on
schedule, the experiment shipped, and it is now RTP'd.

Could you share a short note (4–6 lines) on what you saw during that work — how I handled the scope,
the user-storage call, or how I took it from charter to experiment to FCC?

You can reply here and I'll forward it to Sachin, or send it to him directly — whatever is easier.

Thanks a lot,
Sanjeev
```

### To Rason (PM for CBT charters)
```
Hi Rason,
I'm working on my promotion case (MTS 2 → Computer Scientist 1) and would love your input if
you're open to it.

A few of the charters I'm planning to highlight are ones we shipped together:
  - Post-Export Multi-CTA + Resurrection RTP (CCEX-287242)
  - CBT for Mobile Download in Progress (CCEX-246503)
  - CBT for Mobile Web JDI (CCEX-243407)
  - Sophia → Attribute Store Migration (CCEX-228723)
  - Your Stuff Empty State (CCEX-139559)

Could you share a short note (4–6 lines) on what you saw from your side? You can reply here and
I'll forward it to Sachin, or send it to him directly.

Thanks!
Sanjeev
```

### To Tser (long-term collaborator across most major charters)
```
Hi Tser,
I'm working on my promotion case (MTS 2 → Computer Scientist 1) and would really value your
input if you're open to it.

We've worked together on most of my major charters — CBT, Sophia migration, Multi-CTA RTP,
Mobile Download in Progress, Mobile Web, Your Stuff Empty State — so you've seen how I work
end-to-end.

Could you share a short note (4–6 lines) on what stands out from working with me? You can reply
here and I'll forward it to Sachin, or send it directly.

Thanks!
Sanjeev
```

---

## Open Questions (fill before writing final resume bullets)
- [ ] What was the engagement/click-through delta on CBT V4 after the ML model upgrade?
- [ ] How many users does the Recent Content feature serve today?
- [ ] Any usage metrics on the RTP Skill — how many rollouts has it processed?
- [ ] Did the unified cooldown in Multi-CTA RTP ship to GA yet?
- [ ] Any A/B test win metrics from "Open Express as You Left It"? (Reportedly +3M exports/quarter already in resume)
- [ ] Total users/MAU for Adobe Express (for scale framing in bullets)
- [ ] Has Tal / Rason / Tser replied with recommendation notes yet?

---

## P20 → P30 Evidence Summary (three patterns)
1. **Owns ambiguous, multi-team initiatives end-to-end** — Multi-CTA + Resurrection, CBT V4 ML integration, Open Express as You Left It, RTP Skill. None were "spec → code." Each required scoping, cross-team negotiation, and architectural calls.
2. **Builds tools other engineers depend on** — The `/rtp` skill is now the team's standard rollout mechanism. That is platform/tooling work, not feature work.
3. **Acts as a force-multiplier** — 95 reviews, multiple peer/pair testing assignments, mentoring juniors, team-wide T-shirt sizing, owning operational readiness for every shipped feature.
