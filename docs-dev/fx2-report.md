# standby fx2: fresh audit fixes

Worktree: `F:/R/Packages/_worktrees/standby-fx2`; branch: `task/standby-fx2`.
Baseline: `f624cf4cbaa6dc6b429bf469ffb9abdbf71dc7b5`.
Audit: `F:/pm/notes/2026-11-17-pkgs/pkg-standby-aud2-audit.md`.
Version remains **0.2.2**. Version 0.2.1 was never released; its NEWS entries
are merged into 0.2.2 and grouped by function. The 0.2.0 and older sections
are unchanged. No exports or arguments were added or removed; no dependency
was added. All 15 fresh-audit findings are fixed, with no decisions outstanding.

The fix-round rules and `docs-dev/fx1-report.md` were read before editing.
No AGENTS.md or CLAUDE.md was found in this worktree or its filesystem ancestors.
No other worktree was modified. No push, gh/GitHub operation, stash, branch
switch, or merge was performed. All scratch, archives, browser pages, temporary
libraries and R temporary files were confined to `.fx2-tmp/`, which is both
git-ignored and build-ignored. All R jobs used the required heavy-slot wrapper.

## Findings, regression tests, and actual reproducer results

Test file abbreviations below:

- **B**: `tests/testthat/test-fx2-browser.R`, real Chrome via the existing
  `helper-browser.R` / chromote harness.
- **R**: `tests/testthat/test-fx2-inputs.R`, testthat input/documentation tests.

Each row includes the audit case and at least one additional input. Test names
below are exact. Values are from `.fx2-tmp/probes.log`, `.fx2-tmp/earlier.log`,
and the passing final regression assertions. The browser checks use actual
computed paint, geometry, interaction, or lifecycle state rather than just
checking generated class names.

| Finding | Status | Fix location and behavior | Test file and exact test name | Expected and actual after |
| --- | --- | --- | --- | --- |
| H01 | fixed | `R/three-dots-handler.R:54`, `inst/three-dots/css/three-dots.css:334` and `:344`: both keyframe definitions use a per-instance faded colour with multiplied alpha. | B: `fx2 H01: flashing preserves hue and alpha at every phase` | At 750 ms, red main/before/after = `rgba(255, 0, 0, 0.6)` / `rgba(255, 0, 0, 0.2)` / `rgb(255, 0, 0)`; blue has the corresponding blue channels. `transparent` and zero-alpha RGBA have alpha 0 in every part. Matches expected; six animation phases and a four-digit hex-alpha variant also pass. |
| M01 | fixed | `inst/alertify/js/sbyAlertify.js:33`: remove every known type class before applying the current type. | B: `fx2 M01: reused Alertify alerts replace their type accent` | Error → success has exactly `sby-alert-success`, border `rgb(92, 184, 92)`; error → warning has exactly `sby-alert-warning`, border `rgb(240, 173, 78)`. Matches expected; message reset also passes. |
| M02 | fixed | `R/utils.R:309`, `:427`, `:435`, `:450`: validate whole number/separator syntax and uniform legacy comma-RGB channel units. Modern mixed units remain accepted. | R: `fx2 M02: malformed CSS colours are rejected completely`; B: `fx2 M02: accepted CSS colours actually paint in Chrome` | All eight audit inputs error in all four constructors, naming `Invalid color` (with backticks in the actual message). Two additional malformed variants also error. Named, hex 3/4/6/8, RGB/RGBA, HSL/HSLA, modern mixed-channel-unit, and transparent controls remain accepted. Accepted red formats actually paint red; transparent paints alpha 0. Matches expected. |
| M03 | fixed | `R/utils.R:563`: clamp channels to [0,255] before multiplying by .45, then round half-up; preserve alpha. | B: `fx2 M03: viz dots darken clamped CSS channels` | Helper returns `rgba(115, 0, 0, 1)` for all three out-of-range red inputs. At 500 ms the DOM paints `rgb(115, 0, 0)`. Negative-red/large-green half-alpha variant paints `rgba(0, 115, 0, 0.5)`. Matches expected. |
| M04 | fixed | `R/spinkit-handler.R:81`: set the wander instance's `--sk-size` from its size. | B: `fx2 M04: wander travel scales with each widget size` | Width/travel pairs = 4/3 px, 400/300 px and (5em) 80/60 px. Matches the expected .75 multiplier. |
| M05 | fixed | `R/spinkit-handler.R:60`: validate one nonmissing character type against all twelve supported names before either switch. Factors are explicitly rejected. | R: `fx2 M05: SpinKit rejects invalid scalar types` | `bogus`, NA, factor(wander), NULL, empty/vector, numeric and logical types all produce a clear error naming `type` and the twelve choices. Every supported type produces the requested `sk-*` class and a `standby-wait` element. Matches expected. |
| M06 | fixed | `inst/toast/js/iziToast.min.js:510`: observe the cover's actual used width, set the correct directional body margin to width + 10, and disconnect the observer on close. | B: `fx2 M06: relative cover widths reserve used space and resize` | 5em cover/margin = 70/80 px; 10vw = 99.1875/109.188 px at the probe viewport (computed serialization rounding). Both RTL directions match expected. Resizing to 992 and 1200 px also keeps margin = used width + 10 within .05 px. |
| M07 | fixed | `inst/toast/js/sbyToast.js:4` and `:18`: track actual live element identities in a Set and delete each once. `iziToast.min.js:342` and `:856`: ignore repeat closes and remove Escape listeners. | B: `fx2 M07: stale Escape and repeated clicks cannot drain the queue` | After the stale Escape or double-click sequence, actual visible messages = `[B]`; C stays queued. Closing B yields `[C]`. Three rapid identical mode-2 replacements keep only the final Same toast; Next appears only after it closes. Matches expected. |
| M08 | fixed | `R/utils.R:780`: format CSS numerals with decimal.mark = dot independently of OutDec. | R: `fx2 M08: CSS numbers ignore OutDec`; B: `fx2 M08: comma-decimal options preserve computed toast sizes` | With OutDec comma, payload and DOM title/message/image sizes = `12.5px` / `18.5px` / `12.5px`; variant = `0.5px` / `18.5px` / `0.5px`. Matches expected. |
| M09 | fixed | `R/pnotify-handler.R:129`, `inst/pnotify/js/notify.js:2`, `inst/pnotify/css/sbyNotify.css:12`: use a class that does not activate the bundled library's unsupported nonblock flag, delegate hover detection, pass body pointer events through, preserve and reveal controls. | B: `fx2 M09: nonblocking notices fade and pass clicks through with controls` | Ordinary opacity 1 → .2 on hover; translucent variant .7 → .2. Body pointer-events = none, both controls remain, underlying button receives exactly one real mouse click, and the visible closer successfully removes the notice. Leaving restores 1/.7. Matches expected. |
| M10 | fixed | `inst/tingle/js/sbyTingle.js:3`: destroy each modal in its onClose callback; footer-button class is locally scoped. | B: `fx2 M10: repeated Tingle closes remove nodes and listeners` | After 3 and 25 closes, with/without footer: 0 retained modal nodes, 0 resize listeners and 0 document keydown listeners. Matches expected bounded/clean state. |
| M11 | fixed | `inst/ns/css/sbyNS.css`, loaded after effect styles by `R/ns-dependencies.R`: defined semantic foreground/background colours for all layouts. | B: `fx2 M11: notice types have distinct computed appearance` | Notice/success/warning/error backgrounds = `rgb(151, 210, 241)` / `rgb(223, 240, 216)` / `rgb(252, 248, 227)` / `rgb(242, 222, 222)`. Four distinct appearances in growl/jelly and bar/slidetop. Matches expected. |
| L01 | fixed | `inst/bootbox/js/sbyBootbox.js:22`, `inst/bootbox/css/sbyBootbox.css`: scoped responsive fallback when the actual Bootstrap modal version is 3. | B: `fx2 L01: extra-large BootBox works with default Bootstrap 3` | At viewport 992, small/large/extra-large widths = 300/900/932 px; at 1200 = 300/900/1140 px. Extra-large exceeds large and fits the viewport. Matches expected. |
| L02 | fixed | `R/toast-handler.R:133`: validate exact trimmed string syntax before integer coercion. | R: `fx2 L02: toast display modes require exact integers` | `0.9`, `1.9`, `2.9`, `-0.9`, `1.0`, `1e0`, empty and NA strings error: `display_mode must be one of 0, 1, 2` (actual names have backticks). Numeric/string 0/1/2 and surrounding whitespace on an integer remain accepted. Matches expected. |
| L03 | fixed | All twelve shared `R/*-handler.R` return sections and regenerated `man/*.Rd`: distinguish helper dependencies/tag lists from sender side effects and the loaders tag return. | R: `fx2 L03: shared help describes actual dependency returns` | Alertify/Notify/NS/Tingle/Toast helpers return html_dependency; BootBox/MicroTip and all five loader helpers return shiny.tag.list containing dependencies; loaders() returns shiny.tag. The seven help value sections contain accurate helper and sender text, with no None. Matches expected. |

## Re-run of the earlier findings

All 27 rows of the audit's earlier-findings section were checked again. Fresh
defects that previously made four rows partial are covered in the table above.
The original regression files were preserved and run with Chrome; additional
direct probes are in `.fx2-tmp/probes.R` and `.fx2-tmp/earlier.R`.

| Earlier ID | Actual after, compared with expected | Status |
| --- | --- | --- |
| H01 | `a.b`, `a:b`, `1plot` event probes: output/loader = hidden/visible on recalculation and visible/hidden on value; text = Expected text. All three literal tooltip ids receive label tip; missing target does not throw. The colon test is DOM dispatch, not a claim about Shiny colon output-client names. | fixed |
| H02 | Ordinary red dot phases stay red-channel; dark phase channel 115. Out-of-range variants now also darken to 115 (aud2 M03). | fixed |
| H03 | Chase/circle/circle-fade/fold pairs each paint red then blue in their pseudo-elements. | fixed |
| H04 | Carousel shadows remain requested red; flashing main/pseudo paint now also preserves hue and transparent alpha (aud2 H01). | fixed |
| H05 | All 657 R colour names compare exactly with col2rgb; comparison TRUE. | fixed |
| H06 | rebeccapurple, signed hue, deg hue, and modern slash RGB all accepted; all four comparison results TRUE. Malformed inputs now rejected separately (aud2 M02). | fixed |
| H07 | Zero-alpha red shade = rgba(255,0,0,0); .5-alpha × .2 = .1; eight-digit hex-alpha × .2 = .1004. Other shade strengths remain covered by the original R regressions. | fixed |
| H08 | RGB 30% = 77, 70% = 179; HSL lightness 30% = 77/77/77. | fixed |
| H09 | NULL title/body produce no literal null; direct notices contain whitespace only. Default title still reads Hey. | fixed |
| H10 | Strong/span inputs become DOM elements; ordinary markup strings create zero corresponding elements and remain literal text. | fixed |
| H11 | infinity and Inf: 1 notice after 1.3 seconds; finite 50 ms control: 0. | fixed |
| H12 | Translucent opacity = .7; restored after leaving a nonblocking notice. | fixed |
| H13 | small → NULL and small → fit both remove the size attribute (DOM null). | fixed |
| H14 | TRUE/FALSE/static backdrop × Escape FALSE/TRUE: remaining dialog counts 1/0 for each backdrop. | fixed |
| H15 | Default/explicit 50px covers remain 50px; numeric 80 cover/margin = 80/90px; relative-unit extension fixed by aud2 M06. | fixed |
| H16 | Computed title line-height = 28px, message font-size/line-height = 24px/48px; locale variants fixed by aud2 M08. | fixed |
| H17 | Mode 0 queues until close; mode 1 leaves one blue replacement; mode 2 rapid identical replacement and subsequent queue work. Repeated close variants fixed by aud2 M07. | fixed |
| H18 | Interactive vizload preview has lv-bars and eight bar children; invalid preview choices error. | fixed |
| H19 | Combined CSS Loaders/Spinners styles leave spinner pseudos display block and overflow visible. | fixed |
| H20 | RGB/RGBA/HSL/HSLA each construct types 5 and 8 without errors; all direct comparisons TRUE. | fixed |
| M01 | DESCRIPTION/check maintainer = aravindhebbali@rsquaredacademy.com. | fixed |
| M02 | Version 0.2.2, exactly one corresponding NEWS heading, no 0.2.1 heading, CRAN comments updated, older NEWS retained. | fixed |
| M03 | testthat >= 3.1.5 and jsonlite/chromote in Suggests; dependency checks pass. | fixed |
| M04 | First error border = rgb(217,83,79); reused success/warning now reset their type accent (aud2 M01). | fixed |
| L01 | Both README sources remain free of the removed tinyverse badge. | fixed |
| L02 | Vignette has no buzz text; all six interactive preview server closures emit standby messages. | fixed |
| L03 | Actual helper classes and all shared value sections match; missing seven topics completed by aud2 L03. | fixed |

## Regression evidence and checks

The new tests were run before implementation, then refined to avoid secondary
fixture errors and copied into an untouched git archive of f624cf4. The final
baseline run (`.fx2-tmp/baseline-final.log`) has **17/17 new test blocks failing**:
**260 passed assertions, 191 failed, 0 errors, 0 skipped**. Every finding has a
failing regression block; all twelve new browser blocks actually ran.

Final source-tree validation (`.fx2-tmp/final-tests.log`):

```text
devtools::document()
r <- as.data.frame(devtools::test(reporter = "summary"))
sum(r$passed)  = 1519
sum(r$failed)  = 0
sum(r$error)   = 0
sum(r$skipped) = 0
browser blocks = 27; actually run = 27
```

No full-suite skip reasons apply because there were no skips. The browser
tests retain the existing clean skips for CRAN, unavailable chromote/Chrome,
and STANDBY_BROWSER_TESTS=false. The local run enabled NOT_CRAN and explicitly
selected installed Google Chrome; it did not disable or skip browser tests.

Clean archive checked: **d8f0100**. Subsequent report-only commits affect
build-excluded `docs-dev/` material. Build/check used `.fx2-tmp/src` extracted
from `git archive HEAD`; the source tarball does not contain scratch or reports.
R 4.6.1 on Windows 11; check included vignette reconstruction and the PDF/HTML
manuals with TinyTeX. No `--no-manual` or check-disabling flags were used.

Final clean-archive result: **0 errors / 0 warnings / 1 NOTE**. Check exit
status 0. Its test runner reports **PASS 1142 / FAIL 0 / WARN 0 / SKIP 68**.
All 68 check-mode skips are explicitly `On CRAN`: 27 browser test blocks plus
41 snapshot tests. Those browser blocks ran in the separate full suite above.

The sole NOTE, verbatim from `standby.Rcheck/00check.log`:

```text
* checking CRAN incoming feasibility ... [40s] NOTE
Maintainer: 'Aravind Hebbali <aravindhebbali@rsquaredacademy.com>'

New maintainer:
  Aravind Hebbali <aravindhebbali@rsquaredacademy.com>
Old maintainer(s):
  Aravind Hebbali <hebbali.aravind@gmail.com>
```

Tarball: `.fx2-tmp/standby_0.2.2.tar.gz`.
MD5: **`aa62805cf774bfec91a9519a77ee6d98`**.
Log: `.fx2-tmp/standby.Rcheck/00check.log`; build log: `.fx2-tmp/build.log`.
The tar listing was checked: neither `.fx2-tmp/` nor `docs-dev/` is included.

## Commands run

Read-only inspection used git status/diff/log, rg, Get-Content and process
inspection. The commands that generated or changed artifacts were:

```powershell
# Set before every R invocation; all R temp files stay in the allowed scratch.
$env:LC_ALL = 'C'
$env:TMPDIR = (Resolve-Path .fx2-tmp).Path
$env:TMP = $env:TMPDIR
$env:TEMP = $env:TMPDIR

# Required wrapper used for all R-heavy work (including preliminary runs).
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/run-tests.R fx2 baseline
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/document.R
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/run-tests.R fx2 fixed1
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/run-tests.R fx2 fixed2
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/run-tests.R
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/final-test.R
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/probes.R
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/earlier.R

git archive --format=tar --output=.fx2-tmp/base.tar f624cf4
tar -xf .fx2-tmp/base.tar -C .fx2-tmp/base
Copy-Item -LiteralPath tests/testthat/test-fx2-inputs.R,tests/testthat/test-fx2-browser.R -Destination .fx2-tmp/base/tests/testthat
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 Rscript .fx2-tmp/baseline.R

git archive --format=tar --output=.fx2-tmp/head.tar HEAD
tar -xf .fx2-tmp/head.tar -C .fx2-tmp/src
bash "$HOME/.claude/bin/heavy-slot.sh" pkg-standby-fx2 bash .fx2-tmp/check.sh
Get-FileHash .fx2-tmp/standby_0.2.2.tar.gz -Algorithm MD5
git diff --check
```

The check script ran, sequentially from `.fx2-tmp/`:

```text
R CMD build src
R CMD check --as-cran standby_0.2.2.tar.gz
```

The baseline and final suite were rerun after test refinements; the clean
build/check was rerun after the final test commit. Preliminary harness errors
were corrected rather than counted as passes. `.fx2-tmp/update-docs.py` and
`.fx2-tmp/news.py` performed mechanical text edits; other changes used patches.
Testthat rewrote snapshot line endings without content differences; those five
agent-created changes were restored with git restore before committing. No
snapshot expectations were weakened or updated for these fixes.

Local commits:

```text
c0e06f5 fix: resolve aud2 H01, M01-M11 and L01-L03 regressions (fx2)
fbe0625 docs: consolidate unreleased changes under standby 0.2.2 (fx2)
d8f0100 test: isolate aud2 validation failures and cover rapid toast reuse (fx2)
```

## Follow-ups and limits

No audit finding is deferred, partly fixed, or awaiting a decision. No known
wrong result from this audit remains.

The following release work remains outside this local fix-round request:

1. Recheck the reverse dependency xplorerr against the final 0.2.2 tarball and
   record the actual result in cran-comments.md before submission. No reverse
   dependency check was performed here.
2. Run win-builder release/devel and/or R-hub checks on this final tarball and
   record those results before submission. This task checked local Windows R
   4.6.1 only and performed no external submission or CI run.
3. Configure Chrome and NOT_CRAN=true in CI if continuous browser-regression
   coverage is wanted. Local browser coverage was complete; CRAN intentionally
   skips browser tests and snapshots.
4. Preserve the iziToast close/listener/cover-width patches, the PNotify bridge
   and styling, the NS type stylesheet, and the Bootstrap 3 fallback when
   updating the bundled vendor libraries. Relative cover measurement uses the
   browser ResizeObserver API; the regression run used installed Chrome.
5. As already documented after fx1, notify() renders tag HTML but does not
   install htmlDependency objects attached to those tags. Dependency injection
   would require a separate transport change; this audit requested no such API.

All chromote sessions were closed with session$close(), and each R browser
driver closed its default chromote browser in a finally block. Final Windows
process inspection found no Chrome or R process attributable to this worktree
or `.fx2-tmp/`. All jobs started for this task completed. Scratch artifacts were
left only in the ignored `.fx2-tmp/` directory for review; no server or browser
was left running.
