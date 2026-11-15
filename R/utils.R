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

  # The pulsating keyframes set the background colour themselves, so the
  # requested colour is carried in custom properties that the keyframes read.
  dot_style <- if (is.null(bg_color)) NULL else paste0(
    '--lv-dots-color:', bg_color, ';',
    '--lv-dots-color-dark:', color_darken(bg_color), ';',
    'background-color:', bg_color, ';'
  )

  tags$div(
    class = paste0("lv-dots ", scale, " standby-wait"),
    lapply(1:4, function(i) div(style = dot_style))
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

# CSS named colours that are not part of R's colour names. R's colour names
# are used for every name R knows so that a name always resolves to the same
# colour as grDevices::col2rgb() (for example "green" is #00FF00, not CSS
# green #008000).
css_only_colors <- c(
  aqua          = "#00FFFF",
  crimson       = "#DC143C",
  fuchsia       = "#FF00FF",
  indigo        = "#4B0082",
  lime          = "#00FF00",
  olive         = "#808000",
  rebeccapurple = "#663399",
  silver        = "#C0C0C0",
  teal          = "#008080"
)

css_number_regex <- "^[+-]?(?:[0-9]+(?:\\.[0-9]*)?|\\.[0-9]+)(?:[eE][+-]?[0-9]+)?$"

# CSS quantises non-negative channels by rounding halves up (30% of 255 is
# 76.5 and serialises as 77), unlike R's ties-to-even round().
round_channel <- function(x) {
  x <- pmin(pmax(x, 0), 255)
  floor(x + 0.5 + 1e-9)
}

parse_css_number <- function(x, percent_scale = FALSE) {
  if (!is.character(x) || length(x) != 1L || is.na(x)) return(NA_real_)
  x <- trimws(x)
  is_percent <- grepl("%$", x)
  value <- sub("%$", "", x)
  if (!grepl(css_number_regex, value)) return(NA_real_)
  value <- suppressWarnings(as.numeric(value))
  if (!is.finite(value)) return(NA_real_)
  if (percent_scale && is_percent) value <- value / 100
  value
}

css_hue_to_degrees <- function(x) {
  if (!is.character(x) || length(x) != 1L || is.na(x)) return(NA_real_)
  x <- tolower(trimws(x))
  unit <- ""
  value <- x
  for (candidate in c("grad", "deg", "rad", "turn")) {
    if (endsWith(x, candidate)) {
      unit <- candidate
      value <- substr(x, 1, nchar(x) - nchar(candidate))
      break
    }
  }
  if (!grepl(css_number_regex, value)) return(NA_real_)
  value <- suppressWarnings(as.numeric(value))
  if (!is.finite(value)) return(NA_real_)
  value <- switch(unit,
                  "grad" = value * 360 / 400,
                  "rad"  = value * 180 / pi,
                  "turn" = value * 360,
                  value)
  value %% 360
}

css_alpha_to_fraction <- function(x) {
  value <- parse_css_number(x, percent_scale = TRUE)
  if (is.na(value)) return(NA_real_)
  min(max(value, 0), 1)
}

css_hex_color <- function(x) {
  hex <- sub("^#", "", x)
  if (nchar(hex) %in% c(3L, 4L)) {
    hex <- paste0(
      substr(hex, 1, 1), substr(hex, 1, 1),
      substr(hex, 2, 2), substr(hex, 2, 2),
      substr(hex, 3, 3), substr(hex, 3, 3),
      if (nchar(hex) == 4L) paste0(substr(hex, 4, 4), substr(hex, 4, 4)) else ""
    )
  }
  list(
    r = strtoi(substr(hex, 1, 2), 16L),
    g = strtoi(substr(hex, 3, 4), 16L),
    b = strtoi(substr(hex, 5, 6), 16L),
    a = if (nchar(hex) == 8L) strtoi(substr(hex, 7, 8), 16L) / 255 else 1
  )
}

css_named_color <- function(name) {
  key <- tolower(trimws(name))
  if (identical(key, "transparent")) {
    return(list(r = 0, g = 0, b = 0, a = 0, named = TRUE))
  }
  if (key %in% names(css_only_colors)) {
    rgb <- css_hex_color(css_only_colors[[key]])
    rgb$named <- TRUE
    return(rgb)
  }
  rgb <- tryCatch(grDevices::col2rgb(key, alpha = TRUE),
                  error = function(e) NULL)
  if (is.null(rgb)) return(NULL)
  list(
    r = as.numeric(rgb["red", 1]),
    g = as.numeric(rgb["green", 1]),
    b = as.numeric(rgb["blue", 1]),
    a = as.numeric(rgb["alpha", 1]) / 255,
    named = TRUE
  )
}

# Parse the CSS colours the package supports: names, hex (3/4/6/8 digits),
# rgb()/rgba() and hsl()/hsla() in both comma and modern space/slash syntax.
# Returns NULL for invalid input and for currentColor (which cannot be
# resolved to fixed channels).
parse_css_color <- function(color) {
  if (!is.character(color) || length(color) != 1L || is.na(color)) return(NULL)
  x <- trimws(color)
  if (!nzchar(x) || nchar(x) > 100L) return(NULL)

  if (grepl("^#[0-9a-fA-F]{3,8}$", x) &&
      nchar(sub("^#", "", x)) %in% c(3L, 4L, 6L, 8L)) {
    parsed <- css_hex_color(x)
    parsed$named <- FALSE
    return(parsed)
  }

  fn <- regmatches(x, regexec("^([a-zA-Z]+)\\((.*)\\)$", x))[[1]]
  if (!length(fn)) {
    return(css_named_color(x))
  }

  name <- tolower(fn[2])
  args <- trimws(fn[3])
  if (!name %in% c("rgb", "rgba", "hsl", "hsla")) return(NULL)
  if (!nzchar(args)) return(NULL)

  alpha_part <- NULL
  if (grepl(",", args, fixed = TRUE)) {
    parts <- trimws(strsplit(args, ",", fixed = TRUE)[[1]])
    if (length(parts) %in% c(4L)) {
      alpha_part <- parts[4]
      parts <- parts[1:3]
    } else if (length(parts) != 3L) {
      return(NULL)
    }
  } else {
    slash <- strsplit(args, "/", fixed = TRUE)[[1]]
    if (length(slash) > 2L) return(NULL)
    if (length(slash) == 2L) alpha_part <- trimws(slash[2])
    parts <- strsplit(trimws(slash[1]), "[[:space:]]+")[[1]]
    if (length(parts) != 3L) return(NULL)
  }
  if (any(!nzchar(parts))) return(NULL)

  alpha <- if (is.null(alpha_part)) 1 else css_alpha_to_fraction(alpha_part)
  if (is.na(alpha)) return(NULL)

  if (name %in% c("rgb", "rgba")) {
    channels <- vapply(parts, function(part) {
      value <- parse_css_number(part, percent_scale = TRUE)
      if (is.na(value)) return(NA_real_)
      if (grepl("%$", trimws(part))) value * 255 else value
    }, numeric(1))
    if (anyNA(channels)) return(NULL)
    return(list(r = channels[1], g = channels[2], b = channels[3],
                a = alpha, named = FALSE))
  }

  h <- css_hue_to_degrees(parts[1])
  s <- parse_css_number(parts[2])
  l <- parse_css_number(parts[3])
  if (anyNA(c(h, s, l)) || !grepl("%$", trimws(parts[2])) ||
      !grepl("%$", trimws(parts[3]))) {
    return(NULL)
  }
  hsl <- spinner_hsl_to_rgb(h, s / 100, l / 100, round = FALSE)
  list(r = hsl[1], g = hsl[2], b = hsl[3], a = alpha, named = FALSE)
}

# Emit a parsed colour as a hex string (used to normalise R colour names such
# as "green" or "gray50" before they reach CSS).
color_to_hex <- function(parsed) {
  sprintf("#%02X%02X%02X", round_channel(parsed$r), round_channel(parsed$g),
          round_channel(parsed$b))
}

# Replace named colours with their hex value so that the main colour and any
# derived shades share one interpretation. Other notations are passed through
# unchanged (browsers resolve them, and shades are derived from the same
# fractional channels).
normalize_color <- function(color) {
  if (is.null(color)) return(NULL)
  parsed <- parse_css_color(color)
  if (is.null(parsed) || !isTRUE(parsed$named)) return(trimws(color))
  if (parsed$a < 1) {
    # "transparent" must not become opaque when its channels are normalised.
    return(paste0(
      "rgba(",
      paste0(c(round_channel(parsed$r), round_channel(parsed$g),
               round_channel(parsed$b)), collapse = ", "),
      ", ", format_css_alpha(parsed$a), ")"
    ))
  }
  color_to_hex(parsed)
}

spinner_color_rgb <- function(color) {
  parsed <- parse_css_color(color)
  if (is.null(parsed)) return(NULL)
  c(round_channel(parsed$r), round_channel(parsed$g), round_channel(parsed$b))
}

format_css_alpha <- function(alpha) {
  if (!is.finite(alpha) || alpha <= 0) return("0")
  if (alpha >= 1) return("1")
  sprintf("%.4g", alpha)
}

spinner_hsl_to_rgb <- function(h, s, l, round = TRUE) {
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

  rgb <- (c(r, g, b) + m) * 255
  if (isTRUE(round)) {
    as.integer(pmin(pmax(round(rgb), 0), 255))
  } else {
    pmin(pmax(rgb, 0), 255)
  }
}

# A shade keeps the hue of the requested colour and multiplies its alpha by
# the shade strength, so a fully transparent colour stays transparent.
spinner_shade <- function(color, alpha, sep = ", ") {
  parsed <- parse_css_color(color)

  if (is.null(parsed)) {
    paste0(
      "color-mix(in srgb, ", color, " ",
      sprintf("%g", alpha * 100), "%, transparent)"
    )
  } else {
    paste0(
      "rgba(",
      paste0(c(round_channel(parsed$r), round_channel(parsed$g),
               round_channel(parsed$b)), collapse = sep),
      sep, format_css_alpha(parsed$a * alpha), ")"
    )
  }
}

# Darken a colour while preserving its hue and alpha (used by vizLoad dots).
color_darken <- function(color, factor = 0.45) {
  parsed <- parse_css_color(color)
  if (is.null(parsed)) return(color)
  paste0(
    "rgba(",
    round_channel(parsed$r * factor), ", ",
    round_channel(parsed$g * factor), ", ",
    round_channel(parsed$b * factor), ", ",
    format_css_alpha(parsed$a), ")"
  )
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

  # currentColor cannot be resolved to fixed channels but is a valid CSS colour.
  if (identical(tolower(trimmed), "currentcolor")) {
    return(invisible(color))
  }

  if (!is.null(parse_css_color(trimmed))) {
    return(invisible(color))
  }

  stop(sprintf("Invalid `%s`: '%s'. Expected a valid color name, hex code, or rgb/rgba/hsl/hsla expression.", name, color), call. = FALSE)
}

# Normalise a CSS length supplied as a bare number or a string with units.
normalize_css_length <- function(value) {
  if (is.null(value) || length(value) != 1L || is.na(value)) return(value)
  if (is.numeric(value)) return(paste0(format(value, scientific = FALSE), "px"))
  if (!is.character(value)) return(value)
  trimmed <- trimws(value)
  if (grepl("^[+-]?(?:[0-9]+(?:\\.[0-9]*)?|\\.[0-9]+)$", trimmed)) {
    return(paste0(trimmed, "px"))
  }
  trimmed
}

# The documented "never close" delay sentinel. PNotify compares against the
# JavaScript numeric Infinity, so it can never be forwarded as a string.
is_infinite_delay <- function(delay) {
  if (is.null(delay) || length(delay) != 1L || is.na(delay)) return(FALSE)
  if (is.numeric(delay)) return(is.infinite(delay) && delay > 0)
  if (is.character(delay)) {
    return(tolower(trimws(delay)) %in% c("infinity", "infinite"))
  }
  FALSE
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
