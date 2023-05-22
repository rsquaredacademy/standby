test_that("glanceSpinkit() generates the correct HTML", {
  expect_snapshot(glanceSpinkit(color = 'red', width = '25px', height = '25px'))
})

test_that("spinkit_plane() generates the correct HTML", {
  expect_snapshot(spinkit_plane(color = "#333", size = "40px"))
})

test_that("spinkit_chase() generates the correct HTML", {
  expect_snapshot(spinkit_chase(size = "40px"))
})

test_that("spinkit_bounce() generates the correct HTML", {
  expect_snapshot(spinkit_bounce(color = "#333", size = "40px"))
})

test_that("spinkit_wave() generates the correct HTML", {
  expect_snapshot(spinkit_wave(color = "#333", size = "40px"))
})

test_that("spinkit_pulse() generates the correct HTML", {
  expect_snapshot(spinkit_pulse(color = "#333", size = "40px"))
})

test_that("spinkit_flow() generates the correct HTML", {
  expect_snapshot(spinkit_flow(color = "#333", size = "40px"))
})

test_that("spinkit_swing() generates the correct HTML", {
  expect_snapshot(spinkit_swing(color = "#333", size = "40px"))
})

test_that("spinkit_circle() generates the correct HTML", {
  expect_snapshot(spinkit_circle(size = "40px"))
})

test_that("spinkit_circle_fade() generates the correct HTML", {
  expect_snapshot(spinkit_circle_fade(size = "40px"))
})

test_that("spinkit_grid() generates the correct HTML", {
  expect_snapshot(spinkit_grid(color = "#333", size = "40px"))
})

test_that("spinkit_wander() generates the correct HTML", {
  expect_snapshot(spinkit_wander(color = "#333", size = "40px"))
})

test_that("spinkit_fold() generates the correct HTML", {
  expect_snapshot(spinkit_fold(size = "40px"))
})
