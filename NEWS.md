# standby 0.2.2

## Bug Fixes

* Loaders now handle valid HTML output ids such as `a.b`, `a:b` and `1plot`.
  The Shiny handlers use the event target instead of building a CSS selector
  from the id, and MicroTip uses `document.getElementById()` (H01).
* `vizLoad(type = "dots")` now honours `color`: the pulsating keyframes read
  per-widget custom properties instead of hard-coded colours (H02).
* `spinkit()` colours no longer bleed between widgets of the same type. The
  pseudo-element rules are scoped to the widget id (H03).
* `threeDots()` now sets `--primary-color` on each widget, so animations drawn
  with `box-shadow` use the requested colour (H04).
* Colour names are normalised to their R colour values before being emitted
  (`"green"` is `#00FF00`, `"gray50"` is `#7F7F7F`), so the main colour and the
  derived shades share one hue and R-only names are no longer silently
  ignored by the browser (H05).
* The `color` validator accepts the documented CSS colour grammar again:
  CSS-only keywords (`rebeccapurple`), signed/negative hues, hue units and
  modern space/slash `rgb()`/`hsl()` syntax are accepted, while stylesheet and
  HTML delimiters are still rejected (H06).
* Spinner shades preserve the requested alpha, so a fully transparent colour
  stays transparent and `rgba(..., 0.5)` produces shades at half strength
  (H07).
* Spinner shade channels are rounded half-up like CSS, so `rgb(30%,0%,0%)`
  derives shades from `77` rather than `76` (H08).
* `notify()` no longer renders the literal text `null` for its documented
  default `text = NULL`, or for `title = NULL` (H09).
* `notify()` renders Shiny tags supplied as `title`/`text` to HTML and marks
  only those as trusted, instead of displaying `[object Object]` (H10).
* `notify(delay = "infinity")` (and `delay = Inf`) keeps the notice open until
  it is closed manually, as documented (H11).
* `notify(translucent = TRUE)` now has a defined see-through appearance (H12).
* `microTip()` removes `data-microtip-size` when `size` is `NULL`/`"fit"`, so
  updating a tooltip back to the default size no longer keeps the old size
  (H13).
* `bootBox(close_on_escape = FALSE)` keeps the dialog open when Escape is
  pressed. The bridge uses `bootbox.dialog()` with an explicit OK button
  instead of `bootbox.alert()`, which overwrote the Escape policy (H14).
* `toast()` cover images are visible by default: `image_width` defaults to the
  documented `"50px"` and numeric or unit-bearing widths are handled
  consistently (H15).
* Toast title/message font sizes and line heights honour their own values,
  including unit-bearing input and an unset `title_size` (H16).
* `toast(display_mode = ...)` implements the documented behaviour: `0` waits
  for the current toast to close, `1` replaces the displayed toast(s), and the
  library's replace-an-identical-toast mode is now documented as `2` (H17).
* `previewSpinners("vizload")` renders the documented vizload preview instead
  of an empty container; both preview helpers validate their argument (H18).
* Loading the CSS Loaders dependency no longer hides Single Element CSS
  Spinners: CSS Loaders' base `.loader` rules are scoped to its own widget
  (H19).
* `alertify_alert(type = ...)` now has a defined effect: the dialog gets a
  type class and a type-specific accent border and header colour (M04).

## Documentation

* Colour arguments document that names follow R's `colors()`, and that CSS
  colour names are also accepted.
* `use*()` helpers and loader constructors document their return values
  instead of `None` (L03).
* Preview messages and the vignette refer to standby rather than buzz (L02).
* Removed the unavailable tinyverse status badge from the README (L01).

## Internal

* Maintainer email updated to `aravindhebbali@rsquaredacademy.com` (M01).
* `testthat` minimum raised to 3.1.5, matching the expectations used by the
  tests (M03).
* `cran-comments.md` describes this release and its check results (M02).

# standby 0.2.1

## Bug Fixes

* Validate `color` in `threeDots()`, `spinkit()`, `spinners()`, and `vizLoad()` to prevent HTML/CSS injection.
* Validate `type` in `spinners()` against supported types `1` to `8`, giving a clear error naming the allowed values.
* Accept `rgb()`/`rgba()`/`hsl()`/`hsla()` colours for `spinners()` types `5` and `8`, including when generating shade colours.
* Accept valid `rgb()`/`rgba()`/`hsl()`/`hsla()` colours with a leading-dot alpha value (for example `rgba(0,0,0,.5)`).
* Validate `type` in `vizLoad()` against documented supported types.
* Scope generated CSS to individual widget instances in `spinners()` and `vizLoad()` to prevent color bleeding across loaders of the same type.
* Correct documentation for `alertify_alert()` defaults (`auto_reset`, `maximizable`, `modal`, `movable`, `move_bounded`, and `overflow`) to match function behavior.
* Fix broken alerts and notifications example in `README`.
* Remove stray `console.log()` statement in MicroTip JavaScript handler.
* Generate unique IDs per call in `threeDots()` and `loaders()`, and scope `threeDots()` CSS to its own ID to avoid collisions across multiple instances and within Shiny modules.
* Validate animation `type` in `threeDots()` and `loaders()` using `match.arg()`.
* Validate `size` per type in `vizLoad()` against supported combinations and document supported sizes.
* Replace the `lvl-5` offset class with `lv-mid` centering for `small` and `tiny` sizes in `vizLoad()`.
* Apply `color` to `vizLoad(type = "dots")` loaders.
* Fix AlertifyJS JavaScript bridge property names for `maximizable` and `resizable`, and wire the `label` setting.
* Include `type` in the custom message payload sent by `toast()`.
* Avoid adding animation classes in `bootBox()` when `class = NULL`.
* Correct documented defaults for `toast()` `position` and `notify()` `title` and `text` to match function arguments.

# standby 0.2.0

This is a minor release to fix CRAN note.

# standby 0.1.0

* Added a `NEWS.md` file to track changes to the package.
