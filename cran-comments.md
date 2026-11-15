## Patch release

This is a patch release that fixes the findings of a pre-submission audit of
0.2.1. It corrects browser-visible behaviour in the loading screens, alerts and
notifications: loader handlers now work with literal HTML ids such as `a.b`,
colours are validated and scoped per widget, spinner shade alpha and channel
rounding follow CSS, `notify()` handles its documented `NULL` defaults and tag
inputs, BootBox honours `close_on_escape`, toast image widths and font sizes are
applied, and the documented `toast()` display modes are implemented. It also
documents the colour-name contract, the return values of the UI helpers, and
updates the maintainer address.

See `NEWS.md` for the complete list.

## Test environments

* local Windows 11 x64, R 4.6.1 (2026-06-24 ucrt), Shiny 1.14.0,
  htmltools 0.5.9, testthat 3.3.2
* `R CMD check --as-cran --no-manual` on the tarball built from a clean
  `git archive` of the release commit
* no win-builder, R-hub or GitHub Actions run was performed for this source

Browser-level regression tests use chromote with a local Chrome installation.
They are skipped on CRAN (`skip_on_cran()`), and also skipped when chromote or
Chrome is unavailable, so they do not affect the CRAN check.

## R CMD check results

0 errors | 0 warnings | 0 notes

The only incoming-feasibility NOTE is the expected maintainer change (the
maintainer address was updated from `hebbali.aravind@gmail.com` to
`aravindhebbali@rsquaredacademy.com`).

## Reverse dependencies

No reverse dependency was re-checked for this source snapshot. The changed code
is limited to the package's own CSS/JavaScript and to colour/length handling in
the exported UI helpers; the one known reverse dependency (`xplorerr`) does not
use those helpers directly.
