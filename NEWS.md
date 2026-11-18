# standby 0.2.2

Version 0.2.1 was not released; its changes are included in 0.2.2.
Finding ids prefixed with `fx1` refer to the first audit; `aud2` refers to the
fresh audit of that fix round.

## Colours and loaders

* SpinKit normalizes numeric and unitless sizes to pixels for every type, including wander travel, and rejects invalid lengths (rx2 N01).
* CSS length normalization rejects trailing decimal dots such as `"12."` instead of emitting invalid CSS (rx2 N02 / rx2h L01).
* All four colour-taking constructors validate complete CSS colour expressions
  in R. Malformed separators, mixed legacy RGB units and trailing decimal
  points now give a clear error; named colours, hex 3/4/6/8, RGB/RGBA and
  HSL/HSLA, including modern syntax, remain supported (aud2 M02; fx1 H06, H20).
* Colour names follow R's `colors()` values, with CSS-only names also accepted.
  Main colours and shades agree; shade alpha is multiplied by the input alpha,
  and channels round half-up like CSS (fx1 H05, H07, H08).
* `threeDots(type = "flashing")` uses an instance-specific faded colour in both
  keyframe definitions, preserving hue and alpha throughout the animation,
  including fully transparent inputs (aud2 H01). Its other shadow animations
  also use the requested colour (fx1 H04).
* `vizLoad(type = "dots")` animates in the requested colour (fx1 H02). Its dark
  phase now clamps valid out-of-range CSS channels before darkening them and
  preserves alpha (aud2 M03).
* `spinkit(type = "wander")` scales cube travel with the widget size, including
  relative CSS units (aud2 M04). Unsupported, missing and factor types now give
  a clear error instead of silently selecting or omitting an animation (aud2 M05).
  Pseudo-element colours remain scoped per widget (fx1 H03).
* `spinners()` and `vizLoad()` validate supported types and scope generated CSS
  per instance. `vizLoad()` validates supported type/size combinations and
  centres small and tiny sizes using `lv-mid`.
* `threeDots()` and `loaders()` validate animation types and generate unique
  widget ids. Output handlers work with literal ids such as `a.b`, `a:b` and
  `1plot` (fx1 H01). CSS Loaders' base rules no longer hide Single Element CSS
  Spinners (fx1 H19).
* `previewSpinners("vizload")` displays eight bars; preview helpers validate
  choices and refer to standby rather than buzz (fx1 H18, L02).

## Alerts, modals and tooltips

* Documented that `alertify_alert()`, `alertify_notify()`, `bootBox()`, `tingle()`, `toast()` and `notice()` render HTML; escape untrusted input with `htmltools::htmlEscape()`.

* Reused `alertify_alert()` dialogs replace previous semantic type classes, so
  error followed by success or warning has the correct accent (aud2 M01;
  fx1 M04). The bridge forwards maximizable, resizable and label settings;
  documented defaults match the arguments.
* `bootBox(close_on_escape = FALSE)` keeps the dialog open on Escape (fx1 H14).
  Extra-large dialogs have a responsive Bootstrap 3 fallback up to 1140 pixels,
  so the default Shiny framework no longer makes them smaller than large
  dialogs (aud2 L01). NULL animation classes are omitted.
* `tingle()` destroys each closed modal and removes its document/window
  listeners, including footer-button dialogs (aud2 M10).
* `microTip()` handles literal ids, ignores missing elements and removes the
  size attribute on reset to NULL or fit (fx1 H01, H13). A stray console log
  was removed.
* `notice()` defines distinct foreground/background colours for notice,
  success, warning and error across every effect/layout (aud2 M11).

## PNotify notifications

* `notify(non_blocking = TRUE)` now passes pointer events through its body and
  fades while the pointer is over it, with close/sticker controls still usable
  according to their arguments (aud2 M09).
* `notify()` handles NULL title/text without displaying null and renders Shiny
  tags as trusted HTML while escaping ordinary strings (fx1 H09, H10).
  HTML dependencies attached to those tags are not installed.
* Infinite delays keep notices open, and translucent notices have a defined
  opacity of 0.7 (fx1 H11, H12). Documented title/text defaults match arguments.

## Toasts

* Relative image widths reserve the actual used cover width plus 10 pixels in
  either direction and update when the viewport or cover size changes
  (aud2 M06). Default, numeric and pixel widths remain supported (fx1 H15).
* Repeated closing, stale Escape listeners and mixed display modes cannot
  decrement active state twice or display queued toasts early. The bridge
  tracks live element identities; closing removes listeners/observers
  (aud2 M07).
* Numeric CSS sizes always use a dot decimal separator regardless of R's
  `OutDec` option, including fractional image widths (aud2 M08). Title/message
  font sizes and line heights honour their own values (fx1 H16).
* Display mode strings must be exact 0, 1 or 2; fractional strings are rejected
  before coercion (aud2 L02). Mode 0 queues, mode 1 replaces displayed toasts,
  and mode 2 replaces an identical toast (fx1 H17). The type is forwarded and
  the documented position default matches the argument.

## Documentation and release preparation

* All shared help topics distinguish dependency/tag-list returns from message
  sender side effects; `loaders()` correctly documents its tag return
  (aud2 L03; completes fx1 L03).
* README alert examples are corrected and the broken tinyverse badge removed
  (fx1 L01). Colour-name semantics are documented.
* The maintainer email is `aravindhebbali@rsquaredacademy.com`, testthat requires
  at least 3.1.5, and jsonlite/chromote are suggested for browser regressions
  (fx1 M01, M03). CRAN comments describe the 0.2.2 release and local checks
  (fx1 M02).

# standby 0.2.0

This is a minor release to fix CRAN note.

# standby 0.1.0

* Added a `NEWS.md` file to track changes to the package.
