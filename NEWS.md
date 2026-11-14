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
