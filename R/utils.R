glanceThreeDots <- function(type = "elastic") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("dot-", type, " standby-wait")
    )
  )
}

glanceSpinkit <- function(type = "rotating-plane", color = NULL, width = NULL, height = NULL) {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("sk-plane", " standby-wait"),
      style = c(paste0('width:', width, ';'),
                paste0('height:', height, ';'),
                paste0('background-color:', color, ';'))
    )
  )
}

glanceVizLoad <- function(type = "bars") {
  tags$div(
    class = "standby",
    tags$div(
      class = paste0("lv-bars lv-mid lg", " standby-wait"),
      lapply(1:8, function(i) div())
    )
  )
}

glanceSpinners <- function(type = "load1") {
  tags$div(
    class = "standby",
    tags$div(
      class = type,
      tags$div(class = "loader")
    )
  )
}

glanceLoaders <- function(type = "default") {
  tags$div(
    class = "standby",
    tags$div(
      id = "loader",
      class = paste0("loader loader-", type, " is-active")
    )
  )
}

spinkit_plane <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-plane standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";"),
              if (!is.null(color)) paste0('background-color: ', color, ';'))
  )
}

spinkit_chase <- function(size = NULL) {
  tags$div(
    class = "sk-chase standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:6, function(i) div(class = "sk-chase-dot"))
  )
}

spinkit_bounce <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-bounce standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:2, function(i) div(class = "sk-bounce-dot",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_wave <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-wave standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:5, function(i) div(class = "sk-wave-rect",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_pulse <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-pulse standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";"),
              if (!is.null(color)) paste0('background-color:', color, ';'))
  )
}

spinkit_flow <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-flow standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:3, function(i) div(class = "sk-flow-dot",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_swing <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-swing standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:3, function(i) div(class = "sk-swing-dot",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}


spinkit_circle <- function(size = NULL) {
  tags$div(
    class = "sk-circle standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:12, function(i) div(class = "sk-circle-dot"))
  )
}

spinkit_circle_fade <- function(size = NULL) {
  tags$div(
    class = "sk-circle-fade standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:12, function(i) div(class = "sk-circle-fade-dot"))
  )
}

spinkit_grid <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-grid standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:9, function(i) div(class = "sk-grid-cube",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

spinkit_fold <- function(size = NULL) {
  tags$div(
    class = "sk-fold standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:4, function(i) div(class = "sk-fold-cube"))
  )
}

spinkit_wander <- function(color = NULL, size = NULL) {
  tags$div(
    class = "sk-wander standby-wait",
    style = c(if (!is.null(size)) paste0('width: ', size, '; height: ', size, ";")),
    lapply(1:4, function(i) div(class = "sk-wander-cube",
                                style = c(if (!is.null(color)) paste0('background-color:', color, ';'))))
  )
}

# vizLoad
viz_bars <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lv-mid",
                  "tiny"   = "tiny lv-mid")

  tags$div(
    class = paste0("lv-bars ", scale, " standby-wait"),
    lapply(1:8, function(i) div(
      style = c(if (!is.null(bg_color)) paste0('background-color:', bg_color, ';'))
    ))
  )
}

viz_squares <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lv-mid",
                  "tiny"   = "tiny lv-mid")

  tags$div(
    class = paste0("lv-squares ", scale, " standby-wait"),
    lapply(1:4, function(i) div(
      style = c(if (!is.null(bg_color)) paste0('background-color:', bg_color, ';'))
    ))
  )
}

viz_circles <- function(size = "large") {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lv-mid",
                  "tiny"   = "tiny lv-mid")

  tags$div(
    class = paste0("lv-circles ", scale, " standby-wait"),
    lapply(1:12, function(i) div())
  )
}

viz_dots <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lv-mid",
                  "tiny"   = "tiny lv-mid")

  tags$div(
    class = paste0("lv-dots ", scale, " standby-wait"),
    lapply(1:4, function(i) div(
      style = c(if (!is.null(bg_color)) paste0('background-color:', bg_color, ';'))
    ))
  )
}

viz_spinner <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lv-mid",
                  "tiny"   = "tiny lv-mid")

  tags$div(
    class = paste0("lv-spinner ", scale, " standby-wait"),
    div(
      style = c(if (!is.null(bg_color)) paste0('border-top: 10px solid ', bg_color, ';'))
    )
  )
}

viz_dashed <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "large"  = "lv-mid lg",
                  "medium" = "lv-mid md",
                  "small"  = "sm lv-mid",
                  "tiny"   = "tiny lv-mid")

  tags$div(
    class = paste0("lv-dashed ", scale, " standby-wait"),
    div(
      style = c(if (!is.null(bg_color)) paste0('border: 12px dashed ', bg_color, ';'))
    )
  )
}

viz_line <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "fluid"  = "lv-mid",
                  "large"  = "lg lv-mid",
                  "medium" = "md lv-mid",
                  "small"  = "sm lv-mid")

  tags$div(
    class = paste0("lv-line ", scale, " standby-wait"),
    style = c("height: 5px;"),
    div(
      style = c(if (!is.null(bg_color)) paste0('background-color: ', bg_color, ';'),
                'height: 5px;')
    )
  )
}

viz_bordered_line <- function(size = "large", bg_color = NULL) {

  scale <- switch(size,
                  "fluid"  = "lv-mid",
                  "large"  = "lg lv-mid",
                  "medium" = "md lv-mid",
                  "small"  = "sm lv-mid")

  tags$div(
    class = paste0("lv-bordered_line ", scale, " standby-wait"),
    style = c("height: 21px;",
              if (!is.null(bg_color)) paste0('border: 5px solid ', bg_color, ';')),
    div(
      style = c(if (!is.null(bg_color)) paste0('background-color: ', bg_color, ';'),
                'height: 5px;')
    )
  )
}

spinner_color_rgb <- function(color) {
  trimmed <- trimws(color)
  lower <- tolower(trimmed)

  # These cannot be resolved to fixed RGB components.
  if (lower %in% c("transparent", "currentcolor")) {
    return(NULL)
  }

  if (grepl("^rgba?\\(", lower)) {
    inner <- sub("^rgba?\\(", "", trimmed, ignore.case = TRUE)
    inner <- sub("\\)$", "", inner)
    parts <- trimws(strsplit(inner, ",")[[1]])
    parts <- parts[seq_len(min(3L, length(parts)))]
    vals <- vapply(parts, function(part) {
      if (grepl("%$", part)) {
        as.numeric(sub("%$", "", part)) * 255 / 100
      } else {
        as.numeric(part)
      }
    }, numeric(1))
    return(as.integer(pmin(pmax(round(vals), 0), 255)))
  }

  if (grepl("^hsla?\\(", lower)) {
    inner <- sub("^hsla?\\(", "", trimmed, ignore.case = TRUE)
    inner <- sub("\\)$", "", inner)
    parts <- trimws(strsplit(inner, ",")[[1]])
    h <- as.numeric(sub("deg$", "", parts[1], ignore.case = TRUE)) %% 360
    s <- as.numeric(sub("%$", "", parts[2])) / 100
    l <- as.numeric(sub("%$", "", parts[3])) / 100
    return(spinner_hsl_to_rgb(h, s, l))
  }

  # Hex colours with an alpha channel are not supported by col2rgb().
  if (grepl("^#([0-9a-fA-F]{4}|[0-9a-fA-F]{8})$", trimmed)) {
    hex <- sub("^#", "", trimmed)
    if (nchar(hex) == 8) {
      hex <- substr(hex, 1, 6)
    } else {
      rgb_part <- substr(hex, 1, 3)
      hex <- paste0(
        substr(rgb_part, 1, 1), substr(rgb_part, 1, 1),
        substr(rgb_part, 2, 2), substr(rgb_part, 2, 2),
        substr(rgb_part, 3, 3), substr(rgb_part, 3, 3)
      )
    }
    return(strtoi(substring(hex, c(1, 3, 5), c(2, 4, 6)), 16L))
  }

  as.integer(grDevices::col2rgb(trimmed))
}

spinner_hsl_to_rgb <- function(h, s, l) {
  s <- min(max(s, 0), 1)
  l <- min(max(l, 0), 1)
  chroma <- (1 - abs(2 * l - 1)) * s
  x <- chroma * (1 - abs((h / 60) %% 2 - 1))
  m <- l - chroma / 2
  r <- g <- b <- 0

  if (h < 60) {
    r <- chroma; g <- x
  } else if (h < 120) {
    r <- x; g <- chroma
  } else if (h < 180) {
    g <- chroma; b <- x
  } else if (h < 240) {
    g <- x; b <- chroma
  } else if (h < 300) {
    r <- x; b <- chroma
  } else {
    r <- chroma; b <- x
  }

  as.integer(pmin(pmax(round((c(r, g, b) + m) * 255), 0), 255))
}

spinner_shade <- function(color, alpha, sep = ", ") {
  rgb <- spinner_color_rgb(color)

  if (is.null(rgb)) {
    paste0(
      "color-mix(in srgb, ", color, " ",
      sprintf("%g", alpha * 100), "%, transparent)"
    )
  } else {
    paste0("rgba(", paste0(rgb, collapse = sep), sep, alpha, ")")
  }
}

spinner_css <- function(color, id) {
  s02 <- spinner_shade(color, 0.2)
  s05 <- spinner_shade(color, 0.5)
  s07 <- spinner_shade(color, 0.7)
  paste0(
            "-webkit-animation: load5 1.1s infinite ease;
            animation: load5 1.1s infinite ease; 
            @-webkit-keyframes load5-", id, " {
              0%,
              100% {
                box-shadow: 0em -2.6em 0em 0em ", color, ", 
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s05, ",
                  -1.8em -1.8em 0 0em ", s07, ";
              }
              12.5% {
                box-shadow: 0em -2.6em 0em 0em ", s07, ",
                  1.8em -1.8em 0 0em ", color, ", 
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s05, ";
              }
              25% {
                box-shadow: 0em -2.6em 0em 0em ", s05, ",
                  1.8em -1.8em 0 0em ", s07, ",
                  2.5em 0em 0 0em ", color, ", 
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              37.5% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s05, ",
                  2.5em 0em 0 0em ", s07, ",
                  1.75em 1.75em 0 0em ", color, ", 
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              50% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s05, ",
                  1.75em 1.75em 0 0em ", s07, ",
                  0em 2.5em 0 0em ", color, ",  
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              62.5% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s05, ",
                  0em 2.5em 0 0em ", s07, ",
                  -1.8em 1.8em 0 0em ", color, ", 
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              75% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s05, ",
                  -1.8em 1.8em 0 0em ", s07, ",
                  -2.6em 0em 0 0em ", color, ", 
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              87.5% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s05, ",
                  -2.6em 0em 0 0em ", s07, ",
                  -1.8em -1.8em 0 0em ", color, ";
              }
            } ", 
            "@keyframes load5-", id, " {
              0%,
              100% {
                box-shadow: 0em -2.6em 0em 0em ", color, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s05, ",
                  -1.8em -1.8em 0 0em ", s07, ";
              }
              12.5% {
                box-shadow: 0em -2.6em 0em 0em ", s07, ",
                  1.8em -1.8em 0 0em ", color, ", 
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s05, ";
              }
              25% {
                box-shadow: 0em -2.6em 0em 0em ", s05, ",
                  1.8em -1.8em 0 0em ", s07, ",
                  2.5em 0em 0 0em ", color, ", 
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              37.5% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s05, ",
                  2.5em 0em 0 0em ", s07, ",
                  1.75em 1.75em 0 0em ", color, ", 
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              50% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s05, ",
                  1.75em 1.75em 0 0em ", s07, ",
                  0em 2.5em 0 0em ", color, ", 
                  -1.8em 1.8em 0 0em ", s02, ",
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              62.5% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s05, ",
                  0em 2.5em 0 0em ", s07, ",
                  -1.8em 1.8em 0 0em ", color, ", 
                  -2.6em 0em 0 0em ", s02, ",
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              75% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s05, ",
                  -1.8em 1.8em 0 0em ", s07, ",
                  -2.6em 0em 0 0em ", color, ", 
                  -1.8em -1.8em 0 0em ", s02, ";
              }
              87.5% {
                box-shadow: 0em -2.6em 0em 0em ", s02, ",
                  1.8em -1.8em 0 0em ", s02, ",
                  2.5em 0em 0 0em ", s02, ",
                  1.75em 1.75em 0 0em ", s02, ",
                  0em 2.5em 0 0em ", s02, ",
                  -1.8em 1.8em 0 0em ", s05, ",
                  -2.6em 0em 0 0em ", s07, ",
                  -1.8em -1.8em 0 0em ", color, ";
              }
            }")
}







validate_color <- function(color, name = "color", allow_null = FALSE) {
  if (is.null(color)) {
    if (allow_null) return(invisible(NULL))
    stop(sprintf("`%s` cannot be NULL.", name), call. = FALSE)
  }
  if (!is.character(color) || length(color) != 1 || is.na(color)) {
    stop(sprintf("Invalid `%s`: must be a single string.", name), call. = FALSE)
  }

  trimmed <- trimws(color)

  # Check named colors
  if (tolower(trimmed) %in% tolower(grDevices::colors())) {
    return(invisible(color))
  }

  # Check transparent or currentColor
  if (tolower(trimmed) %in% c("transparent", "currentcolor")) {
    return(invisible(color))
  }

  # Check hex: #RGB, #RGBA, #RRGGBB, #RRGGBBAA
  if (grepl("^#([0-9a-fA-F]{3}|[0-9a-fA-F]{4}|[0-9a-fA-F]{6}|[0-9a-fA-F]{8})$", trimmed)) {
    return(invisible(color))
  }

  # Check rgb/rgba/hsl/hsla with numbers only
  if (grepl("^(rgb|hsl)a?\\(\\s*((?:[0-9]+(?:\\.[0-9]*)?|\\.[0-9]+)%?\\s*,\\s*){2,3}(?:[0-9]+(?:\\.[0-9]*)?|\\.[0-9]+)%?\\s*\\)$", trimmed, ignore.case = TRUE)) {
    return(invisible(color))
  }

  stop(sprintf("Invalid `%s`: '%s'. Expected a valid color name, hex code, or rgb/rgba/hsl/hsla expression.", name, color), call. = FALSE)
}

.standby_id_env <- new.env(parent = emptyenv())

generate_id <- function(prefix = "standby") {
  cur <- .standby_id_env[[prefix]]
  if (is.null(cur)) cur <- 0L
  cur <- cur + 1L
  .standby_id_env[[prefix]] <- cur
  paste0(prefix, "-", cur)
}

reset_id <- function(prefix = NULL) {
  if (is.null(prefix)) {
    rm(list = ls(.standby_id_env), envir = .standby_id_env)
  } else {
    .standby_id_env[[prefix]] <- 0L
  }
}
