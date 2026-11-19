## Patch release

This is the 0.2.2 patch release after CRAN 0.2.0; 0.2.1 was never released.
See NEWS.md for the complete changes to loading screens, alerts and notifications.

The final rendering fix round corrects all 20 Three Dots animations, the music
loader, supported loader style/text combinations, and SpinKit child counts.
VizLoad size errors now name the argument and valid choices. It also corrects
preview styles, generated spinner CSS, help/error wording and bundled asset
revision metadata.

## Test environment

* Local: Windows 11 x64, R 4.6.1 (ucrt)
* Real browser: headless Google Chrome 157.0.8103.79, chromote 0.5.1

These are the environments exercised in this fix round. Earlier remote platform
results have not been rerun as part of this local change.

## R CMD check results

0 errors | 0 warnings | 0 notes

Run with devtools::check(document = FALSE, args = "--as-cran"). Devtools adds
--no-manual and disables remote incoming checks for this local run. Both
vignettes rebuilt successfully. Installed-package tests passed 5,852 assertions
with 0 failures, 0 warnings and 0 skips; the source-only README.Rmd assertion
does not apply to the built package.

The maintainer e-mail changes from hebbali.aravind@gmail.com to
aravindhebbali@rsquaredacademy.com. This is the same maintainer, Aravind Hebbali;
any confirmation requested by CRAN will be made from the old address.

## Tests and browser gate

The full local suite passed: 5,853 assertions across 172 test blocks, with
0 failures, 0 errors, 0 warnings and 0 skips. All 42 browser test blocks and
41 snapshot blocks executed. The new rendering grid covers 131 cases across
all 60 documented types, supported loader style/text combinations, SpinKit
sizes 24/40/64px, every VizLoad size and translucent swing/wander colours.

Browser tests use skip_on_cran() and also skip if chromote or Chrome is absent.
The full type and option contact sheets and the per-finding report are kept
under build-ignored docs-dev. Independent cross-family re-gate and contact-sheet
review remain required before submission; this local check is not that sign-off.

## Reverse dependencies

The earlier release work checked xplorerr with 0 new problems. Reverse
dependencies were not rerun in this rendering fix round.
