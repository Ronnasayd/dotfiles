<!-- INIT AUTO-CONTEXT -->

## Always Use Interactive Question Tools

Every user question → interactive tool, never plain text. Claude:
`AskUserQuestion`. Multiple questions: `grilling` skill.

## Task Tracking

When task list exists (multi-step work), use `TaskCreate`, `TaskGet`, `TaskList`, `TaskUpdate` to give user feedback. Mark tasks complete as done, don't batch.

## Relevant Skills

| When                                                   | Use                                          |
| ------------------------------------------------------ | -------------------------------------------- |
| Creating/editing a skill under `skills/`               | `skill-creator` / `skill-architect`          |
| New skill's description doesn't trigger reliably       | `skill-description-generator`                |
| Writing a commit message                               | `semantic-commit-message` / `caveman-commit` |
| Opening a PR                                           | `generate-pr-description`                    |
| Unsure about git workflow (rebase, branch strategy)    | `git-guide` / `git-workflow`                 |
| Break big/complex problem into sub-problems            | `dynamic-programming-analysis`               |
| Generate/update project docs from code or diff         | `generate-docs`                              |
| Write PR description from diff/commits                 | `generate-pr-description`                    |
| Review a PR                                            | `pr-review`                                  |
| Resolve merge conflicts                                | `resolve-merge-conflicts`                    |
| Execute tasks for a spec-driven feature (taskmaster)   | `sd-execute`                                 |
| Generate a plan step-by-step                           | `sd-planning`                                |
| Build requirements review table from spec/design/tasks | `spec-to-requirements-table`                 |
| Pick between technical options (pros/cons)             | `technical-decision-helper`                  |

## Context-Specific Rules

The following rules apply to specific file types:

- [code.instructions](.claude/instructions/code.instructions.md) — applies to: `**/*.ts, **/*.js, **/*.py, **/*.java, **/*.go, **/*.css, **/*.cpp, **/*.c, **/*.vue, **/*.jsx, **/*.tsx`

<!-- END AUTO-CONTEXT -->

<!-- INIT:AUTO-GENERATED-CONTEXT:DO-NOT-MODIFY -->

## Mandatory rules — always follow

- User question → interactive tool, never plain text. Claude: `AskUserQuestion`. Many questions: `grilling` skill.

- `AskUserQuestion` must be fully contextualized, never terse. Question body: explain _why_ asked (what found in code, what trade-off) before choice. Option `description`: what picking it does/causes — not label restated. No truncated question/option text; full explanation every time.

- User asks question → answer only. No code change without explicit user authorization.

- Multi-step work → use `TaskCreate`, `TaskGet`, `TaskList`, `TaskUpdate` for feedback. Mark each task complete when done, no batching.

- Modify component/screen → run Playwright (or similar E2E) tests before finalizing.

- Lint/type/test errors in touched files → fix, even if not caused by you.

- Docs (`markdown files`, `memories`) not absolute truth. Only implemented code = truth.

- No code assumed correct without tests validating it.

- TDD mandatory when repo already has tests (suite/framework present): failing test first (Red), minimal code to pass (Green), then refactor. Small loops only, no big unverified blocks. No test setup in repo → don't impose one unprompted.

- Evidence over trust: before human review, give proof change works — passing test logs, screenshots/recordings of E2E or visual tests. No "should work" claims.

- Vertical slices only: thin end-to-end slices (tracer bullets) through all layers, not horizontal layers (all DB, then all API, then all UI). Each slice tested and validated before next.

- Task done (testing, execution, build) → kill all background processes/servers started, delete temp dirs generated.

- Anytime: evaluate what worth saving as permanent memory. Save only what next session needs and can't rediscover from code, Git, or CLAUDE.md — _reason_ behind decision, non-obvious invariant, user preference. Already in repo or only relevant to this conversation → don't save. Persist via `ai-memory-durable-pages` skill.

## Mandatory rules — hallucination protection

- "I don't know" allowed: uncertain or info missing → say so explicitly (e.g. "I don't have enough information to confidently assess this"). Never fill gaps with guesses.

- Quote before analyzing: long docs (>20k tokens) → first extract word-for-word quotes relevant to task, base analysis only on them, reference by number. None found → say "No relevant quotes found".

- Cite every factual claim: each claim about code, docs, external sources carries source (`path:line`, command output, URL, direct quote) for audit.

- Verify after generating: check each claim in response has supporting quote/source. None → retract claim (mark removal with `[]` when editing document).

## Context-Specific Rules

The following rules apply to specific file types:

- [code.instructions](.claude/instructions/code.instructions.md) — applies to: `**/*.ts, **/*.js, **/*.py, **/*.java, **/*.go, **/*.css, **/*.cpp, **/*.c, **/*.vue, **/*.jsx, **/*.tsx`

<!-- END:AUTO-GENERATED-CONTEXT:DO-NOT-MODIFY -->
