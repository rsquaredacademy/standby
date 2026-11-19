# Rscript docs-dev/pkg-standby-fx6-verify.R [document|fx6|test|check]
Sys.setenv(NOT_CRAN = "true", STANDBY_BROWSER_TESTS = "true",
  LC_ALL = "C", LC_CTYPE = "C")
options(testthat.progress.max_fails = Inf)
mode <- commandArgs(TRUE)[1]
if (is.na(mode)) mode <- "test"
dir.create("docs-dev/fx6-logs", showWarnings = FALSE)
con <- file(file.path("docs-dev/fx6-logs", paste0(mode, ".log")), open = "wt")
sink(con, split = TRUE)
sink(con, type = "message")
if (mode == "document") {
  devtools::document()
} else if (mode %in% c("test", "fx6")) {
  results <- devtools::test(filter = if (mode == "fx6") "fx6" else NULL,
    reporter = "summary", stop_on_failure = FALSE)
  table <- as.data.frame(results)
  write.csv(table[, !vapply(table, is.list, logical(1))],
    file.path("docs-dev/fx6-logs", paste0(mode, "-results.csv")), row.names = FALSE)
  cat("\nTOTALS: blocks=", nrow(table), " failed=", sum(table$failed),
    " errors=", sum(table$error), " warnings=", sum(table$warning),
    " skipped=", sum(table$skipped), " passed=", sum(table$passed), "\n", sep = "")
} else if (mode == "check") {
  results <- devtools::check(document = FALSE, args = "--as-cran",
    error_on = "never", check_dir = normalizePath("docs-dev/fx6-logs", winslash = "/"))
  saveRDS(results, "docs-dev/fx6-logs/check-results.rds")
  cat("\nCHECK TOTALS: errors=", length(results$errors), " warnings=", length(results$warnings),
    " notes=", length(results$notes), "\n", sep = "")
} else stop("Unknown mode")
sink(type = "message")
sink()
close(con)
