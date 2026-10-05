# Global preferences (apply in every project, alongside any project AGENTS.md)

## Communication
- When something is uncertain, say what you'd need to check rather than guessing.
- Call out misconceptions and correct my faulty thinking whenever you think it is helpful. I welcome the learning process.

## Environment
- macOS with zsh. In zsh, never name a variable `status` (it's read-only), and unquoted scalar variables don't word-split, so use arrays for lists.
- Install tools with Homebrew. Don't use `curl | sh` installers, `npm -g`, or pipx when a brew formula exists.
- Python is uv-only: use `uv` for environments, packages, scripts, and tools. Never use pip or the system Python directly.
- Prefer `rg` over `grep` and `fd` over `find`. Both skip hidden and gitignored files by default; to include them use `rg --hidden --no-ignore` or `fd -H -I`. `rg` already recurses, so never pass `-r`: in `rg` it means `--replace`.
- Never start a dev server. I run it myself; ask me for its output if you need it.

## Git
- Don't commit or push unless I ask. Permission to commit is not permission to push.
- Commit messages: lowercase, concise, one line, no body unless I ask.
- Ask before destructive operations: `rm -rf`, `git reset --hard`, `git clean`, `git restore` or `git checkout -- <path>`, force-push, branch deletion, history rewrites.
- Changes you didn't make are probably mine or another agent's. Leave them alone and stay in your own scope; if they conflict with your task, stop and ask.
- For large or risky changes, use a separate branch or worktree so the current checkout isn't disturbed.
- Don't amend commits unless I ask.

## Code
- Only add comments when they're absolutely necessary. Most code needs none; keep any you add short.
- Similarly, only add tests when they're absolutely necessary.
- When replacing code, delete the old path. No compatibility shims, aliases, or fallbacks unless something real depends on them. In general, I care very little about backwards compatibility unless I ask.

## UI work
- Keep interfaces minimal and avoid generic AI-looking design (default component-library look, gradient text, purple accents, eyebrows, overused fonts like Inter).
- Check responsive layouts, keyboard and screen-reader access, and loading and error states, not just the happy path.

## Lean and Mathlib
- Prefer iterating with the lean-lsp MCP (diagnostics, goals, search) instead of a full `lake build` after every edit.
- Run `lake exe cache get` before the first build in a Mathlib-dependent project.
- Search Mathlib (loogle, leansearch, local search) before proving something that may already exist.
- Follow Mathlib naming, style, and organization. Don't change theorem statements to make proofs go through without asking.

## Working style
- Use subagents to parallelize independent work (separate files, disjoint parts of a dependency graph, independent searches). Only when the pieces are truly independent; don't spawn agents for a task you can finish in a few tool calls.
- For big tasks, inventory the full scope first and track progress in a ledger rather than quietly narrowing the task.
- If a task is ambiguous in a way that changes the result, ask. Otherwise pick the sensible default, say what you chose, and continue.

## Reporting
- Keep what you verified, and how, separate from what you didn't check. Don't call something done if its build, tests, or checks weren't run.
- Report unrelated pre-existing failures separately from failures you caused.
- Revalidate live state (branches, remotes, PRs, deployments, versions) instead of trusting earlier notes.
