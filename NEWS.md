# standby (development version)

## Bug Fixes

* Validate `color` in `threeDots()`, `spinkit()`, `spinners()`, and `vizLoad()` to prevent HTML/CSS injection.
* Accept valid `rgb()`/`rgba()`/`hsl()`/`hsla()` colours with a leading-dot alpha value (for example `rgba(0,0,0,.5)`).
* Validate `type` in `vizLoad()` against documented supported types.
* Scope generated CSS to individual widget instances in `spinners()` and `vizLoad()` to prevent color bleeding across loaders of the same type.
* Correct documentation for `alertify_alert()` defaults (`auto_reset`, `maximizable`, `modal`, `movable`, `move_bounded`, and `overflow`) to match function behavior.
* Fix broken alerts and notifications example in `README`.
* Remove stray `console.log()` statement in MicroTip JavaScript handler.

# standby 0.2.0

This is a minor release to fix CRAN note.

# standby 0.1.0

* Added a `NEWS.md` file to track changes to the package.
