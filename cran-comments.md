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

* local: Windows 11 x64, R 4.6.1 (ucrt)
* Linux (Ubuntu): R 4.6.2 and R-devel (4.7.0)
* win-builder: R-devel and R-release
* GitHub Actions: ubuntu-latest (devel, release, oldrel-1), windows-latest
  (release), macos-latest (release)

## R CMD check results

0 errors | 0 warnings | 1 note

* checking CRAN incoming feasibility ... NOTE: the maintainer e-mail address
  changes from hebbali.aravind@gmail.com to aravindhebbali@rsquaredacademy.com.
  This is the same maintainer, Aravind Hebbali; the change will be confirmed
  from the old address.

The check was run on a tarball built from a clean `git archive` copy of the
release commit.

## Reverse dependencies

We checked 1 reverse dependency (xplorerr): 0 new problems.

Browser-level regression tests use chromote with a local Chrome installation.
The full local suite passed (161 test blocks), with 0 failures, 0 errors and
0 skips; all 27 browser test blocks ran with Chrome available.
They are skipped on CRAN (`skip_on_cran()`), and also skipped when chromote or
Chrome is unavailable, so they do not affect the CRAN check.
