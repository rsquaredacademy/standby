# standby 0.2.2 rendering fixes (standby-fx6)

Date: 2026-11-19. Base: `aa38d8b186755665432507b2bb790a39687d40f7`, branch
`task/standby-fx4`. The branch was kept in place. No push, GitHub operation,
CRAN submission, or external message was made.

The Carbon findings H1-H4, M1 and L1-L3 are addressed. All 60 documented types
are retained. This is the local implementation and Chrome verification report;
the independent Carbon re-gate and Claude contact-sheet review required by
`F:/pm/notes/package-audit-stop-rule.md` still precede submission (target
Saturday, 2026-11-21). No independent reviewer is claimed by this report.

## Findings and evidence

| Finding | Before | After | Evidence |
| --- | --- | --- | --- |
| H1: threeDots | Six shadow types painted their animation about 10,000px off screen, two emoji types painted full-width bars, and spin/overtaking painted an extra centre dot. | A dedicated on-screen wrapper centres each shadow projection while its source retains the upstream off-screen offset. This preserves solid centres and original keyframes. Emoji elements have explicit widths and transparent backgrounds. The wrapper sets colour variables without overriding intentional transparency. Gooey types read the same colour variable. All 20 types pass raster and geometry checks, with extra solid-centre pixel assertions for pulse/fire. | [Before](pkg-standby-fx6-h1-before.png), [after](pkg-standby-fx6-h1-after.png). |
| H2: music | No data variant was emitted, so the documented music loader was blank. | Emits the upstream `data-hey-oh` variant, displaying an animated two-sided coin. The help names this default. | [Before](pkg-standby-fx6-h2-before.png), [after](pkg-standby-fx6-h2-after.png). |
| H3: loader style/text | Supplying text erased style. Blink injected generic text pseudo-element rules into incompatible graphics, and unsupported options were silently ignored. | Keeps style and text together for supported pairs. Half: default; inverse: default/bar; rounded: bar/bar-ping-pong; blink: default/bar/border. Text: default/bar/border/curtain/smartphone. Unsupported combinations name the offending argument and supported types. Text must be NULL or one non-missing string. | [Before](pkg-standby-fx6-h3-before.png), [after](pkg-standby-fx6-h3-after.png); [supported option grid](pkg-standby-fx6-options.png). The rejected double/blink case is deliberately shown as an error in the after image. |
| H4: SpinKit children | Swing emitted 3 dots and wander 4 cubes, duplicating child 1 and increasing its opacity. | Swing emits exactly 2 dots and wander exactly 3 cubes. Every type has an explicit browser child-count assertion; rgba, hsla and alpha-hex swing/wander cases also render in Chrome. | [Before](pkg-standby-fx6-h4-before.png), [after](pkg-standby-fx6-h4-after.png). |
| M1: vizLoad size | NULL/empty inputs gave blank errors; factors/lists gave contradictory errors; closures failed inside sprintf. | Uses scalar choice validation before interpolation. Every invalid input gives an error naming `size` and listing the valid choices for that type. | `test-fx6-inputs.R` exercises NULL, character(0), factor, list, closure, NA, vector, logical, numeric and unknown-string inputs across all 8 types. |
| L1: previews | SpinKit emitted empty width/height/colour declarations and a dark square on black; loader preview omitted `sby-loader`. | Empty properties are omitted, the SpinKit preview defaults to white, and CSS Loaders includes its scoped class. | [Before](pkg-standby-fx6-l1-before.png), [after](pkg-standby-fx6-l1-after.png); explicit HTML assertions in `test-fx6-inputs.R`. The preview loader snapshot changes only the class. |
| L2: spinner CSS | Spinner 5 emitted bare animation declarations before a keyframe block. | Generated CSS begins directly with the scoped keyframe rule. | An explicit CSS assertion plus Chrome rendering of all 8 spinner types. |
| L3: docs/messages/metadata | Tooltip default and compatibility sentinels were incompletely documented; five toast length errors named `length`; dependency revisions and CRAN comments were stale. | Help now documents NULL/fit/empty tooltip sizing, empty toast transitions, and stay-open sentinels. Toast errors name the actual parameter. All 13 bundled dependency revisions are 0.2.2. CRAN comments reflect this local run. | Regenerated 8 affected Rd pages, existing sender/input tests, and dependency tests. |

The combined-family grid additionally exposed dependency-order centering:
SpinKit/VizLoad family CSS could override shared absolute positioning if another
family had already registered `standby.css`. The shared child selector now wins
that cascade. VizLoad line presets also cap their nominal width at the output
width, preventing overflow in ordinary smaller outputs. Both behaviours are
covered by the same browser grid, with all five families' dependencies resolved
together in real `use*()` order.

## Supported domain and regression grid

The five spinner help pages and NEWS state the visual contract: the documented
types, colour formats, positive finite SpinKit sizes, VizLoad type/size choices,
and loader style/text combinations; a modern browser with CSS animation enabled
and enough space for the chosen graphic. Transparent colours intentionally hide
graphics, and emoji types retain native colours. CSS Loaders uses a viewport
overlay; its largest default graphic needs at least 320 by 320 pixels.

The new Chrome gate contains **131 cases**:

| Coverage | Cases |
| --- | ---: |
| Three Dots: every documented type | 20 |
| CSS Loaders: every documented type | 12 |
| SpinKit: every documented type at 40px | 12 |
| Single Element CSS Spinners: types 1-8 | 8 |
| VizLoad: every documented type at its default size | 8 |
| Every supported loader style, with/without text where supported; curtain/smartphone text | 17 |
| Every SpinKit type at 24px and 64px | 24 |
| Swing/wander in rgba, hsla and alpha-hex | 6 |
| Every additional supported VizLoad size | 24 |

Each case uses the exported wrapper and real dependency resolution, including
shared CSS, jquery and the standby bridge. Tests assert a visible non-zero
animation container inside the 360 by 320 viewport, no horizontal overflow, a running animation
and computed animation names on elements/pseudo-elements, exact expected child
counts, visible raster paint, and changed raster pixels at two animation times.
Raster bounds must leave margins and avoid a full-width bar, except for the
intentional border-edge loader and VizLoad line types. The union of both frames
is inspected because pulse/fold animations can legitimately be invisible at one
instant. The two times preserve each animation's delays and stagger.

The six projected Three Dots types deliberately keep their shadow source off
screen, inside a separate centering container. Moving those shadows to zero
would clip out their centres against the transparent source's border box.
The tests inspect both the on-screen container and actual raster paint, with
specific solid-centre checks to catch that otherwise plausible wrong rendering.

[The required type contact sheet](pkg-standby-fx6-types.png) contains all 60 types
plus four H3/H4 reproductions. [The option/size sheet](pkg-standby-fx6-options.png)
contains 65 additional examples. Both were opened and visually inspected,
including focused H1, H3 and H4 images. The before images are rendered from a
temporary `git archive` of `aa38d8b` with the same current renderer, without
changing this worktree or its branch. Contact sheets pause all animations at a
common elapsed time within each widget, preserving stagger; pulse and VizLoad
dots use a visibly expanded phase. Pixel regression tests use separate times.

## Validation

Environment: Windows 11 x64, R 4.6.1 (ucrt), chromote 0.5.1, headless Google
Chrome 157.0.8103.79.

* `devtools::test()`: **5,853 passed**, **0 failures, 0 errors, 0 warnings,
  0 skips**, across **172 test blocks**. All **42 live Chrome blocks** and all
  **41 snapshot blocks** executed. The new gate contributes 8 Chrome blocks
  and 131 browser cases. See [full test log](fx6-logs/test.log) and
  [per-block totals](fx6-logs/test-results.csv).
* `devtools::check(document = FALSE, args = "--as-cran")`: **0 errors,
  0 warnings, 0 notes**, `Status: OK`. Installed-package tests and both vignette
  rebuilds passed. Installed-package tests passed **5,852 assertions**, with
  zero failures, warnings or skips; the one source-only README.Rmd assertion
  is not applicable to the built package. See [check log](fx6-logs/check.log) and
  [installed-package test log](fx6-logs/check-test.log).
  The checked tarball's MD5 is `2d2638a7b5755ecc10885156cca6cbf2`.
* `devtools::document()` regenerated only the eight help pages described above.
* `git diff --check`: clean.

The initial package check stopped before code checks because the inherited
`LC_ALL=C.UTF-8` locale is unsupported by this Windows R installation. It also
identified the worktree `.git` marker in the tarball. The final check uses the
supported C locale; `.Rbuildignore` excludes the worktree marker and local audit
Markdown. The local audit inputs remain outside the commit. Incoming remote
checks are disabled by devtools' normal local-check settings; this is not a
claim of CRAN's incoming decision.

## Snapshot changes (reviewed individually)

No blanket snapshot acceptance was used. Exactly four snapshot records in two
files change:

1. `loaders.md`, `glanceLoaders() generates the correct HTML`: add `sby-loader`
   so the preview receives the same scoped loader CSS as the public wrapper.
2. `loaders.md`, `loaders generates the correct HTML`: preserve `data-half`
   alongside `data-text="Loading..."`, as the documented example requests.
3. `spinkit.md`, `spinkit_swing() generates the correct HTML`: remove the third,
   unstyled duplicate dot.
4. `spinkit.md`, `spinkit_wander() generates the correct HTML`: remove the fourth,
   unstyled duplicate cube.

Existing tests were adjusted only where they asserted the superseded behaviour:
the rounded style test uses bar, half-plus-text is retained, VizLoad size errors
use the new clear argument label, toast errors name their own parameter, and
dependency tests expect bundled revision 0.2.2.

## Reproduction commands

Run from the worktree in PowerShell. Each R invocation uses a script file:

```powershell
$env:LC_ALL='C'; $env:LC_CTYPE='C'
Rscript docs-dev/pkg-standby-fx6-verify.R document
Rscript docs-dev/pkg-standby-fx6-render.R before
Rscript docs-dev/pkg-standby-fx6-render.R after
Rscript docs-dev/pkg-standby-fx6-render.R after options
Rscript docs-dev/pkg-standby-fx6-verify.R test
Rscript docs-dev/pkg-standby-fx6-verify.R check
git diff --check
```

The verify script sets `NOT_CRAN=true` and `STANDBY_BROWSER_TESTS=true`; Chrome
must be installed for the live gate. Browser tests retain `skip_on_cran()` for
CRAN's own test environment.

## Backlog and release boundary

No H1-H4, M1 or L1-L3 items are deferred. The following Carbon out-of-domain
items remain recorded locally under the stop rule, without creating GitHub
issues because this task prohibits GitHub operations:

* B1: invalid NA notification title/text can serialize as null.
* B2: BootBox's animation class lacks scalar class-token validation.
* B3: invalid non-string content in string-only senders can produce ignored or
  stale content. Only notify documents tag objects.
* B4: existing match.arg NULL/partial-prefix conventions differ from exact
  validators. The loaders(text = NA) portion is fixed in this round.
* B5: very long timeouts beyond 2^31-1 milliseconds and iziToast duplicate-mode
  selectors for unusual base64 IDs remain upstream/edge backlog.

Independent cross-family review and final submission remain release workflow
steps. This report does not replace that review or authorize submission before
the requested clean independent re-gate.
