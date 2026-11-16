# Browser-level regression tests for the pre-CRAN audit findings.
# Skipped on CRAN and whenever Chrome/chromote are unavailable.

test_that("H01: loaders and tooltips work with literal but non-selector ids", {
  fxb_available()
  body <- paste0(
    "<div class='standby'>",
    "<div class='standby-wait' id='loader-a' style='visibility:hidden'>L</div>",
    "<div id='a.b'>old</div>",
    "</div>",
    "<div id='a:b'>tip</div>"
  )
  session <- fxb_open(fxb_page(
    body = body,
    js = c(fxb_file("standby/js/standby.js"),
           fxb_file("microtip/js/microtip.js")),
    jquery = TRUE
  ))
  on.exit(session$close(), add = TRUE)

  state <- fxb_eval(session, "
    document.getElementById('a.b').dispatchEvent(
      new CustomEvent('shiny:recalculating', {bubbles: true}));
    var parent = document.getElementById('a.b').parentElement;
    ({
      output: document.getElementById('a.b').style.visibility,
      loader: document.getElementById('loader-a').style.visibility,
      full: parent.classList.contains('full-screen')
    });
  ")
  expect_identical(state$output, "hidden")
  expect_identical(state$loader, "visible")
  expect_true(state$full)

  state <- fxb_eval(session, "
    document.getElementById('a.b').textContent = 'Expected text';
    document.getElementById('a.b').dispatchEvent(
      new CustomEvent('shiny:value', {bubbles: true}));
    ({
      text: document.getElementById('a.b').textContent,
      output: document.getElementById('a.b').style.visibility,
      loader: document.getElementById('loader-a').style.visibility
    });
  ")
  expect_identical(state$text, "Expected text")
  expect_identical(state$output, "visible")
  expect_identical(state$loader, "hidden")

  # Invalid-selector ids must not throw and must be updated.
  tip <- fxb_eval(session, "
    Shiny.handlers['tip.send']({id: 'a:b', tip: 'new', position: 'top', size: 'small'});
    var el = document.getElementById('a:b');
    ({label: el.getAttribute('aria-label'), size: el.getAttribute('data-microtip-size')});
  ")
  expect_identical(tip$label, "new")
  expect_identical(tip$size, "small")

  tip <- fxb_eval(session, "
    Shiny.handlers['tip.send']({id: 'a:b', tip: 'newer', position: 'top', size: null});
    document.getElementById('a:b').hasAttribute('data-microtip-size');
  ")
  expect_false(tip)

  # A missing element must be ignored rather than throwing.
  expect_silent(fxb_eval(session,
    "Shiny.handlers['tip.send']({id: 'does-not-exist', tip: 'x', position: 'top', size: null}); true;"))
})

test_that("H02: vizLoad dots animate in the requested colour", {
  fxb_available()
  widget <- fxb_render(vizLoad(shiny::div(), type = "dots", color = "red"))
  session <- fxb_open(fxb_page(
    body = widget$html,
    head = widget$head,
    css = fxb_file("vizload/css/ridics.css")
  ))
  on.exit(session$close(), add = TRUE)

  colours <- fxb_eval(session, "
    var el = document.querySelector('.lv-dots div');
    var anim = el.getAnimations()[0];
    anim.pause();
    anim.currentTime = 0;
    var at0 = getComputedStyle(el).backgroundColor;
    anim.currentTime = 500;
    var at500 = getComputedStyle(el).backgroundColor;
    anim.currentTime = 1000;
    var at1000 = getComputedStyle(el).backgroundColor;
    [at0, at500, at1000];
  ")
  channels <- lapply(colours, function(x) {
    as.integer(regmatches(x, gregexpr("[0-9]+", x))[[1]][1:3])
  })
  for (rgb in channels) {
    expect_gt(rgb[1], 0)
    expect_equal(rgb[2], 0L)
    expect_equal(rgb[3], 0L)
  }
})

test_that("H03: SpinKit colours do not bleed between widgets", {
  fxb_available()
  a <- fxb_render(spinkit(shiny::div(), type = "chase", color = "red"))
  b <- fxb_render(spinkit(shiny::div(), type = "chase", color = "blue"))
  session <- fxb_open(fxb_page(
    body = paste0(a$html, b$html),
    head = paste0(a$head, b$head),
    css = fxb_file("spinkit/css/spinkit.min.css")
  ))
  on.exit(session$close(), add = TRUE)

  colours <- fxb_eval(session, "
    var dots = document.querySelectorAll('.sk-chase-dot');
    [
      getComputedStyle(dots[0], '::before').backgroundColor,
      getComputedStyle(dots[6], '::before').backgroundColor
    ];
  ")
  expect_identical(colours[[1]], "rgb(255, 0, 0)")
  expect_identical(colours[[2]], "rgb(0, 0, 255)")
})

test_that("H04: Three Dots animations use the requested colour", {
  fxb_available()
  widget <- fxb_render(threeDots(shiny::div(), type = "carousel", color = "red"))
  session <- fxb_open(fxb_page(
    body = widget$html,
    head = widget$head,
    css = fxb_file("three-dots/css/three-dots.css")
  ))
  on.exit(session$close(), add = TRUE)

  shadow <- fxb_eval(session, "
    var el = document.querySelector('.dot-carousel');
    var anim = el.getAnimations()[0];
    anim.pause();
    anim.currentTime = 0;
    getComputedStyle(el).boxShadow;
  ")
  expect_match(shadow, "rgb(255, 0, 0)", fixed = TRUE)
  expect_no_match(shadow, "152, 128, 255")
  expect_no_match(shadow, "9880ff")
})

test_that("H09: notify() does not render the literal text null", {
  fxb_available()
  session <- fxb_notify_page()
  on.exit(session$close(), add = TRUE)

  plain <- fxb_payload(notify, hide = FALSE, animation = "none")
  state <- fxb_eval(session, sprintf("
    Shiny.handlers['notify.send'](%s);
    true;
  ", plain))
  fxb_wait(session, 300)
  rendered <- fxb_eval(session, "
    var notice = document.querySelector('.pnotify');
    notice ? notice.textContent : '';
  ")
  expect_identical(state, TRUE)
  expect_false(grepl("null", rendered, fixed = TRUE))
  expect_match(rendered, "Hey", fixed = TRUE)

  # title = NULL is documented as no title and must not print null either.
  session2 <- fxb_notify_page()
  on.exit(session2$close(), add = TRUE)
  bare <- fxb_payload(notify, title = NULL, text = NULL, hide = FALSE,
                      animation = "none")
  fxb_eval(session2, sprintf("Shiny.handlers['notify.send'](%s); true;", bare))
  fxb_wait(session2, 300)
  rendered <- fxb_eval(session2,
    "document.querySelector('.pnotify').textContent")
  expect_false(grepl("null", rendered, fixed = TRUE))
})

test_that("H10: notify() renders element inputs as elements", {
  fxb_available()
  session <- fxb_notify_page()
  on.exit(session$close(), add = TRUE)

  elements <- fxb_payload(notify, title = shiny::strong("Bold"),
                          text = shiny::span("Text"), hide = FALSE,
                          animation = "none")
  fxb_eval(session, sprintf("Shiny.handlers['notify.send'](%s); true;", elements))
  fxb_wait(session, 300)
  rendered <- fxb_eval(session, "
    var notice = document.querySelector('.pnotify');
    ({
      strong: notice.querySelectorAll('strong').length,
      span: notice.querySelectorAll('.pnotify-text span, .pnotify-pre-line span').length,
      text: notice.textContent
    });
  ")
  expect_equal(rendered$strong, 1L)
  expect_gte(rendered$span, 1L)
  expect_false(grepl("[object Object]", rendered$text, fixed = TRUE))
  expect_match(rendered$text, "Bold", fixed = TRUE)
  expect_match(rendered$text, "Text", fixed = TRUE)
})

test_that("H11: notify(delay = 'infinity') keeps the notice open", {
  fxb_available()
  session <- fxb_notify_page()
  on.exit(session$close(), add = TRUE)

  infinite <- fxb_payload(notify, delay = "infinity", animation = "none")
  fxb_eval(session, sprintf("Shiny.handlers['notify.send'](%s); true;", infinite))
  fxb_wait(session, 1300)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.pnotify').length"), 1L)
})

test_that("H12: notify(translucent = TRUE) is see-through", {
  fxb_available()
  session <- fxb_notify_page()
  on.exit(session$close(), add = TRUE)

  translucent <- fxb_payload(notify, translucent = TRUE, hide = FALSE,
                             animation = "none")
  fxb_eval(session, sprintf("Shiny.handlers['notify.send'](%s); true;", translucent))
  fxb_wait(session, 600)
  opacity <- fxb_eval(session,
    "parseFloat(getComputedStyle(document.querySelector('.pnotify')).opacity)")
  expect_lt(opacity, 1)
})

test_that("H14: bootBox keeps the dialog open on Escape when requested", {
  fxb_available()
  session <- fxb_open(fxb_page(
    js = c(file.path(system.file("www/shared/bootstrap", package = "shiny"),
                     "js/bootstrap.min.js"),
           fxb_file("bootbox/js/bootbox.all.min.js"),
           fxb_file("bootbox/js/sbyBootbox.js")),
    css = file.path(system.file("www/shared/bootstrap", package = "shiny"),
                    "css/bootstrap.min.css"),
    jquery = TRUE
  ))
  on.exit(session$close(), add = TRUE)

  payload <- fxb_payload(bootBox, message = "Stay open",
                         close_on_escape = FALSE, animate = FALSE)
  fxb_eval(session, sprintf("Shiny.handlers['bootbox.send'](%s); true;", payload))
  fxb_wait(session, 300)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.bootbox').length"), 1L)

  session$Input$dispatchKeyEvent(type = "rawKeyDown", key = "Escape",
                                 code = "Escape", windowsVirtualKeyCode = 27L,
                                 nativeVirtualKeyCode = 27L)
  session$Input$dispatchKeyEvent(type = "keyUp", key = "Escape",
                                 code = "Escape", windowsVirtualKeyCode = 27L,
                                 nativeVirtualKeyCode = 27L)
  fxb_wait(session, 400)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.bootbox').length"), 1L)

  # Control: close_on_escape = TRUE still closes.
  fxb_eval(session, "bootbox.hideAll(); true;")
  fxb_wait(session, 300)
  payload <- fxb_payload(bootBox, message = "Close me",
                         close_on_escape = TRUE, animate = FALSE)
  fxb_eval(session, sprintf("Shiny.handlers['bootbox.send'](%s); true;", payload))
  fxb_wait(session, 300)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.bootbox').length"), 1L)
  session$Input$dispatchKeyEvent(type = "rawKeyDown", key = "Escape",
                                 code = "Escape", windowsVirtualKeyCode = 27L,
                                 nativeVirtualKeyCode = 27L)
  session$Input$dispatchKeyEvent(type = "keyUp", key = "Escape",
                                 code = "Escape", windowsVirtualKeyCode = 27L,
                                 nativeVirtualKeyCode = 27L)
  fxb_wait(session, 500)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.bootbox').length"), 0L)
})

test_that("H15: toast cover images use a usable width", {
  fxb_available()
  pic <- "data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw=="

  session <- fxb_toast_page()
  on.exit(session$close(), add = TRUE)
  default <- fxb_payload(toast, title = "Image", message = "Message",
                         image = pic, duration = FALSE)
  fxb_eval(session, sprintf("Shiny.handlers['toast.send'](%s); true;", default))
  fxb_wait(session, 400)
  expect_identical(fxb_eval(session,
    "getComputedStyle(document.querySelector('.iziToast-cover')).width"), "50px")

  session2 <- fxb_toast_page()
  on.exit(session2$close(), add = TRUE)
  documented <- fxb_payload(toast, title = "Image", message = "Message",
                            image = pic, image_width = "50px", duration = FALSE)
  fxb_eval(session2, sprintf("Shiny.handlers['toast.send'](%s); true;", documented))
  fxb_wait(session2, 400)
  expect_identical(fxb_eval(session2,
    "getComputedStyle(document.querySelector('.iziToast-cover')).width"), "50px")
})

test_that("H16: toast title and message sizes use their own values", {
  fxb_available()
  session <- fxb_toast_page()
  on.exit(session$close(), add = TRUE)

  styles <- fxb_payload(toast, title = "Size", message = "Message",
                        title_line_height = "2em", message_size = "24px",
                        message_line_height = "2em", duration = FALSE,
                        animate_inside = FALSE)
  fxb_eval(session, sprintf("Shiny.handlers['toast.send'](%s); true;", styles))
  fxb_wait(session, 400)
  sizes <- fxb_eval(session, "
    var title = document.querySelector('.iziToast-title');
    var message = document.querySelector('.iziToast-message');
    ({
      titleSize: getComputedStyle(title).fontSize,
      titleLine: getComputedStyle(title).lineHeight,
      messageSize: getComputedStyle(message).fontSize,
      messageLine: getComputedStyle(message).lineHeight
    });
  ")
  expect_identical(sizes$titleSize, "14px")
  expect_identical(sizes$titleLine, "28px")
  expect_identical(sizes$messageSize, "24px")
  expect_identical(sizes$messageLine, "48px")

  # A numeric message_size works when title_size is unset.
  session2 <- fxb_toast_page()
  on.exit(session2$close(), add = TRUE)
  numeric <- fxb_payload(toast, title = "Size", message = "Message",
                         message_size = 24, duration = FALSE,
                         animate_inside = FALSE)
  fxb_eval(session2, sprintf("Shiny.handlers['toast.send'](%s); true;", numeric))
  fxb_wait(session2, 400)
  expect_identical(fxb_eval(session2,
    "getComputedStyle(document.querySelector('.iziToast-message')).fontSize"),
    "24px")
})

test_that("H17: toast display mode 0 queues the next toast", {
  fxb_available()
  session <- fxb_toast_page()
  on.exit(session$close(), add = TRUE)

  first <- fxb_payload(toast, title = "Mode zero", message = "First",
                       display_mode = 0, duration = FALSE)
  second <- fxb_payload(toast, title = "Mode zero", message = "Second",
                        display_mode = 0, duration = FALSE)
  fxb_eval(session, sprintf("
    Shiny.handlers['toast.send'](%s);
    Shiny.handlers['toast.send'](%s);
    true;
  ", first, second))
  fxb_wait(session, 400)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.iziToast').length"), 1L)
  expect_match(fxb_eval(session,
    "document.querySelector('.iziToast-message').textContent"), "First", fixed = TRUE)

  fxb_eval(session, "document.querySelector('.iziToast-close').click(); true;")
  fxb_wait(session, 1900)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.iziToast').length"), 1L)
  expect_match(fxb_eval(session,
    "document.querySelector('.iziToast-message').textContent"), "Second", fixed = TRUE)
})

test_that("H17: toast display mode 1 replaces the displayed toast", {
  fxb_available()
  session <- fxb_toast_page()
  on.exit(session$close(), add = TRUE)

  red <- fxb_payload(toast, title = "Same", message = "Same",
                     background_color = "red", display_mode = 1,
                     duration = FALSE)
  blue <- fxb_payload(toast, title = "Same", message = "Same",
                      background_color = "blue", display_mode = 1,
                      duration = FALSE)
  fxb_eval(session, sprintf("
    Shiny.handlers['toast.send'](%s);
    Shiny.handlers['toast.send'](%s);
    true;
  ", red, blue))
  fxb_wait(session, 1900)
  expect_equal(fxb_eval(session, "document.querySelectorAll('.iziToast').length"), 1L)
  background <- fxb_eval(session,
    "getComputedStyle(document.querySelector('.iziToast')).backgroundColor")
  expect_identical(background, "rgb(0, 0, 255)")
})

test_that("H19: CSS Loaders do not hide spinner bars", {
  fxb_available()
  spinner <- fxb_render(spinners(shiny::div(), type = 1))
  loader <- fxb_render(loaders(shiny::div(), type = "default"))
  session <- fxb_open(fxb_page(
    body = paste0(spinner$html, loader$html),
    head = paste0(spinner$head, loader$head),
    css = c(fxb_file("spinners/css/spinners.css"),
            fxb_file("loaders/css/loaders.css"))
  ))
  on.exit(session$close(), add = TRUE)

  state <- fxb_eval(session, "
    var el = document.querySelector('.load1 .loader');
    ({
      before: getComputedStyle(el, '::before').display,
      after: getComputedStyle(el, '::after').display,
      overflow: getComputedStyle(el).overflow
    });
  ")
  expect_identical(state$before, "block")
  expect_identical(state$after, "block")
  expect_identical(state$overflow, "visible")
})

test_that("M04: alertify alert types have a visible effect", {
  fxb_available()
  session <- fxb_open(fxb_page(
    js = c(fxb_file("alertify/js/alertify.min.js"),
           fxb_file("alertify/js/sbyAlertify.js")),
    css = c(fxb_file("alertify/css/alertify.min.css"),
            fxb_file("alertify/css/sbyAlertify.css"))
  ))
  on.exit(session$close(), add = TRUE)

  payload <- fxb_payload(alertify_alert, title = "Same", message = "Same",
                         type = "error")
  fxb_eval(session, sprintf("Shiny.handlers['alertify.alert'](%s); true;", payload))
  fxb_wait(session, 300)
  state <- fxb_eval(session, "
    var dialog = document.querySelector('.ajs-dialog');
    ({
      error: dialog.classList.contains('sby-alert-error'),
      border: getComputedStyle(dialog).borderTopColor
    });
  ")
  expect_true(state$error)
  expect_identical(state$border, "rgb(217, 83, 79)")
})
