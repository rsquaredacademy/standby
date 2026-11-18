test_that("fx5 R3: restored toast options render bundled classes and animations", {
  fxb_available()
  s <- fxb_toast_page()
  on.exit(s$close())
  for (transition in c("revealIn", "slideIn")) {
    payload <- fxb_payload(toast, title = transition, theme = "mytheme", layout = 3,
                           transition_in = transition, duration = Inf, display_mode = 2)
    fxb_eval(s, paste0("Shiny.handlers['toast.send'](", payload, ");"))
    result <- fxb_eval(s, paste0("(function(){var el=document.querySelector('.iziToast.",
      transition, "'); return {theme:el.classList.contains('iziToast-theme-mytheme'),",
      "layout:el.classList.contains('iziToast-layout3'),radius:getComputedStyle(el).borderRadius,",
      "animation:getComputedStyle(el).animationName};})()"))
    expect_true(result$theme)
    expect_true(result$layout)
    expect_identical(result$radius, "2px")
    expect_identical(result$animation, paste0("iziT-", transition))
  }
})

test_that("fx5 R1 and R2: never-close payloads do not arm library close timers", {
  fxb_available()
  s <- fxb_toast_page()
  on.exit(s$close())
  payload <- fxb_payload(toast, duration = Inf)
  fxb_eval(s, paste0("Shiny.handlers['toast.send'](", payload, ");"))
  expect_true(fxb_eval(s, paste0(
    "new Promise(function(resolve,reject){var deadline=Date.now()+10000;",
    "function check(){var el=document.querySelector('.iziToast');",
    "if(el && el.classList.contains('iziToast-opened')){",
    "var ref=el.getAttribute('data-iziToast-ref');",
    "resolve(iziToast.getSetting(ref,'timeout') === false && !iziToast.getSetting(ref,'time').TIMER);}",
    "else if(Date.now()>deadline){reject(new Error('toast did not open'));}",
    "else{requestAnimationFrame(check);}}check();})"), await = TRUE))

  a <- fxb_open(fxb_page(
    js = c(fxb_file("alertify/js/alertify.min.js"), fxb_file("alertify/js/sbyAlertify.js")),
    css = fxb_file("alertify/css/alertify.min.css")))
  on.exit(a$close(), add = TRUE)
  fxb_eval(a, "window.lastNotice=null; var success=alertify.success; alertify.success=function(){lastNotice=success.apply(alertify,arguments);return lastNotice;};")
  for (delay in list(Inf, NULL)) {
    payload <- fxb_payload(alertify_notify, delay = delay)
    fxb_eval(a, paste0("Shiny.handlers['alertify.notify'](", payload, ");"))
    expect_true(fxb_eval(a, "lastNotice.__internal.delay === 0 && !lastNotice.__internal.timer"))
    expect_true(fxb_eval(a, "!!document.querySelector('.ajs-message.ajs-success')"))
  }
})
