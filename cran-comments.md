## Patch release

This is a patch release that fixes bugs in the loaders, alerts and
notifications: colours are validated and scoped to each loader, loaders get
unique IDs so several can be used on one page or inside Shiny modules, invalid
`type` and `size` values give clear errors, and the documented defaults now
match the functions.

## Test environments

* local Windows 11, R 4.6.1
* TODO: win-builder (devel, release)
* TODO: R-hub

## R CMD check results

0 errors | 0 warnings | 0 notes

## Reverse dependencies

TODO: revdepcheck
