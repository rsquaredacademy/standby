# standby fx1 — fixes for the pre-CRAN audit of 0.2.1

Worktree: `F:/R/Packages/_worktrees/standby-fx1`
Branch: `task/standby-fx1`, based on `origin/release/v0.2.1` (release candidate; H20 already fixed there)
Version after fixes: **0.2.2**
Audit: `F:/pm/notes/2026-11-14-pkgs/cx-standby-audit.md` (27 findings: 20 High, 4 Medium, 3 Low)

All work is local; nothing was pushed, no GitHub/gh command was used, no branch was
switched or merged, and no stash was created. Scratch files live in `.fx1-tmp/`
(git-ignored, build-ignored) and the report is in `docs-dev/` (committed).

## Status by finding

| Finding | Severity | Status | What changed / reason |
| --- | --- | --- | --- |
| H01 | High | fixed | `inst/standby/js/standby.js` uses `event.target` and guards output/parent/loader instead of `querySelector('#' + id)`. `inst/microtip/js/microtip.js` uses `document.getElementById(String(id))` and ignores missing elements. Literal ids `a.b`, `a:b`, `1plot` work. |
| H02 | High | fixed | `viz_dots()` passes `--lv-dots-color` / `--lv-dots-color-dark` on each dot; the `lv-dots_pulsate_animation` keyframes read those variables (with the old colours as fallbacks) instead of hard-coded `#1ddab5`/`#0B5345`. Computed animation colours are red for `color = "red"`. |
| H03 | High | fixed | `spinkit()` generates a unique id for the four types whose colour is drawn by a pseudo-element and scopes the rule to `#id .sk-*-dot:before`; other types are untouched (so their snapshots/markup do not change). |
| H04 | High | fixed | `threeDots()` adds `--primary-color` to the scoped `#id` rule. Keyframes that use `box-shadow` now resolve the requested colour; carousel probes return `rgb(255, 0, 0)`. |
| H05 | High | fixed | New colour parser resolves every named colour through R's colour values (`grDevices::col2rgb()`), with a CSS table for the nine CSS-only names (`rebeccapurple`, `aqua`, …). Named colours are normalised to one hex/RGBA value before the main colour and shades are emitted; `green` is `#00FF00`, `gray50` is `#7F7F7F`, `purple` shades are `rgba(160,32,240,0.2)`. Documented in NEWS and the `color` parameter docs (documented-contract clarification, not an API change). |
| H06 | High | fixed | `validate_color()` now uses a strict parser for names, hex 3/4/6/8, `rgb()`/`rgba()`/`hsl()`/`hsla()` in legacy comma and modern space/slash syntax, signed hues and `deg`/`grad`/`rad`/`turn`. The four audit inputs are accepted; `;`, braces, quotes, `url()` and extra tokens are still rejected. |
| H07 | High | fixed | Parsed alpha is multiplied by each shade strength: `rgba(255,0,0,0)` stays fully transparent, `rgba(...,0.5)` yields 0.1/0.25/0.35 shades, 8-digit hex alpha is preserved. `transparent` remains transparent after name normalisation. |
| H08 | High | fixed | Channels are quantised half-up (`floor(x + 0.5 + 1e-9)`) after clamping, matching CSS serialisation: 30% → 77 (was 76), 70% → 179. Shade channels use the same value as the main colour. |
| H09 | High | fixed | `notify()` maps `NULL` title/text to PNotify's `FALSE` sentinel and never sends JSON `null`; DOM text no longer contains `null`. |
| H10 | High | fixed | Tag inputs are rendered with `htmltools::as.tags()`/`as.character()`; `titleTrusted`/`textTrusted` are set only for tag/HTML inputs. Plain strings remain escaped. (HTML dependencies attached to tags are not installed — documented.) |
| H11 | High | fixed | `delay = "infinity"` (case-insensitive) and `delay = Inf` set `hide = FALSE` and a numeric delay, so the notice stays open; verified after 1.3 s. |
| H12 | High | fixed | New `inst/pnotify/css/sbyNotify.css` (loaded after BrightTheme) gives `.pnotify.translucent.pnotify-in` opacity 0.7; computed opacity after settling is 0.7. |
| H13 | High | fixed | MicroTip removes `data-microtip-size` for `NULL`, `""` or `"fit"` and sets it otherwise; verified by applying `small` then `NULL`. |
| H14 | High | fixed | The BootBox bridge uses `bootbox.dialog()` with an explicit OK button instead of `bootbox.alert()`, which overwrote `onEscape`. Escape keeps the dialog open with `close_on_escape = FALSE` and closes it with `TRUE`. |
| H15 | High | fixed | `toast()` defaults `image_width = "50px"`, normalises bare numbers to `px`, and the bundled iziToast width/margin code appends `px` only to unit-less values (and treats a missing width as 50). Default and documented widths compute to `50px`. |
| H16 | High | fixed | Bundled iziToast checked `isNaN(s.titleSize)` for all three lengths; each now checks its own value, and R normalises numeric lengths to `px`. `title_line_height = "2em"`, `message_size = 24`, `message_line_height = "2em"` compute to 28px / 24px / 48px, including with `title_size` unset. |
| H17 | High | fixed | Bridge implements documented modes: 0 queues until the current toast closes, 1 replaces the displayed toast(s), 2 keeps the library's replace-an-identical-toast rule (now documented with its identity basis). `display_mode` validates 0/1/2. Verified counts/colours in Chrome. |
| H18 | High | fixed | `previewSpinners()` uses `match.arg()` and the same `vizload` spelling in both switches, rendering `vizLoad(tags$div(), type = "bars")` (8 bars). `previewAlerts()` is validated too. |
| H19 | High | fixed | CSS Loaders' base `.loader`, `.loader:before/:after` and `.loader.is-active` rules are scoped to `.loader.sby-loader`; `loaders()` adds that class. Spinner pseudo-elements compute `display: block` and the loader keeps `overflow: visible`. |
| H20 | High | already fixed on release; verified | The release-branch parser fix is present; the new tests re-run the functional-colour crash cases (types 5/8 with rgb/rgba/hsl/hsla) and they pass. No separate change was needed. |
| M01 | Medium | fixed | `cre` email is `aravindhebbali@rsquaredacademy.com`; generated Maintainer matches. |
| M02 | Medium | fixed | Version 0.2.2 (next patch after 0.2.1 per brief), NEWS heading `standby 0.2.2`, `cran-comments.md` rewritten with the actual local check evidence and the TODO removed. |
| M03 | Medium | fixed | `testthat (>= 3.1.5)` declared (tests use `expect_no_error()`/`expect_no_match()`); `jsonlite` and `chromote` added to Suggests for the browser tests. |
| M04 | Medium | fixed | `alertify_alert(type = ...)` now adds `sby-alert sby-alert-<type>` to the dialog; shipped CSS gives a type-specific top border and header colour (verified `rgb(217,83,79)` for `error`). Docs state the effect for alerts and notifications. |
| L01 | Low | fixed | Removed the 404 tinyverse badge from `README.Rmd` and regenerated `README.md`; `urlchecker::url_check()` reports all URLs correct. |
| L02 | Low | fixed | Preview messages and the vignette say standby; the pkgdown site was regenerated (`docs/`), so generated articles no longer say buzz. |
| L03 | Low | fixed | `@return` for `use*()`/loader constructors and previews describes the returned HTML dependency / tag list / browsable object; Rd regenerated. |

No finding is left as "needs decision". Two contract clarifications are recorded in
NEWS because they affect documented behaviour:

1. Colour names now follow R's `colors()` values (the package always accepted R
   names but emitted some of them literally). This is documented on every `color`
   parameter.
2. `toast(display_mode = 2)` is documented as the bundled library's
   replace-an-identical-toast mode; modes 0 and 1 now do what the docs already
   promised.

## Tests added

New files:

* `tests/testthat/test-audit-fixes.R` — 21 fast R-level regression test blocks (113 expectations) covering
  H01–H19, M01/M03/M04 and L01 (payloads, generated CSS/markup, bundled bridge
  source, DESCRIPTION/README metadata).
* `tests/testthat/test-browser-regressions.R` — 15 real-Chrome tests
  (`chromote`; `skip_on_cran()` and skipped if Chrome/chromote are unavailable)
  covering computed colours, animated keyframes, DOM text, Escape handling, cover
  width, computed font sizes, queue/replace counts, spinner pseudo-elements and
  the Alertify accent. They encode the audit's reproducers plus variants.
* `tests/testthat/helper-browser.R` — page builder/Chrome helpers and payload
  capture.

Updated: `test-batch1.R` and `test-batch2.R` expectations now assert the
normalised colours and the new viz-dot custom properties (the old tests encoded
the defects); snapshots for `loaders`, `spinkit` and `vizload` were reviewed and
updated (`sby-loader` class, planespinner id only where scoped, normalised
colours).

Regression value was checked by copying the two new test files into a clean
`origin/release/v0.2.1` archive and running them there:

* `test-audit-fixes.R`: **21 of 21 test blocks fail** on 0.2.1.
* `test-browser-regressions.R`: **15 of 15 tests fail** on 0.2.1.
* Both files pass on the fixed tree.

## Reproducer outputs after the fix

From `.fx1-tmp/final-probe.log` (Chrome 0.5.1/chromote, real DOM):

```
H01: recalculating -> output "hidden", loader "visible"; value -> text "Expected text",
     output "visible", loader "hidden" (literal id "a.b")
H02: dots animation at 0/500/1000 ms -> rgb(255,0,0) / rgb(115,0,0) / rgb(255,0,0)
H03: chase widget 1 before -> rgb(255,0,0); widget 2 before -> rgb(0,0,255)
H04: carousel box-shadow -> "rgb(255, 0, 0) 9984px 0px 0px -1px, ..."
H05: type 8 green: border-left-color #00FF00, shades rgba(0,255,0,0.2);
     type 1 gray50: background #7F7F7F (col2rgb: 127 127 127)
H06: rebeccapurple / hsl(-120,100%,50%) / hsl(120deg,100%,50%) /
     rgb(255 0 0 / 50%) -> OK
H07: rgba(255,0,0,0) -> all borders rgba(255,0,0,0);
     #ff000080 -> shades rgba(255,0,0,0.1004)
H08: rgb(30%,0%,0%) -> 77 0 0; hsl(0,0%,30%) -> 77 77 77; 70% -> 179
H09: notify() -> title "Hey", text FALSE (no "null" in DOM)
H10: tags -> "<strong>Bold</strong>"/"<span>Text</span>", trusted TRUE/TRUE
H11: delay "infinity" and Inf -> hide FALSE; notice still present after 1.3 s
H12: translucent computed opacity 0.7
H13: microtip small then NULL -> attribute removed
H14: bootbox Escape with close_on_escape = FALSE -> 1 / 1 dialogs;
     with TRUE -> 0
H15: default and documented image_width -> cover width 50px
H16: computed title line-height 28px, message font-size 24px,
     message line-height 48px
H17: mode 1 after replacement -> 1 toast, background rgb(0,0,255);
     mode 0 keeps the first toast until it is closed, then shows the second
H18: previewSpinners("vizload") -> lv-bars TRUE, 8 bar divs
H19: spinner ::before display block / overflow visible with both stylesheets;
     loaders.css has no bare ".loader {" base block
M04: alertify dialog class TRUE, border rgb(217,83,79)
```

## Checks

Commands (PowerShell/Rscript; all scratch under `.fx1-tmp/`):

```text
devtools::document()
devtools::test()                       # 1059 passing, 0 failed, 0 skipped locally
git archive --format=tar --output=.fx1-tmp/standby-src.tar HEAD
R CMD build standby                    # from .fx1-tmp/build/standby
R CMD check --as-cran --no-manual standby_0.2.2.tar.gz
urlchecker::url_check(".")
pkgdown::build_site(preview = FALSE, install = TRUE, new_process = FALSE)
```

Final check: **0 errors, 0 warnings, 1 NOTE** —
`CRAN incoming feasibility ... NOTE`, the expected new-maintainer note caused by
the required email change (old `hebbali.aravind@gmail.com`, new
`aravindhebbali@rsquaredacademy.com`). Test results in the check:
`FAIL 0 | WARN 0 | SKIP 56 | PASS 960` (skips are the 41 snapshot expectations
that are CRAN-disabled plus the 15 browser tests). `--no-manual` was used because
no LaTeX installation is available; the vignette is built by `R CMD build`.

`urlchecker::url_check()`: “All URLs are correct!” (26 URLs).

## Commits

```
fix: colour handling and per-widget loader styles (H02-H08, H19)
fix: notifications, tooltips, modals and alert types (H01, H09-H14, M04)
fix: toast image width, sizes and display modes (H15-H17)
docs: previews, return values, colour contract and release metadata (H18, L01-L03, M01-M03)
test: regression tests for the pre-CRAN audit findings
docs: NEWS for 0.2.2 and refreshed CRAN comments
fix: keep transparent colours transparent when normalising names
docs: regenerate pkgdown site for 0.2.2
docs: fx1 audit-fix report
refactor: remove redundant branch in colour number parsing
```

## Follow-ups (not done in this task, by design)

1. **Reverse dependencies:** re-run `revdepcheck::revdep_check()` for `xplorerr`
   (the only known reverse dependency) on the final 0.2.2 tarball. I did not run
   it here because it needs an external package installation; `cran-comments.md`
   states this explicitly instead of repeating the older 0.2.1 claim.
2. **External checks:** run win-builder (devel and release) and/or R-hub on the
   final tarball; only local Windows R 4.6.1 was checked. Record the results in
   `cran-comments.md` before submission.
3. **CI coverage for browser tests:** the chromote tests currently skip unless a
   local Chrome is present. Add `R_CHROMOTE_CHROME`/Chrome setup (or run
   `NOT_CRAN=true` with Chrome available) to the GitHub Actions workflow so the
   H01–H19 browser regressions also run in CI.
4. **iziToast upgrade:** the H15/H16 fixes patch the bundled
   `inst/toast/js/iziToast.min.js`. Keep the patch (or re-apply it) when the
   bundled library is updated.
5. **Translucent styling scope:** `translucent` is applied as whole-notice
   opacity; if a future design wants the text fully opaque with only the
   background transparent, extend `sbyNotify.css` to override the theme
   background variable instead.
6. **HTML dependencies in `notify()` tags:** tags are rendered to HTML string but
   their `htmlDependency` objects are not installed (now documented on the
   parameters). Supporting dependency injection would need a different transport
   and was outside this audit.
