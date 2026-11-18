test_that("fx4 H2: every HTML content parameter documents escaping", {
  fields <- list(alertify = c("title", "message", "btn_label"),
                 bootBox = c("title", "message"),
                 tingle = c("content", "button_label"),
                 toast = c("title", "message"), notice = "message")
  pkg <- find.package("standby")
  db <- if (dir.exists(file.path(pkg, "man"))) {
    tools::Rd_db(dir = pkg)
  } else {
    tools::Rd_db("standby")
  }
  for (topic in names(fields)) {
    rd <- db[[paste0(topic, ".Rd")]]
    args <- Filter(function(x) identical(attr(x, "Rd_tag"), "\\arguments"), rd)[[1]]
    items <- Filter(function(x) identical(attr(x, "Rd_tag"), "\\item"), args)
    for (param in fields[[topic]]) {
      item <- Filter(function(x) identical(paste(unlist(x[[1]]), collapse = ""), param), items)[[1]]
      text <- gsub("[[:space:]]+", " ", paste(unlist(item[[2]]), collapse = ""))
      expect_match(text, "Interpreted as HTML. Escape untrusted input with", fixed = TRUE)
      expect_match(text, "htmltools::htmlEscape()", fixed = TRUE)
    }
  }
})
