# standby 0.2.2 fix round 4

Worktree: `F:/R/Packages/_worktrees/standby-fx4`. Branch: `task/standby-fx4`.
Baseline: `46a430b`. Package version remains **0.2.2**. Date: 2026-11-18.
The entire root `AUDIT-standby-022.md` was read, including its coverage table,
verified controls, and verdict. That supplied audit remains untracked and is
not part of any commit or build. No AGENTS.md was found in the workspace,
its filesystem ancestors, or the touched source/test/report directories.

## Findings, changes, and before/after evidence

| Finding | Disposition | Before on 46a430b | After and regression test |
| --- | --- | --- | --- |
| H1: NULL toast title/message | **FIXED** | Shiny serialized an omitted message as `"message":null`; iziToast threw `Cannot read properties of null (reading 'length')` and displayed nothing. | `toast()` converts NULL title and message to empty strings before sending. `test-fx4-h1.R` captures the actual `MockShinySession` message, serializes it with `shiny:::toJSON()`, and checks both fields are strings with no JSON null. Cases cover the default call, title-only call, either NULL field, and both NULL. Chrome displays the default and NULL-title/body variants. It polls for a toast with nonzero height using `requestAnimationFrame`, with a deadline and no fixed wait. |
| H2: undocumented HTML interpretation | **FIXED, documentation only** | Ten shared/documented content parameters had no HTML interpretation or escaping warning. | Each relevant `@param` for `alertify_alert()`, `alertify_notify()`, `bootBox()`, `tingle()`, `toast()` and `notice()` now says: “Interpreted as HTML. Escape untrusted input with `htmltools::htmlEscape()`.” This includes Alertify's OK label and Tingle's footer label. Roxygen regenerated all five help topics; Alertify's two senders share one topic. One NEWS bullet under 0.2.2 names all six functions. `test-fx4-h2.R` inspects each parameter in the generated Rd, both from development source and installed help. Rendering is preserved; the fresh Chrome pass confirmed intentional HTML still renders in all six senders. |
| M1: loader style attribute injection and vector condition error | **FIXED** | Arbitrary style text became an attribute name; a vector produced `the condition has length > 1`. | Styles are validated before any text override against `half`, `inverse`, `rounded`, `blink`, or NULL. Attribute names come from fixed literals; user style text is never pasted into an attribute name. Blink now creates separate `data-text` and `data-blink` attributes. Help lists the valid styles. `test-fx4-m1.R` rejects the audit injection, unknown names, vectors, NA, empty vectors, logicals and numbers, with and without text; it checks exact attribute names for every valid style and preserves text's existing style override. |
| M2: eight unvalidated message senders | **FIXED** | Unsupported categories were silently forwarded; malformed delays were accepted; logical NA/vector conditions failed late; numeric PNotify width was ignored; an empty Bootbox message failed in JavaScript. | All eight senders validate their enumerated options and logical flags before sending. Errors identify the argument and valid choices. Alertify validates types, transitions and six positions; Tingle validates button types and positions; PNotify validates types, animation and speed; toast validates type, theme, seven positions, two layouts, transitions and existing display modes; notice validates types, layouts and layout-specific effects; MicroTip validates positions and sizes. Delays are finite numeric scalars, with numeric strings normalized and supported sentinels retained. PNotify numeric width/heights become pixel strings while CSS expressions and NULL height limits remain supported. Empty/NULL/missing/vector Bootbox messages raise an R error. `test-fx4-m2.R` covers rejected and accepted categories, all logical flags, durations/delays, sentinels, dimensions, aliases and the question toast in Chrome. |
| M3: non-positive SpinKit lengths | **FIXED** | Zero, negative and NULL sizes were accepted; zero hid the spinner and negative dimensions were discarded by the browser. | After existing CSS-length syntax/unit normalization, `spinkit()` requires a finite magnitude greater than zero. This deliberately rejects explicit NULL as well as zero and negatives; the documented default remains 40px. `test-fx4-m3.R` exercises all twelve types with numeric, unitless, unit-bearing, percent and exponent forms. Positive relative lengths remain valid. Help now specifies a positive CSS length. |
| L1: invalid default effect/layout pairing | **FIXED** | Attached and bar layouts inherited jelly, which has no animation in their stylesheets. | `effect = NULL` selects growl/jelly, attached/flip, or bar/slidetop. Explicit effects are checked against the selected layout. Roxygen documents these defaults. `test-fx4-l1.R` verifies defaults, every supported explicit pairing, and rejected cross-layout pairings. Chrome confirms every layout's default has a computed animation name. |

The bundled implementation was the source of the accepted values, rather than
an external library version. Evidence reviewed: Alertify's notifier position
switch and transition CSS; Bootbox's size switch and backdrop normalization;
Tingle's button CSS; PNotify's defaults, animation handling, icon handling and
dimension setters; iziToast's position array, method definitions and animation
CSS; NotificationFx's options and the three bundled layout stylesheets; and
MicroTip's bridge and attribute selectors.

Supported values retained beyond the original documentation include Bootbox
`sm`/`lg`/`xl`, NULL/empty standard size, and case-insensitive `static` backdrop;
PNotify custom icon class strings; MicroTip NULL/empty/fit size reset; toast
NULL theme/type, empty theme/transition, character layout `"2"`, and disabled
timeouts FALSE/NULL/zero. Numeric delay strings are normalized. Alertify's
non-positive delays still keep a notice open. PNotify `"infinity"`, `"infinite"`
and positive numeric infinity still disable hiding. Tests exercise these values.
Free-form CSS expressions remain strings; validators do not attempt to parse
all browser CSS expression syntax or enumerate user-defined CSS classes.

## NULL sender review

The other seven senders and their bridges/libraries were reviewed for the same
NULL-to-null string-operation failure as H1:

* Alertify checks strings/HTMLElement inputs before content operations; labels
  use `innerHTML` without an unguarded string-method call.
* Bootbox allows a NULL title, maps NULL backdrop to static, and tolerates NULL
  className. Its required message is now checked in R under M2.
* Tingle constructs its button class as a string, then splits that constructed
  string. Its nullable content exposed a different `appendChild(null)` failure;
  M2 now maps NULL content to an empty string, with a payload regression.
* PNotify already maps NULL title/text to FALSE. Dimension setters test the
  value's type, and NULL maxTextHeight intentionally removes the limit.
* NotificationFx concatenates content and class names; it does not call string
  methods on nullable message content.
* MicroTip explicitly guards NULL ids and NULL sizes. Tooltip content is passed
  to `setAttribute`, not to a string method or HTML parser.
* Within iziToast, title/message were the unguarded nullable fields. Its image
  `.replace()` is guarded by a truthiness check, size/color fields are guarded,
  and imageWidth is normalized. Optional NULL color, image and theme payload
  fields are not the H1 crash; they remain supported.

Thus optional NULL backdrop, height-limit and tooltip-reset values are **NOT A
BUG**, with the upstream handling above as evidence. The new H1 regression
specifically requires no null in the vulnerable title/message string fields;
it does not prohibit intentional nullable options elsewhere in the payload.

## Fresh coverage table

The audit's five coverage dimensions were repeated for every touched public
function. Validation here covers enum, logical, timer, and relevant dimension
contracts; unrestricted HTML/CSS text remains the documented caller input.

| Function | Argument validation | Documentation versus defaults | Reaches JavaScript correctly | Escaping | Edge input |
| --- | --- | --- | --- | --- | --- |
| alertify_alert | PASS: type, transition, thirteen logical options | PASS; HTML warning on title/message/label | PASS: label, resizable and modal options retained; default payload recaptured | Raw HTML, now explicitly documented | Missing/vector logicals and invalid choices rejected before sending |
| alertify_notify | PASS: type, six positions, numeric delay | PASS; HTML warning on message | PASS: delay/position/type payload and HTML rendering checked | Raw HTML, documented | Numeric-string delay normalized; zero/negative delay retained |
| bootBox | PASS: size, flags, backdrop, required non-empty message | PASS; aliases/static backdrop documented; L3 show limitation remains | PASS: onEscape, closeButton, className, backdrop and canonical sizes | Raw HTML, documented | Empty/NULL message rejected in R; NULL backdrop remains valid |
| tingle | PASS: close flag, button type/position | PASS; HTML warnings on content and button label | PASS: content, footer and button fields; existing cleanup/browser tests pass | Raw HTML, documented | NA close flag produces a named error; NULL content becomes empty text |
| notify | PASS: type, flags, animation/speed, delay; numeric dimensions normalized | PASS; custom icon strings and numeric dimensions documented | PASS: actual Shiny JSON recaptured; numeric width measured at 500px on `.pnotify-container` | PASS: plain strings still escaped; trusted tags remain HTML | NULL title/text and max-height limit retained; infinite delay disables hiding |
| toast | PASS: type/theme, position, layout, transitions, flags, duration and existing display mode | PASS; HTML warnings; library's question type added to docs | PASS: title/message strings; question dispatch; existing timeout/drag/display-mode and CSS-size regressions pass | Raw HTML, documented | Default/NULL cases display in Chrome; invalid positions fail in R |
| notice | PASS: type/layout and effect for the selected layout | PASS: layout-specific defaults documented | PASS: default payload and computed animations in all three layouts | Raw HTML, documented | NULL effect selects a supported effect; cross-layout effects rejected |
| microTip | PASS: eight positions and supported sizes/reset values | Existing L3 NULL-versus-fit wording retained as requested | PASS: literal id and attribute values; reset tests pass | PASS: text-only attribute; markup does not create elements | NULL id remains a no-op; NULL/empty/fit resets size |
| spinkit | PASS: existing type/color checks plus strictly positive CSS length | PASS: positive length and 40px default | Not applicable: rendered HTML/CSS; all twelve types covered | Existing validated color and escaped tag construction retained | Zero, negative, NULL and malformed lengths rejected; positive relative sizes retained |
| loaders | PASS: existing type validation plus style allowlist | PASS: allowed styles and NULL documented | Not applicable: rendered HTML; existing snapshots pass | PASS: attribute names are fixed literals, text uses htmltools escaping | Injection and vector style rejected clearly, including when text overrides style |

The shared validators were also reviewed for scalar length checks, NA,
nonfinite values, complex/factor/list inputs and named error messages. The
existing CSS normalization and infinite-delay helper controls continue to pass.

New findings during this pass, all **FIXED** within M2:

1. iziToast implements a `question` method, but the bridge's type switch routed
   it to plain `show()`. The type is accepted, documented, and now dispatched to
   `question`; Chrome checks its yellow question styling.
2. Bootbox accepts the `xl` alias, but standby's Bootstrap 3 width fallback only
   recognized `extra-large`. Aliases now normalize to canonical sizes before
   sending, so `xl` receives the same fallback. Payload tests cover all aliases.
3. Tingle's NULL content was forwarded into `appendChild(null)`. It now receives
   an empty string. The payload test fails on the release candidate.

No additional submission blocker was found in the reviewed functions. The
fresh browser probe also confirmed HTML rendering is preserved in all six H2
senders, ordinary PNotify strings remain escaped, numeric PNotify width is
applied to the correct container, and MicroTip treats markup as tooltip text.

## Regression results

All test executions were in disposable copies under:

`C:/Users/DELL/AppData/Local/Temp/standby-fx4-483f3d9a7d874702ac317eb5893edc20`

The `baseline` copy is a clean `git archive 46a430b` with only the new test files
overlaid. The `current` copy contains the fixes. No test command was run in the
working source tree, and no snapshot rewrite was copied back.

| Test file | Baseline failed expectations | Baseline errors | Baseline passes | Fixed passes | Fixed failures/errors |
| --- | ---: | ---: | ---: | ---: | --- |
| test-fx4-h1.R | 14 | 1 | 4 | 22 | 0 / 0 |
| test-fx4-h2.R | 20 | 0 | 0 | 20 | 0 / 0 |
| test-fx4-m1.R | 4 | 1 | 0 | 19 | 0 / 0 |
| test-fx4-m2.R | 190 | 1 | 156 | 1000 | 0 / 0 |
| test-fx4-m3.R | 144 | 0 | 84 | 228 | 0 / 0 |
| test-fx4-l1.R | 21 | 0 | 18 | 39 | 0 / 0 |

Combined new-test baseline run: **12 tests, 393 failed expectations, 3 errors,
262 passed expectations, no skips**. Each requested item has a regression
that fails on 46a430b and passes after its fix. The early aborts in H1/M1/M2
explain why baseline and fixed expectation totals differ.

Full `devtools::test()` on the fixed disposable copy: **146 tests, 3,139 passed
expectations, zero failed expectations, zero errors, zero warnings, zero
skips**. Specifically, `sum(r$failed) == 0` and `sum(r$error) == 0`, where `r`
is the test result converted to a data frame. Chrome ran rather than skipping:
Chrome **157.0.8103.79**, R **4.6.1 (2026-06-24 ucrt)**, Windows 11 x64.
New browser tests use the package's existing Chrome probe and skip policy.
The fresh standalone browser review ended with `FRESH_PASS_OK`.

Roxygen **8.1.1** regenerated the affected help. After the six fix commits,
`devtools::document(); git diff --exit-code` succeeded with no tracked diff.
`git diff --check` also passed. Initial R processes printed existing Windows
startup locale warnings for `C.UTF-8`; these were not test warnings. Build/check
used `LC_ALL=C` and `LANG=C`.

## Clean archive build and CRAN check

Checked source commit: **31587165be911d8904c4e55003f43bb2046c73a7**.
It was HEAD when `git archive HEAD` was extracted into disposable `source/`.
The later report commit changes only build-excluded `docs-dev/` content.

`R CMD build source` succeeded, including installing the package and creating
its vignettes. `R CMD check --as-cran --no-manual standby_0.2.2.tar.gz`
succeeded with process exit status **0**: **0 errors, 0 warnings, 1 NOTE**.
Examples, installed tests, vignette checks and vignette rebuilding all passed.
Installed check-mode tests: **2,612 passes, 73 skips, zero failures/warnings**.
The skips are the 41 existing snapshot tests and 32 browser blocks under the
package's CRAN skip policy; all ran in the separate development suite.

The only NOTE, verbatim:

```text
* checking CRAN incoming feasibility ... [41s] NOTE
Maintainer: 'Aravind Hebbali <aravindhebbali@rsquaredacademy.com>'

New maintainer:
  Aravind Hebbali <aravindhebbali@rsquaredacademy.com>
Old maintainer(s):
  Aravind Hebbali <hebbali.aravind@gmail.com>
```

Tarball: `standby_0.2.2.tar.gz` under the disposable validation directory.
SHA256: `ad38979dcf27c459f47a33c370deae69fb64a2972168d107702828d8342b746d`.
Logs there: `baseline-h1.log`, `baseline-h2.log`, `baseline-m1.log`,
`baseline-m2.log`, `baseline-m3.log`, `baseline-l1.log`,
`baseline-all-fx4.log`, corresponding `after-*.log` files,
`after-m2-combined.log`, `full-tests.log`, `fresh-pass.log`, `build.log`,
`check.log`, `standby.Rcheck/00check.log`, and
`standby.Rcheck/tests/testthat.Rout`.

## Commands run

Read-only inspection used `Get-Location`, `Get-Date`, `Get-Content`,
`Get-ChildItem`, `Get-Command`, `Test-Path`, `rg --files`, `rg -n`, `rg -o`,
`git status --short`, `git log`, `git rev-parse HEAD`, `git diff --stat`,
`git diff --check`, and Python reads/searches of bundled JavaScript and CSS.
Source, tests and this report were edited with `apply_patch`; a Python edit
added the HTML parameter wording and NEWS bullet. Temporary R drivers were
written with PowerShell `Set-Content`. Commands below show the complete
validation workflow; `$V` is the disposable directory stated above.

```powershell
$V = 'C:/Users/DELL/AppData/Local/Temp/standby-fx4-483f3d9a7d874702ac317eb5893edc20'
git archive 46a430b -o "$V/baseline.zip"
Expand-Archive -LiteralPath "$V/baseline.zip" -DestinationPath "$V/baseline"
# Each test file was copied and tested as its item was implemented.
Copy-Item tests/testthat/test-fx4-*.R "$V/baseline/tests/testthat/"
Get-ChildItem -Force | Where-Object { $_.Name -notin @('.git','AUDIT-standby-022.md') } | Copy-Item -Destination "$V/current" -Recurse -Force
# After subsequent edits, only the changed source/help/test/assets were recopied.
Copy-Item R,man,tests,inst "$V/current" -Recurse -Force

Rscript "$V/run-tests.R" "$V/baseline" fx4-h1
Rscript "$V/run-tests.R" "$V/current" fx4-h1
Rscript "$V/run-tests.R" "$V/baseline" fx4-h2
Rscript "$V/run-tests.R" "$V/current" fx4-h2
Rscript "$V/run-tests.R" "$V/baseline" fx4-m1
Rscript "$V/run-tests.R" "$V/current" fx4-m1
Rscript "$V/run-tests.R" "$V/baseline" fx4-m2
Rscript "$V/run-tests.R" "$V/current" fx4-m2
Rscript "$V/run-tests.R" "$V/current" 'fx4-(h1|h2|m1|m2)'
Rscript "$V/run-tests.R" "$V/baseline" fx4-m3
Rscript "$V/run-tests.R" "$V/current" fx4-m3
Rscript "$V/run-tests.R" "$V/baseline" fx4-l1
Rscript "$V/run-tests.R" "$V/current" fx4-l1
Rscript "$V/run-tests.R" "$V/baseline" fx4
Rscript "$V/run-tests.R" "$V/current"
Rscript "$V/fresh-pass.R" "$V/current"

Rscript -e "devtools::document()"
git diff --exit-code
git diff --check
git archive HEAD -o "$V/head.zip"
Expand-Archive -LiteralPath "$V/head.zip" -DestinationPath "$V/source"
$env:LC_ALL = 'C'
$env:LANG = 'C'
# These commands ran with the disposable directory as working directory.
& 'C:/Program Files/R/R-4.6.1/bin/R.exe' CMD build source
Remove-Item Env:NOT_CRAN -ErrorAction SilentlyContinue
& 'C:/Program Files/R/R-4.6.1/bin/R.exe' CMD check --as-cran --no-manual standby_0.2.2.tar.gz
Get-FileHash "$V/standby_0.2.2.tar.gz" -Algorithm SHA256
```

Test commands redirected all output to the named logs. The R test driver was:

```r
args <- commandArgs(TRUE)
setwd(args[1])
Sys.setenv(NOT_CRAN = "true")
testthat::set_max_fails(Inf)
r <- as.data.frame(devtools::test(
  filter = if (length(args) > 1) args[2] else NULL,
  stop_on_failure = FALSE
))
cat("TEST_TOTALS tests=", nrow(r), " failed=", sum(r$failed),
    " error=", sum(r$error), " skipped=", sum(r$skipped),
    " passed=", sum(r$passed), "\n", sep = "")
quit(status = if (sum(r$failed) + sum(r$error) > 0) 1 else 0)
```

## Local commits

1. `2113241` — Fix NULL toast title and message payloads (standby-fx4)
2. `e938b5a` — Document HTML rendering and escaping for six senders (standby-fx4)
3. `15b3626` — Validate loader styles and use fixed attribute names (standby-fx4)
4. `4f2fc14` — Validate eight message senders and preserve library options (standby-fx4)
5. `0c1c0d0` — Require positive CSS lengths for SpinKit sizes (standby-fx4)
6. `3158716` — Choose a valid default notice effect for each layout (standby-fx4)

This report is a separate report-only commit. No push, gh/GitHub access,
branch switch, other worktree access, or subagent delegation was used.

## Follow-ups deliberately left open

* **L2 — dependency identity and cache versions.** Generic dependency names and
  version 0.1.0 remain unchanged. A later release should select package-specific
  dependency names and meaningful versions, account for standby's local library
  patches, and test htmltools conflict resolution and browser cache invalidation
  when another package supplies a dependency with the same generic name.
* **L3 — MicroTip default wording.** The help still describes fit-to-text as the
  default while the R signature uses NULL. The bridge intentionally treats NULL
  and `fit` equivalently, so behavior is retained; reconcile the wording later.
* **L3 — Bootbox show argument.** `bootBox(show = FALSE)` still creates a dialog
  without returning a handle that the caller could subsequently show. Preserve
  this API for the patch release; decide later whether to return/manage handles,
  add a show operation, or deprecate that argument. Loader style documentation,
  also listed under L3, was necessarily addressed as part of M1.
* **Existing audit edge outside the requested functions — vizLoad add_label.**
  `vizLoad(add_label = NA)` still raises a raw missing-boolean error. `vizLoad()`
  was not changed in this round; add a named scalar logical validation in a
  subsequent maintenance change.

HTML escaping remains the caller's responsibility for the six documented H2
senders, as explicitly requested for this patch release. Applications that
intentionally pass HTML retain that behavior.
