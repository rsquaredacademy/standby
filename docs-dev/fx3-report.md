# standby fx3: rx2 re-audit fixes

Worktree: `F:/R/Packages/_worktrees/standby-fx2`; branch: `task/standby-fx2`.
Baseline: `d9d951a`. Package version remains **0.2.2**.
Read before editing: the rx2d audit's New findings, the rx2h audit's section 4,
and `docs-dev/fx2-report.md`. No AGENTS.md was found in the worktree or its
filesystem ancestors. All fx1/fx2 source changes and regression tests remain.

## Findings and regression tests

| Finding | Status | Change and tests |
| --- | --- | --- |
| N01 (Medium) | Fixed | `spinkit()` calls `normalize_css_length(size, name = "size", strict = TRUE)` before dispatching to any of its twelve constructors. Numeric and unitless values get pixels; explicit length units remain intact. Both inline dimensions and wander's `--sk-size` receive that same normalized value. Invalid scalar lengths, unknown units, nonfinite numbers, vectors, and invalid types produce a clear `Invalid size` error (actual message has backticks). Existing NULL behavior still omits the explicit size. Tests: `fx3 N01: every SpinKit type receives the normalized size`; `fx3 N01: wander numeric sizes have their requested width and quarter-cycle travel`; `fx3 N01: all SpinKit types compute numeric and relative widths consistently`. |
| N02 / rx2h L01 (Low) | Fixed | The helper uses `css_number_regex` for bare numeric strings, consistently with colour parsing, and rejects trailing-dot numerals instead of creating invalid CSS. All five toast length arguments use the helper. Tests: `fx3 N02: trailing decimal dots are rejected as malformed CSS numbers`. |
| Alertify grammar | Fixed | Changed `alertify_alert() and alertify_notify() sends` to `send`, and the following `has` to `have`; regenerated `man/alertify.Rd` with `devtools::document()`. |
| NEWS | Done | Added one 0.2.2 line each for N01 and N02. Updated SpinKit size help and regenerated its Rd. |

Input tests are in `tests/testthat/test-fx3-inputs.R`; browser tests are in
`tests/testthat/test-fx3-browser.R` and use the existing chromote harness.
No snapshots were changed. Testthat rewrote five snapshot files' line endings;
`git diff --exit-code -- tests/testthat/_snaps` confirmed no content changes,
then those task-created rewrites were restored.

## Actual-after reproducer values

Fresh Chrome **157.0.8103.79**, viewport **992 x 800**, body font **16px**;
the first wander cube's animation was paused at one quarter of its duration.
The probe read computed width and the transform matrix's horizontal translation.
Evidence: `.fx3-tmp/probes.log`, `.fx3-tmp/wander-after.json`, and the passing
browser assertions.

| `spinkit(div(), type = "wander", size = ...)` | Inline width / height / `--sk-size` | Computed width | Quarter-cycle travel |
| --- | --- | --- | --- |
| `40` | `40px` / `40px` / `40px` | 40 px | 30 px |
| `"40"` | `40px` / `40px` / `40px` | 40 px | 30 px |
| `"40px"` | `40px` / `40px` / `40px` | 40 px | 30 px |
| `"2.5em"` | `2.5em` / `2.5em` / `2.5em` | 40 px | 30 px |
| omitted (default) | `40px` / `40px` / `40px` | 40 px | 30 px |

Every measured travel is **0.75 x computed width**. For every one of the twelve
types, the second browser test checks computed width and height: numeric 40,
unitless `"40"`, `"40px"`, and `"2.5em"` all give **40 x 40 px**; `"50%"`
in an explicit 200 x 200 px parent gives **100 x 100 px**, preserving relative
unit sizing. Existing fx2 M04 tests also pass for 4px, 400px, and 5em travel.

For N02, `normalize_css_length("12.")`, `normalize_css_length("+2.")`, and
`normalize_css_length("1.")`, and the corresponding `toast(title_size = ...)`
calls now all raise exactly:

```text
Invalid `length`: expected a single finite CSS length (e.g. 40, '40px', '2.5em' or '50%').
```

The valid controls produce `"12"` -> `"12px"`, `"12.5"` -> `"12.5px"`,
`".5"` -> `".5px"`, and `"12px"` -> `"12px"`, both directly and in the toast
payload. The malformed-input tests cover all five toast length arguments.
Existing comma-decimal tests and the new numeric SpinKit comma-decimal test
pass; numeric 12.5 still emits `12.5px` regardless of `OutDec`.

## Regression evidence and full suite

The four new test blocks were copied into a disposable archive of baseline
`d9d951a` and run with Chrome: **190 passed / 102 failed / 0 errors / 0 skipped**.
All **4/4** blocks fail on the baseline, including both browser blocks.
Evidence: `.fx3-tmp/baseline.log` and `.fx3-tmp/baseline-results.rds`.

The initial targeted run exposed a new test-fixture mistake: some internal
style attributes are vectors of fragments. The assertion was corrected to
join the fragments before matching. It did not require a package change.

Final validation, using the exact requested APIs:

```r
devtools::document()
r <- as.data.frame(devtools::test(reporter = "summary"))
sum(r$passed)  # 1811
sum(r$failed)  # 0
sum(r$error)   # 0
sum(r$skipped) # 0
```

**134 test blocks; 29/29 browser blocks actually ran; no skips.**
This includes all 27 existing browser blocks and both new browser blocks.
Evidence: `.fx3-tmp/full-tests.log` and `.fx3-tmp/full-results.rds`.
Chrome was explicitly launched with `--headless=new` and an explicit
`--user-data-dir` under `.fx3-tmp/`, avoiding the rx2d-noted Chrome 157 launch
issue. `NOT_CRAN=true` was set for this run. Every session and its owning
browser were closed in `finally`/`on.exit` handlers.

## Clean archive check

The checked source is local commit **2bf8d5a6fcbde1534322b8838da920b1a04fe8aa**
(`fix: normalize SpinKit sizes and reject trailing-dot lengths (fx3)`).
`git archive HEAD` was extracted into `.fx3-tmp/src` before building and checking.
Any later report-only commit changes only build-excluded `docs-dev/` content.
No manual, vignette, or other check-disabling flag was used.

Result: **0 errors / 0 warnings / 1 NOTE**, check process exit status **0**.
Environment: R **4.6.1 (2026-06-24 ucrt)**, Windows 11 x64, `LC_ALL=C`.
The check rebuilt the vignette and both PDF and HTML manuals successfully.
Its test runner reported **PASS 1292 / FAIL 0 / WARN 0 / SKIP 70**.
All 70 check-mode skips are `On CRAN`: 29 browser blocks and 41 snapshot tests.
All browser blocks ran in the separate full suite above.

The sole NOTE, verbatim from `.fx3-tmp/standby.Rcheck/00check.log`:

```text
* checking CRAN incoming feasibility ... [62s] NOTE
Maintainer: 'Aravind Hebbali <aravindhebbali@rsquaredacademy.com>'

New maintainer:
  Aravind Hebbali <aravindhebbali@rsquaredacademy.com>
Old maintainer(s):
  Aravind Hebbali <hebbali.aravind@gmail.com>
```

Tarball: `.fx3-tmp/standby_0.2.2.tar.gz`.
MD5: **`2964f3f2f74b812ce8c5b485ee8ce2ed`**.
The archive listing contains both new regression files and excludes all
fx1/fx2/fx3 scratch and `docs-dev/` material.
Logs: `.fx3-tmp/build.log`, `.fx3-tmp/check.log`, and
`.fx3-tmp/standby.Rcheck/00check.log`.

## Commands run

Read-only inspection used `git status`, `git branch --show-current`,
`git rev-parse`, `git diff`, `git log`, `rg`, `Get-Content`, `Get-Command`, and
process inspection. Source, tests, and scratch scripts were written with
patches; the R driver was written with PowerShell `Set-Content`.
All scratch, browser profiles/pages, R temporary files, archives, and logs
were confined to `.fx3-tmp/`, now both git-ignored and build-ignored.

```powershell
$env:LC_ALL = 'C'
$env:TMPDIR = (Resolve-Path .fx3-tmp).Path
$env:TMP = $env:TMPDIR
$env:TEMP = $env:TMPDIR

# R-heavy steps, including initial inspection, all used the required wrapper.
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx3 Rscript .fx3-tmp/inspect.R
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx3 Rscript .fx3-tmp/run-tests.R fx3
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx3 Rscript .fx3-tmp/run-tests.R

git archive --format=tar --output=.fx3-tmp/baseline.tar HEAD # HEAD was d9d951a
tar -xf .fx3-tmp/baseline.tar -C .fx3-tmp/baseline
Copy-Item -LiteralPath tests/testthat/test-fx3-inputs.R,tests/testthat/test-fx3-browser.R -Destination .fx3-tmp/baseline/tests/testthat
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx3 Rscript .fx3-tmp/baseline.R
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx3 Rscript .fx3-tmp/probes.R

git diff --check
git commit -m 'fix: normalize SpinKit sizes and reject trailing-dot lengths (fx3)'
git archive --format=tar --output=.fx3-tmp/head.tar HEAD
tar -xf .fx3-tmp/head.tar -C .fx3-tmp/src
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx3 bash .fx3-tmp/check.sh
Get-FileHash .fx3-tmp/standby_0.2.2.tar.gz -Algorithm MD5
tar -tzf .fx3-tmp/standby_0.2.2.tar.gz
```

The check script runs sequentially from `.fx3-tmp/`:

```text
R CMD build src
R CMD check --as-cran standby_0.2.2.tar.gz
```

The wrapper identified these steps as running inside queue job
`pkg-standby-fx3`, whose heavy slot was already counted.
No subagents, push, gh/GitHub operation, stash, branch switch, or merge was used.
All commits are local and their messages end with `(fx3)`.

Final process inspection found **no Chrome or R process** remaining after
the check. All jobs started for this task completed. Scratch artifacts remain
only in ignored `.fx3-tmp/` for review. No finding is deferred or partly fixed.

The final report-only commit is
`docs: record rx2 regression fixes and archive validation (fx3)`.
