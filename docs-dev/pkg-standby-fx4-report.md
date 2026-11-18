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


## Fix round 5

Date: 2026-11-18. Baseline: **166da1819f8a6c675379498fe131bb8b8f73486b**.
Fix commit: **0545568998e83ad01830bc9e33900dbaa228383b**.
Version remains **0.2.2**. The entire supplied `AUDIT-standby-022-rx4.md`
was read. Both root audit files remain untracked and are excluded from the
validation copies and commits. Work stayed on `task/standby-fx4` in the
requested worktree. No push, gh/GitHub access, branch switch, other worktree
access, or subagent delegation was used.

### Findings and regression evidence

The new tests are `tests/testthat/test-fx5-regressions.R` and
`tests/testthat/test-fx5-browser.R`. Every requested finding has a test that
fails on clean 166da18 and passes with the fix. Existing fx4 choice/delay tests
were updated to reflect the restored supported options, retaining their
invalid-value checks (including negative infinity).

| Finding | Status | Before on 166da18 | After / test |
| --- | --- | --- | --- |
| R1: infinite toast duration | **FIXED** | `toast(duration = Inf)` raises a finite-number error. | Infinite delay is mapped to `FALSE` before normalization; Shiny JSON contains `"timeout":false`. Tests cover named Inf and the shared `"infinity"`/`"infinite"` sentinels. A real Chrome test waits for the toast to open and checks the library's timeout setting and absence of a close timer. Roxygen/Rd and NEWS document never-close values. |
| R2: infinite/NULL Alertify delay | **FIXED** | Both `delay = Inf` and `delay = NULL` raise finite-number errors. | Both map to numeric `0` before normalization; negative finite delays remain supported. Payload tests cover NULL, Inf, named Inf and both string sentinels. Chrome checks each real Alertify notification's delay is zero, its close timer is absent, and it rendered. Help and NEWS document these values. |
| R3: custom toast themes | **FIXED** | `theme = "mytheme"` raises an allowlist error. | Any one non-NA string without whitespace, control characters or quotes is accepted, including custom class suffixes and the existing empty/default values. Tests reject ASCII/Unicode whitespace, both quotes and attribute-breakout examples. Named theme inputs are unnamed. Chrome verifies `iziToast-theme-mytheme`. |
| R3: layout 3 and entrance animations | **FIXED** | Layout 3 and `revealIn` / `slideIn` raise allowlist errors. | Numeric/integer/string 3 become integer 3; both transitions are accepted. Separate tests fail independently on the baseline. Chrome verifies `iziToast-layout3`, its computed 2px border radius, and the exact computed `iziT-revealIn` / `iziT-slideIn` animation names. All are documented. |
| N2: integer/named numeric zero Bootbox messages | **FIXED** | `0` errors, but `0L` and named numeric zero reach JS. | A numeric equality check catches every numeric zero, including integer and named values. Tests retain string `"0"` and positive integer messages. |
| N3: named validated values | **FIXED** | Named choices and flags are returned with names; named FALSE duration errors; `notice(layout = c(growl = "growl"))` becomes a JSON object. | All scalar validators return unnamed values, and every caller assigns the returned value. Per-argument flag validation replaces the side-effect-only `validate_flags()` helper. CSS length normalization also removes names; icon/backdrop and atomic Bootbox content discard names before use. Direct helper tests and actual Shiny JSON comparisons cover all eight senders, every logical sender argument, custom icons, backdrop and the audit's named layout. Colour validators' four constructor callers also consume the result. |
| M2 rest: missing vizLoad label flag | **FIXED** | `add_label = NA` gives `missing value where TRUE/FALSE needed`. | Scalar logical validation gives `` `add_label` must be TRUE or FALSE. `` Tests cover NA, NULL, empty/vector logicals, strings and both valid flags. |
| M-A: omitted behaviour changes in NEWS | **FIXED** | Twelve new required release-note assertions fail. | NEWS lists the eight senders and every newly validated argument; per-layout NULL notice defaults; question toast; Bootbox aliases/static backdrop; numeric PNotify dimensions; loader styles; strictly positive SpinKit sizes and rejection of NULL; restored never-close handling; custom toast styles; named scalar handling; zero Bootbox messages; vizLoad labels; NULL Tingle content and NULL toast fields. A release-note regression test and generated-help checks pass. |
| N1: NULL SpinKit size | **Documented, intentionally retained** | NULL is rejected by fx4's positive-size requirement. | Rejection remains as explicitly permitted/requested. NEWS now says NULL, zero and negative sizes are rejected and the default is still `"40px"`. |

The shared infinity predicate also excludes complex values before recognizing
numeric sentinels. A control test confirms complex infinity gives the named
finite-number error for all three notification senders; it already passed on
the baseline and is not counted as a newly failing regression.

### Compatibility re-check and complete allowed sets

I re-read all R validation sites, the pre-fx4 source/help at `46a430b`, and the
bundled bridges/libraries/styles. This review covers supported library options;
arbitrary unknown values that merely fall through to a default, produce an
unstyled class, or rely on JavaScript truthiness are not additional supported
choices. There were no further supported option-set regressions after R1-R3.
The explicit SpinKit NULL/zero/negative rejection remains the requested exception.
Existing positive-input tests exercise every finite choice and every logical
flag; fx5 adds the missing library-supported toast options and named-input checks.

| Function / validated argument | Allowed values after fx5; bundled evidence |
| --- | --- |
| `alertify_alert(type)`, `alertify_notify(type)` | `success`, `error`, `warning`, `message`; bridge switch/type classes. |
| `alertify_alert(transition)` | `pulse`, `slide`, `zoom`, `fade`, `flipx`, `flipy`; `.ajs-*` incoming/outgoing animation selectors in `alertify.min.css`. |
| `alertify_alert()` flags | `transition_off`, `closable`, `auto_reset`, `frameless`, `maximizable`, `modal`, `movable`, `move_bounded`, `overflow`, `padding`, `pinnable`, `resizeable`, `start_maximized`: each one non-NA `TRUE` or `FALSE`. |
| `alertify_notify(position)` | `bottom-right`, `bottom-left`, `bottom-center`, `top-right`, `top-left`, `top-center`; notifier's top/bottom and left/right/center positioning. |
| `alertify_notify(delay)` | Any finite real number, including negative and zero, or a numeric string; NULL, positive Inf, and case-insensitive/trimmed `infinity` / `infinite` map to 0. Bundled `delay(a)` coerces `+a` and arms a timer only for values greater than zero. |
| `bootBox(size)` | `small` / `sm`, `large` / `lg`, `extra-large` / `xl`, empty string, NULL. Aliases normalize to long names, including the Bootstrap 3 extra-large fallback. Bundled Bootbox explicitly switches over these aliases. |
| `bootBox(backdrop)` | TRUE, FALSE, NULL, or case-insensitive `static`; static maps to NULL, which the bridge maps to Bootstrap's static backdrop. |
| `bootBox()` flags / message | `close_on_escape`, `show`, `close_button`, `animate`: scalar non-NA logical. Message: nonempty scalar atomic content or HTML/tag content; NULL, length-zero/vector atomic input, NA, FALSE and every numeric zero are rejected before Bootbox's `if (!r.message)` guard. String `"0"` is retained. |
| `tingle(close_button)` | One non-NA TRUE/FALSE. |
| `tingle(button_type / button_position)` | `default`, `primary`, `danger` / `right`, `left`; all corresponding `tingle-btn--*` CSS selectors exist. |
| `notify(type)` | `notice`, `info`, `success`, `error`; all four bridge dispatches exist. |
| `notify(animation / animate_speed)` | `none`, `fade` / `slow`, `normal`, `fast`. PNotify core tests for fade; only the three `pnotify-fade-*` speeds are styled. No Animate module is bundled. |
| `notify(icon)` | One non-NA logical or string (custom icon classes, including empty string). |
| `notify()` flags | `hide`, `sticker`, `closer`, `shadow`, `mouse_reset`, `translucent`, `non_blocking`: one non-NA TRUE/FALSE each. |
| `notify(delay)` | Finite non-negative real number/numeric string; positive Inf or case-insensitive/trimmed `infinity` / `infinite` disables hiding. The library's never-close sentinel is numeric Infinity; R preserves that behaviour by setting hide to FALSE. |
| `notify(width / min_height / max_text_height)` | NULL or one non-NA CSS string, including `auto`, `calc(...)`, `var(...)` and reset/empty values; finite bare numbers/numeric strings become pixel strings. Trailing-decimal-dot forms are rejected. PNotify assigns dimensions only for strings. |
| `toast(type)` | `info`, `success`, `warning`, `error`, `question`, NULL; all five bundled methods exist and the bridge dispatches them. |
| `toast(theme)` | NULL, or any one non-NA string without whitespace/control characters/single or double quotes, including empty string. iziToast uses `classList.add('iziToast-theme-' + theme)`, supporting custom themes. |
| `toast(position)` | `bottomRight`, `bottomLeft`, `topRight`, `topLeft`, `topCenter`, `bottomCenter`, `center`; same seven library positions. |
| `toast(layout)` | 1, 2, 3 or strings `"1"`, `"2"`, `"3"`; normalized to integers. Base style is layout 1; CSS explicitly styles layout 2 and 3. |
| `toast(duration)` | Finite non-negative real number/numeric string, FALSE, NULL, positive Inf, or case-insensitive/trimmed `infinity` / `infinite`. Inf/string sentinels normalize to FALSE. Falsy timeout values disable the bundled close timer. |
| `toast(transition_in)` | `bounceInLeft`, `bounceInRight`, `bounceInUp`, `bounceInDown`, `fadeIn`, `fadeInDown`, `fadeInUp`, `fadeInLeft`, `fadeInRight`, `flipInX`, `revealIn`, `slideIn`, empty string, NULL. All twelve animations have bundled CSS. |
| `toast(transition_out)` | `fadeOut`, `fadeOutDown`, `fadeOutUp`, `fadeOutLeft`, `fadeOutRight`, `flipOutX`, empty string, NULL. These are the six bundled exit animations. |
| `toast()` flags | `balloon`, `close`, `close_on_escape`, `close_on_click`, `rtl`, `drag_to_close`, `pause_on_hover`, `reset_on_hover`, `overlay`, `overlay_close`, `animate_inside`: one non-NA TRUE/FALSE each. |
| `toast(display_mode)` | Numeric 0, 1, 2, or exact digit strings (surrounding whitespace allowed); normalized to integers. Existing bridge queue/replacement semantics are unchanged. |
| `toast()` normalized dimensions | `title_size`, `title_line_height`, `message_size`, `message_line_height`, `image_width`: same CSS-string/finite-number normalization as PNotify dimensions; NULL image width selects the existing 50px default. Other NULL dimensions remain NULL. |
| `notice(type / layout)` | `notice`, `success`, `warning`, `error` / `growl`, `attached`, `bar`; bundled layout/effect CSS and the four `sbyNS.css` type styles. |
| `notice(effect)` | Growl: `jelly`, `scale`, `slide`, `genie`; attached: `flip`, `bouncyflip`; bar: `slidetop`, `exploader`. NULL selects the first entry for the chosen layout. Cross-layout effects are rejected, matching the old help's supported combinations. |
| `microTip(position / size)` | Position: `top`, `bottom`, `left`, `right`, `top-left`, `top-right`, `bottom-left`, `bottom-right`. Size: `fit`, `small`, `medium`, `large`, empty string, NULL. CSS styles all eight positions and three fixed widths; JS removes the size attribute for fit/empty/NULL. |
| `loaders(style)` | `half`, `inverse`, `rounded`, `blink`, NULL; all four data-attribute selectors exist. Supplying text retains the existing override to no style. |
| `loaders(type)` | `default`, `bar`, `bar-ping-pong`, `border`, `double`, `clock`, `curtain`, `pokeball`, `ball`, `smartphone`, `bouncing`, `music`; existing `match.arg()` retains unambiguous prefixes. |
| `spinkit(type / size)` | Exact types: `plane`, `chase`, `bounce`, `wave`, `pulse`, `flow`, `swing`, `circle`, `circle-fade`, `grid`, `fold`, `wander`. Size: finite strictly positive number/numeric string (pixels), or strictly positive CSS length. Units: px, em, rem, ex, rex, cap, rcap, ch, rch, ic, ric, lh, rlh, cm, mm, Q, in, pt, pc, %, viewport vw/vh/vi/vb/vmin/vmax with optional s/l/d prefix, and cqw/cqh/cqi/cqb/cqmin/cqmax (case-insensitive). NULL is intentionally rejected. |
| `spinners(type)` | Integers 1 through 8, numeric equivalents, or exact digit strings with optional surrounding whitespace. |
| `threeDots(type)` | `elastic`, `pulse`, `flashing`, `collision`, `revolution`, `carousel`, `typing`, `windmill`, `bricks`, `floating`, `fire`, `spin`, `falling`, `stretching`, `gathering`, `hourglass`, `overtaking`, `shuttle`, `bouncing`, `rolling`; existing unambiguous `match.arg()` prefixes retained. |
| `vizLoad(type / size / add_label)` | Types: `bars`, `squares`, `circles`, `dots`, `spinner`, `dashed`, `line`, `bordered_line`, with existing unambiguous type prefixes. Line types: `fluid`, `large`, `medium`, `small`; other types: `large`, `medium`, `small`, `tiny`. `add_label`: one non-NA TRUE/FALSE. |
| Four spinner constructors' `color` | Single non-NA valid R/CSS colour name, transparent, currentColor, hex 3/4/6/8, rgb/rgba and hsl/hsla (legacy and modern supported syntax). `vizLoad()` also permits NULL. Prior colour/alpha/channel tests remain intact. |
| Preview helpers | `previewAlerts(type)`: `alertify`, `bootbox`, `notice`, `notify`, `tingle`, `toast`; `previewSpinners(spinner)`: `threedots`, `spinkit`, `vizload`, `spinners`, `loaders`. Existing unambiguous `match.arg()` prefixes retained. |

Whitespace/quote class rejection, unknown enum values, invalid cross-layout
effects and invalid/missing scalar flags are intentional validation, not a loss
of a styled bundled option. R1-R3 restore supported, meaningful library options
that the fx4 validation excluded.

### Validation results

All test runs took place in disposable copies under:

`C:/Users/DELL/AppData/Local/Temp/standby-fx5-22db13a6161742b781c71af48e7cf83d`

`baseline/` is clean `git archive 166da18` with only the two new fx5 test files
overlaid. `current/` contains the final source and tests, excluding `.git` and
both audit files. Snapshot rewrites in disposable copies were not copied back.

* Baseline new-test run: **14 tests, 23 failed expectations, 10 errors,
  12 passed expectations, zero skips**. The extra complex-infinity control is
  already passing. Early errors stop some baseline loops, so pass totals differ.
* Fixed new-test run: **14 tests, 170 passed expectations, zero failures,
  errors, warnings or skips**, including both Chrome tests.
* Final full `devtools::test()` run: **160 tests, 3,305 passed expectations,
  zero failures, errors, warnings or skips**. Explicitly, `sum(r$failed) == 0`
  and `sum(r$error) == 0`. Chrome tests ran, rather than skipping.
  R 4.6.1 (2026-06-24 ucrt), Windows 11 x64.
* After committing source/help/tests, `devtools::document(); git diff --exit-code`
  completed successfully with **no tracked diff**. `git diff --check` passed.
* A clean `git archive HEAD` at fix commit **0545568** was extracted to
  `source/`, built, and checked with `R CMD check --as-cran --no-manual`.
  Both processes exited **0**; check result: **0 errors, 0 warnings, 1 NOTE**.
  The only NOTE is the maintainer email change, quoted below. Installed tests:
  **2,765 passes, 75 skips, zero failures/warnings**. Skips are the 41 existing
  snapshot tests and 34 browser blocks under the existing CRAN skip policy;
  all ran in the development suite. Examples, installation, vignette checks
  and vignette rebuilding passed.

```text
* checking CRAN incoming feasibility ... [40s] NOTE
Maintainer: 'Aravind Hebbali <aravindhebbali@rsquaredacademy.com>'

New maintainer:
  Aravind Hebbali <aravindhebbali@rsquaredacademy.com>
Old maintainer(s):
  Aravind Hebbali <hebbali.aravind@gmail.com>
```

Tarball SHA256:
`e3dc5a8485c00deb45b674348f7d30c4af33649c8e3c5e8effeef17ca92d85a4`.
The only later change is this build-excluded report.

### Commands and artifacts

The read-only review used `Get-Content`, `rg`, `git show 46a430b:...`,
`git diff`, `git status`, and Python UTF-8 reads/searches of bundled source.
Edits used `apply_patch` and Python; no test was run in the working source tree.
The test driver writes result data frames (excluding list columns) to
`baseline-results.csv` and `current-results.csv` outside the copies, and prints
`sum(r$failed)`, `sum(r$error)`, `sum(r$skipped)` and `sum(r$passed)` explicitly.

```powershell
$v = 'C:/Users/DELL/AppData/Local/Temp/standby-fx5-22db13a6161742b781c71af48e7cf83d'
git archive 166da18 -o "$v/baseline.zip"
Expand-Archive -LiteralPath "$v/baseline.zip" -DestinationPath "$v/baseline"
Copy-Item tests/testthat/test-fx5-*.R "$v/baseline/tests/testthat/"
# Create current/ from the working source, excluding .git and both audit files.
Get-ChildItem -Force | Where-Object { $_.Name -notin @('.git','AUDIT-standby-022.md','AUDIT-standby-022-rx4.md') } | Copy-Item -Destination "$v/current" -Recurse -Force
# After edits, recopy changed source/help/tests/NEWS only.
Rscript "$v/run-tests.R" "$v/baseline" fx5
Rscript "$v/run-tests.R" "$v/current" fx5
Rscript "$v/run-tests.R" "$v/current"
# Logs: baseline.log, after-fx5.log, full-tests.log, full-tests-final.log.
git add NEWS.md R man tests/testthat/test-fx4-m2.R tests/testthat/test-fx5-regressions.R tests/testthat/test-fx5-browser.R
git commit -m 'Restore notification options and normalize validated inputs (standby-fx5)'
$env:LC_ALL = 'C'
$env:LANG = 'C'
Rscript -e 'devtools::document()'
git diff --exit-code
git diff --check
git archive HEAD -o "$v/head.zip"
Expand-Archive -LiteralPath "$v/head.zip" -DestinationPath "$v/source"
# Run the following in the disposable validation directory.
& 'C:/Program Files/R/R-4.6.1/bin/R.exe' CMD build source
Remove-Item Env:NOT_CRAN -ErrorAction SilentlyContinue
& 'C:/Program Files/R/R-4.6.1/bin/R.exe' CMD check --as-cran --no-manual standby_0.2.2.tar.gz
Get-FileHash standby_0.2.2.tar.gz -Algorithm SHA256
```

Driver (`run-tests.R`):

```r
args <- commandArgs(TRUE)
setwd(args[1])
Sys.setenv(NOT_CRAN = "true")
testthat::set_max_fails(Inf)
r <- as.data.frame(devtools::test(
  filter = if (length(args) > 1) args[2] else NULL,
  stop_on_failure = FALSE
))
write.csv(r[, !vapply(r, is.list, logical(1))],
          paste0(args[1], "-results.csv"), row.names = FALSE)
cat("TEST_TOTALS tests=", nrow(r), " failed=", sum(r$failed),
    " error=", sum(r$error), " skipped=", sum(r$skipped),
    " passed=", sum(r$passed), "\n", sep = "")
quit(status = if (sum(r$failed) + sum(r$error) > 0) 1 else 0)
```

Final archive/check logs: `build.log`, `check.log`,
`standby.Rcheck/00check.log`, `standby.Rcheck/tests/testthat.Rout`.
The final report-only commit changes build-excluded `docs-dev/` content.
This round closes the earlier report's open `vizLoad(add_label)` follow-up;
its L2 dependency identities/cache versions and L3 wording/API follow-ups remain
outside this round.
