# Agentic Workflow — Raw Project Data
> Source: `/Users/sanjeev/dev/agentic-workflow`  
> Purpose: Raw facts to draw resume bullets from. Do NOT edit for style — keep everything factual and unpolished.  
> Status: Draft — will be refined when writing resume section

---

## What it is (one line)
An AI-powered SDLC automation platform that takes a JIRA epic from requirements all the way to a merged PR — using specialized agents, a background daemon, and human approval gates — without a developer needing to manually trigger each phase.

---

## Tech Stack
- **Language**: Python 3.10+, YAML, Markdown, JavaScript/TypeScript
- **APIs integrated**: JIRA REST API, Confluence REST API, Figma REST API, GitHub CLI, Jenkins API
- **AI models used**: Claude (Anthropic), OpenAI GPT, Perplexity Sonar, Google Gemini (Vertex AI)
- **Testing**: Playwright (browser automation)
- **Document formats**: PDF, DOCX, PPTX, XLSX (python-pptx, pypdf, python-docx, openpyxl)
- **Diagrams**: PlantUML, Draw.io
- **IDE integration**: Claude Code CLI, Cursor
- **OS support**: macOS, Linux, Windows (PowerShell installer + Task Scheduler)

---

## Scale / Size
- 89 Python files
- 14 specialized AI agents
- 18 reusable skills
- 7 slash commands (~4,000 LOC total)
- watcher.py: 882 LOC (main daemon loop)
- delivery.py: 597 LOC (CI/CD pipeline)
- config_schema.py: 242 LOC
- Each agent: ~500–800 LOC each

---

## Core Architecture (3 tiers)

### Tier 1 — Slash Commands (user entry points)
| Command | What it does |
|---------|-------------|
| `/discover` | Full requirements → design → test plan → stories (NO code) |
| `/implement` | Implement a JIRA story with TDD + local build + PR |
| `/fix-bug` | Root-cause analysis + targeted fix + auto PR |
| `/orchestrate` | Master coordinator, delegates to all agents (1,241 LOC) |
| `/build` | Local build or Jenkins CI trigger |
| `/search-work` | Search JIRA, wiki, git for prior art |
| `/plato` | Prompt purification pipeline |

### Tier 2 — 14 Specialized Agents
Each agent has mandatory quality gates — cannot hand off without passing them.

| Agent | Job | Gate |
|-------|-----|------|
| technical-analyst | Requirements gathering, gap analysis, 6-question architecture assessment | Gaps identified, feasibility assessed |
| software-architect | HLD + LLD design (STOP protocol: Search, Think, Outline, Prove) | Design justified, no over-engineering |
| tdd-software-engineer | Code with TDD (tests first → code → passing tests) | All tests passing, coverage metrics proven |
| product-owner-task-planner | Epic → stories (INVEST criteria, Given/When/Then ACs) | Stories sized, linked, acceptance criteria clear |
| qa-test-validator | Test coverage, regression detection | Coverage adequate, no regressions |
| product-owner-validator | Final PR sign-off, JIRA documentation | ACs met, PR linked |
| program-manager | Epic tracking, stakeholder coordination | Work decomposition complete |
| research-lead | Orchestrates 4-model LLM Council | Peer reviews collected |
| claude/openai/perplexity/gemini researchers | Each queries their respective model | Factual baseline per model |
| peer-reviewer | Anonymized evaluation across all 4 model responses | Consensus or evidence-grounded disagreement |

### Tier 3 — 18 Reusable Skills
- jira-integration (JQL query, create, comment, link)
- confluence-wiki (create/update pages, PlantUML + Draw.io diagrams)
- figma-mcp (extract requirements from Figma: comments, spatial nav, screenshots)
- test-plan-generator (auto-detect Figma links from JIRA, generate + publish consolidated test plan)
- research (4-model LLM Council, 3-stage peer review, ~9 API calls)
- socratize (personality-diverse Claude debate: optimist, skeptic, pragmatist, analyst, thinker)
- concilize (hybrid: clarify → oracle baseline → deliberate → red-team → decree, ~18 API calls)
- debug-e2e (analyze failed Playwright tests, parse stack traces)
- webapp-testing (Playwright browser automation for local apps)
- document-skills (PDF, DOCX, PPTX, XLSX create/read/transform)
- react-spectrum (component patterns, design tokens, dark/light/mobile/desktop variants)
- skill-creator (guide for writing new skills)
- spacecat (Edge Delivery Services API)
- ethos-flex (CI/CD, Argo Workflows, DevHome/Backstage integration)

---

## The Watcher Daemon (most impressive part)

A persistent Python background process that polls JIRA and drives the entire SDLC automatically.

### What it watches for and does

**Epic moves to "Planning" status**
1. Detects status change via JIRA polling
2. Auto-triggers `/discover` Phase 1–2 (requirements + gap analysis)
3. Posts requirements doc to JIRA
4. Waits for `requirements_approved` label from PM
5. On approval: runs architecture assessment → HLD (if needed) → LLD → test plan → story decomposition
6. Each phase gated by JIRA label (`tc_approved`, `lld_approved`, `test_plan_approved`)

**Epic moves to "In Development"**
1. Picks up each child story
2. Creates feature branch: `feature/<ldap>/<EPIC_ID>_<name>`
3. Runs `/implement` with TDD
4. Local build verification (up to 3 fix attempts)
5. Commits → pushes → creates PR → triggers Jenkins CI
6. Comments PR link + build status back to JIRA
7. Human gate: developer approves PR

**Bug detected (status: To Fix / New / In Development)**
1. Runs `/fix-bug` (root cause analysis + targeted fix, scoped < 200 lines)
2. Same delivery pipeline: commit → push → PR → Jenkins → JIRA comment
3. Human gate: developer verifies fix

### Runner modes (configurable)
- `claude_code` — fully automated, runs `claude` CLI with sandbox permission allowlist
- `cursor` — IDE-assisted, Cursor opens with command prefilled
- `notify_only` — toast notification only, developer runs manually

---

## Delivery Pipeline (delivery.py — 597 LOC)
Commit → Push → PR creation → Jenkins CI trigger → JIRA comment  
Covers the full sequence in one reusable pipeline shared by both `/implement` and `/fix-bug`.

---

## Hard Technical Problems Solved

### 1. Infinite build loop escape
Build can fail permanently on some machines but code is correct. Added `build_verified_manually` JIRA label as escape hatch — skips 3 MSBuild retry attempts without halting workflow.

### 2. Interrupted `/fix-bug` recovery
If watcher is killed mid-analysis (during long `/fix-bug` run), next poll detects existing feature branch and skips re-triggering analysis. Goes straight to delivery pipeline — avoids duplicating hung work.

### 3. Wiki comment feedback loop prevention
Watcher posts comments to wiki. To prevent reading its own comments as new input, it marks all its own replies with a `_Raised by watcher._` footer and excludes those from the revise-detector feed.

### 4. State persistence across crashes
`watcher_state.json` — bug-phase mutations are written immediately BEFORE the long-running command starts. If watcher is killed mid-command, state is already persisted. On next start, it knows where to resume.

### 5. Sandbox boundary handling
Claude Code runs with sandbox permissions. Watcher passes `--add-dir ~/.claude` and `--add-dir <agentic_workflow_path>` flags to every spawned session, preventing sandbox from blocking skill/command file reads.

### 6. Architecture assessment as binary gate
6-question yes/no assessment (technical-analyst) determines whether HLD is required. If all "no" → skip Tech Council review, go directly to LLD. Eliminates unnecessary review cycles for small changes.

### 7. Project-agnostic design
No project values hardcoded. Downstream repos supply `workspace.md` per skill (JIRA project key, wiki space, Figma file key, etc.). Single config change re-targets the entire daemon to a new product.

### 8. Per-story branching on single branch
When `story_branching=true`, `/implement` runs per child story scoped by prompt — all on same feature branch, not separate branches. Avoids PR proliferation while keeping stories isolated in execution.

---

## Human-in-the-Loop Gates (JIRA labels)
| Label | Meaning |
|-------|---------|
| `requirements_approved` | PM reviewed requirements doc |
| `tc_approved` | Tech Council reviewed HLD |
| `lld_approved` | Developer reviewed LLD |
| `test_plan_approved` | QA/developer reviewed test plan |
| `pr_approved` | Developer approved the PR |

Watcher polls for these labels and resumes blocked phases atomically on detection.

---

## Configuration
`watcher/config.yaml` — single file controls everything:
- JIRA project key, base URL, poll interval
- Watched epic keys
- Developer LDAP
- MSBuild path, solution dir, platform (Debug/Release, x64/ARM)
- Jenkins job name, build type, API URL
- Approval gate label names (customisable)
- Runner mode + model + effort type
- Notification settings

---

## Project-Agnostic Downstream Structure
Each product repo that uses this system contains:
```
your-product/
├── agents/project-technical-analyst.md   # project-specific agent overrides
├── skills/jira-integration/workspace.md  # JIRA key, components
├── skills/confluence-wiki/workspace.md   # wiki space, page IDs
├── skills/figma-mcp/workspace.md         # design file keys
├── commands/build.md                     # project-specific build steps
├── watcher/config.yaml                   # full project config
└── CLAUDE.md.<slug>                      # project context for Claude
```

---

## What this shows on a resume (raw signals)
- Built a production background daemon (not a script — persistent, event-driven, crash-resilient)
- Designed multi-agent orchestration with quality gates (not just "used AI")
- Integrated with real enterprise systems: JIRA on-prem (VPN + PAT auth), Confluence, Figma, Jenkins, GitHub
- Solved real engineering problems: state persistence, loop prevention, sandbox handling, build recovery
- Multi-model AI usage: Claude + OpenAI + Perplexity + Gemini running in parallel with peer review
- Project-agnostic design: works across multiple Adobe products with zero code changes
- Human-in-the-loop architecture: automation that knows when to stop and ask a human
- Windows + macOS + Linux support, PowerShell installer, Task Scheduler integration
- TDD-enforced code generation (agents prove tests pass before handoff — not just "generates code")

---

## Open Questions (fill in before writing final bullets)
- [ ] How many teams / products are using this today?
- [ ] Approx % reduction in manual steps? (e.g. "3-hour discovery → 20-min review")
- [ ] Any concrete time-saved metric? (e.g. "X hours/sprint saved per engineer")
- [ ] Is this open-sourced or internal Adobe only?
- [ ] Any notable adoption story? (e.g. "team X onboarded in 1 day")
- [ ] What was the total dev time to build this? (signals scope)
- [ ] Did it catch any real bugs before they hit prod?
