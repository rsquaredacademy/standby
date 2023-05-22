test_that("alertify dependencies work as expected", {
  dep <- useAlertify()
  expect_equal(dep$name, "alertify")
  expect_equal(dep$version, "0.1.0")
  expect_equal(dep$src$file, "alertify")
  expect_equal(dep$stylesheet[[1]][[1]], "css/alertify.min.css")
  expect_equal(dep$script[[1]]$src[[1]][[1]], "js/alertify.min.js")
  expect_equal(dep$script[[2]]$src[[1]][[1]], "js/sbyAlertify.js")
})

test_that("bootbox dependencies work as expected", {
  dep <- useBootBox()
  expect_equal(dep[[1]]$name, "bootbox")
  expect_equal(dep[[1]]$version, "0.1.0")
  expect_equal(dep[[1]]$src$file, "bootbox")
  expect_equal(dep[[1]]$stylesheet, "css/animate.min.css")
  expect_equal(dep[[1]]$script[[1]]$src[[1]][[1]], "js/bootbox.all.min.js")
  expect_equal(dep[[1]]$script[[2]]$src[[1]][[1]], "js/sbyBootbox.js")
})

test_that("loaders dependencies work as expected", {
  dep <- useLoaders()
  expect_equal(dep[[1]]$name, "loaders")
  expect_equal(dep[[1]]$version, "0.1.0")
  expect_equal(dep[[1]]$src$file, "loaders")
  expect_equal(dep[[1]]$stylesheet, "css/loaders.css")
})

test_that("microtip dependencies work as expected", {
  dep <- useMicroTip()
  expect_equal(dep[[1]]$name, "microtip")
  expect_equal(dep[[1]]$version, "0.1.0")
  expect_equal(dep[[1]]$src$file, "microtip")
  expect_equal(dep[[1]]$stylesheet, "css/microtip.min.css")
  expect_equal(dep[[1]]$script[[1]], "js/microtip.js")
})

test_that("ns dependencies work as expected", {
  dep <- useNS()
  expect_equal(dep$name, "ns")
  expect_equal(dep$version, "0.1.0")
  expect_equal(dep$src$file, "ns")
  expect_equal(dep$stylesheet[[1]][[1]], "css/normalize.css")
  expect_equal(dep$script[[1]]$src[[1]][[1]], "js/modernizr.custom.js")
  expect_equal(dep$script[[2]]$src[[1]][[1]], "js/classie.js")
})

test_that("pnotify dependencies work as expected", {
  dep <- useNotify()
  expect_equal(dep$name, "pnotify")
  expect_equal(dep$version, "0.1.0")
  expect_equal(dep$src$file, "pnotify")
  expect_equal(dep$stylesheet[[1]][[1]], "css/PNotify.css")
  expect_equal(dep$stylesheet[[2]][[1]], "css/BrightTheme.css")
  expect_equal(dep$script[[1]]$src[[1]], "js/PNotify.js")
  expect_equal(dep$script[[2]]$src[[1]], "js/notify.js")
})

test_that("spinkit dependencies work as expected", {
  dep <- useSpinkit()
  expect_equal(dep[[1]]$name, "spinkit")
  expect_equal(dep[[1]]$version, "0.1.0")
  expect_equal(dep[[1]]$src$file, "spinkit")
  expect_equal(dep[[1]]$stylesheet, "css/spinkit.min.css")
})

test_that("spinners dependencies work as expected", {
  dep <- useSpinners()
  expect_equal(dep[[1]]$name, "spinners")
  expect_equal(dep[[1]]$version, "0.1.0")
  expect_equal(dep[[1]]$src$file, "spinners")
  expect_equal(dep[[1]]$stylesheet, "css/spinners.css")
})

test_that("threedots dependencies work as expected", {
  dep <- useThreeDots()
  expect_equal(dep[[1]]$name, "three-dots")
  expect_equal(dep[[1]]$version, "0.1.0")
  expect_equal(dep[[1]]$src$file, "three-dots")
  expect_equal(dep[[1]]$stylesheet, "css/three-dots.css")
})

test_that("tingle dependencies work as expected", {
  dep <- useTingle()
  expect_equal(dep$name, "tingle")
  expect_equal(dep$version, "0.1.0")
  expect_equal(dep$src$file, "tingle")
  expect_equal(dep$stylesheet[[1]], "css/tingle.min.css")
  expect_equal(dep$script[[1]]$src[[1]], "js/tingle.min.js")
  expect_equal(dep$script[[2]]$src[[1]], "js/sbyTingle.js")
})

test_that("toast dependencies work as expected", {
  dep <- useToast()
  expect_equal(dep$name, "toast")
  expect_equal(dep$version, "0.1.0")
  expect_equal(dep$src$file, "toast")
  expect_equal(dep$stylesheet[[1]], "css/iziToast.min.css")
  expect_equal(dep$script[[1]]$src[[1]], "js/iziToast.min.js")
  expect_equal(dep$script[[2]]$src[[1]], "js/sbyToast.js")
})

test_that("vizLoad dependencies work as expected", {
  dep <- useVizLoad()
  expect_equal(dep[[1]]$name, "vizload")
  expect_equal(dep[[1]]$version, "0.1.0")
  expect_equal(dep[[1]]$src$file, "vizload")
  expect_equal(dep[[1]]$stylesheet, "css/ridics.css")
  expect_equal(dep[[1]]$script[[1]], "js/ridics.js")
})
