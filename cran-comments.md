## Patch release

This is the 0.2.2 patch release after CRAN 0.2.0; 0.2.1 was never released.
It fixes all findings from both pre-submission audits, including the fresh
audit of the first fix round. It corrects browser-visible behaviour in the loading screens, alerts and
notifications: loader handlers now work with literal HTML ids such as `a.b`,
colours are validated and scoped per widget, spinner shade alpha and channel
rounding follow CSS, `notify()` handles its documented `NULL` defaults and tag
inputs, BootBox honours `close_on_escape`, toast image widths and font sizes are
applied, and the documented `toast()` display modes are implemented. It also
documents the colour-name contract, the return values of the UI helpers, and
updates the maintainer address. The second round fixes flashing hue/alpha,
complete CSS colour validation, clamped darkening, SpinKit types/travel,
reused alert accents, relative toast widths, repeated close/queue accounting,
comma-decimal CSS formatting, nonblocking notices, modal lifecycle cleanup,
notice type styling, Bootstrap 3 extra-large modals and exact display modes.

See `NEWS.md` for the complete list.

## Test environments

* local Windows 11 x64, R 4.6.1 (2026-06-24 ucrt), Shiny 1.14.0,
  htmltools 0.5.9, testthat 3.3.2
* `R CMD check --as-cran` (including the manual) on the tarball built from a clean
  `git archive` of the release commit
* no win-builder, R-hub or GitHub Actions run was performed for this source

Browser-level regression tests use chromote with a local Chrome installation.
The full local suite passed 1511 assertions, with 0 failures, 0 errors and
0 skips; all 27 browser test blocks ran with Chrome available.
They are skipped on CRAN (`skip_on_cran()`), and also skipped when chromote or
Chrome is unavailable, so they do not affect the CRAN check.

## R CMD check results

0 errors | 0 warnings | 0 notes apart from the CRAN incoming-feasibility
maintainer-change NOTE, which is expected because the maintainer address was
updated from `hebbali.aravind@gmail.com` to
`aravindhebbali@rsquaredacademy.com`.

## Reverse dependencies

No reverse dependency was re-checked for this source snapshot. The changed code
is limited to the package's own CSS/JavaScript and to colour/length handling in
the exported UI helpers; the one known reverse dependency (`xplorerr`) does not
use those helpers directly.
