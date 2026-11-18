test_that("fx4 H1: toast string fields never serialize NULL as JSON null", {
  cases <- list(list(), list(title = "Hey"), list(title = NULL),
                list(message = NULL), list(title = NULL, message = "body"),
                list(title = NULL, message = NULL))
  for (args in cases) {
    session <- shiny::MockShinySession$new()
    payload <- NULL
    session$sendCustomMessage <- function(type, message) payload <<- message
    do.call(toast, c(args, list(session = session)))
    json <- shiny:::toJSON(payload)
    decoded <- jsonlite::fromJSON(json)
    expect_type(decoded$title, "character")
    expect_type(decoded$message, "character")
    expect_false(grepl('"(title|message)":null', json))
    session$close()
  }
})

test_that("fx4 H1: default and NULL-title toasts appear in Chrome", {
  fxb_available()
  cases <- list(list(), list(title = "Hey"),
                list(title = NULL, message = "body"),
                list(title = NULL, message = NULL))
  for (args in cases) {
    s <- fxb_toast_page()
    tryCatch({
      payload <- do.call(fxb_payload, c(list(fun = toast), args,
                                       list(duration = FALSE)))
      fxb_eval(s, paste0("Shiny.handlers['toast.send'](", payload, ");"))
      appeared <- fxb_eval(s, "new Promise(resolve => {
        const deadline = performance.now() + 5000;
        function poll() {
          const el = document.querySelector('.iziToast');
          if (el && el.getBoundingClientRect().height > 0) return resolve(true);
          if (performance.now() > deadline) return resolve(false);
          requestAnimationFrame(poll);
        }
        poll();
      })", await = TRUE)
      expect_true(appeared)
    }, finally = s$close())
  }
})
