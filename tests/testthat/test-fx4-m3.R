test_that("fx4 M3: SpinKit requires positive CSS lengths for every type", {
  types <- c("plane", "chase", "bounce", "wave", "pulse", "flow", "swing",
             "circle", "circle-fade", "grid", "fold", "wander")
  for (type in types) {
    for (size in list(-5, 0, "-5", "0", "-5px", "0px", "-2.5em", "0%",
                     "-0rem", "0e4px", "-1e-2vw", NULL)) {
      expect_error(spinkit(shiny::div(), type = type, size = size),
                   "Invalid `size`: expected a positive CSS length", fixed = TRUE)
    }
    for (size in list(.01, "0.01px", ".5em", "2rem", "50%", "1e-2vw", "+5px")) {
      expect_no_error(spinkit(shiny::div(), type = type, size = size))
    }
  }
})
