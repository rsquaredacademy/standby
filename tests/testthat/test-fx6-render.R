# Every exported spinner family/type, real dependencies, normal and small sizes.
# Raster checks ensure that animation on an off-screen shadow does not pass.
fx6_check_case <- function(case, name) {
  s <- fx6_open(case)
  on.exit(s$close())
  state <- fxb_eval(s, "(function(){
    var root=document.querySelector('.standby-wait'), r=root.getBoundingClientRect();
    var nodes=[root].concat(Array.from(root.querySelectorAll('*'))), names=[];
    nodes.forEach(function(el){[null,'::before','::after'].forEach(function(p){
      var c=getComputedStyle(el,p);if((p===null||c.content!=='none')&&c.animationName!=='none')names.push(c.animationName);});});
    return {x:r.x,y:r.y,width:r.width,height:r.height,children:root.children.length,
      shown:getComputedStyle(root).visibility==='visible',animations:names.length,
      running:document.getAnimations().some(function(a){return a.playState==='running';}),
      scroll:document.documentElement.scrollWidth};})()")
  expect_true(state$shown, info = name)
  expect_gt(state$animations, 0, label = name)
  expect_true(state$running, info = name)
  # Check the actual graphic/pseudo-elements below as well as the anchor box.
  expect_gt(state$width, 0, label = name)
  expect_gt(state$height, 0, label = name)
  expect_gte(state$x, -0.5, label = name)
  expect_gte(state$y, -0.5, label = name)
  expect_lte(state$x + state$width, 360.5, label = name)
  expect_lte(state$y + state$height, 320.5, label = name)
  expect_lte(state$scroll, 360, label = name)
  expected <- switch(case$family,
    threeDots = as.integer(case$args$type %in% c("pulse", "carousel", "typing", "bricks", "fire", "falling")),
    loaders = 0, spinners = 1,
    spinkit = c(plane=0,chase=6,bounce=2,wave=5,pulse=0,flow=3,swing=2,
      circle=12,`circle-fade`=12,grid=9,fold=4,wander=3)[[case$args$type]],
    vizLoad = c(bars=8,squares=4,circles=12,dots=4,spinner=1,dashed=1,
      line=1,bordered_line=1)[[case$args$type]])
  expect_equal(state$children, expected, info = name)
  fx6_phase(s, .173)
  first <- fx6_capture(s)
  fx6_phase(s, .613)
  second <- fx6_capture(s)
  pixels <- fx6_pixels(s, first, second, case$family == "loaders")
  expect_gt(pixels$count, 4, label = paste(name, "visible paint"))
  expect_gt(pixels$diff, 2, label = paste(name, "visible animation"))
  # Border intentionally travels along viewport edges; vizLoad lines are
  # intentional bars. Every other graphic must leave a margin on all sides.
  edge <- (case$family == "loaders" && case$args$type == "border") ||
    (case$family == "vizLoad" && case$args$type %in% c("line", "bordered_line"))
  if (!edge) {
    expect_gt(pixels$left, 0, label = name)
    expect_lt(pixels$right, 359, label = name)
    expect_gt(pixels$top, 0, label = name)
    expect_lt(pixels$bottom, 319, label = name)
    expect_lt(pixels$right - pixels$left, 320, label = paste(name, "no full-width bar"))
  }
  if (case$family == "threeDots") {
    expect_true(fxb_eval(s, "document.querySelector('.standby-wait').getBoundingClientRect().width < 40"), info = name)
    if (case$args$type %in% c("pulse", "carousel", "typing", "bricks", "fire", "falling", "spin", "overtaking", "bouncing", "rolling")) {
      expect_identical(fxb_eval(s, "getComputedStyle(document.querySelector('.standby-wait')).backgroundColor"),
        "rgba(0, 0, 0, 0)", info = name)
    }
    if (case$args$type %in% c("pulse", "fire")) {
      # A visible animation can still be wrong: local box-shadows are clipped
      # against a transparent source and produce hollow centres. These phases
      # must paint a solid dot across the centre of the visible wrapper.
      fx6_phase(s, if (case$args$type == "pulse") .7 else 1.25)
      screenshot <- fx6_capture(s)
      center <- fxb_eval(s, paste0("(async function(){var img=new Image();img.src='data:image/png;base64,',
        img.src+=", jsonlite::toJSON(screenshot, auto_unbox = TRUE), ";await img.decode();
        var c=document.createElement('canvas');c.width=360;c.height=320;
        var ctx=c.getContext('2d');ctx.drawImage(img,0,0);
        return Array.from(ctx.getImageData(180,160,1,1).data);})()"), await = TRUE)
      expect_equal(unlist(center), c(152, 128, 255, 255), info = paste(name, "solid centre"))
    }
  }
}

for (family in names(fx6_types)) {
  local({
    current_family <- family
    test_that(paste("fx6 real-render gate covers every", current_family, "type"), {
      fxb_available()
      cases <- Filter(function(case) case$family == current_family, fx6_cases())
      for (name in names(cases)) fx6_check_case(cases[[name]], name)
    })
  })
}

test_that("fx6 real-render gate covers supported loader styles with and without text", {
  fxb_available()
  styles <- list(half = "default", inverse = c("default", "bar"),
    rounded = c("bar", "bar-ping-pong"), blink = c("default", "bar", "border"))
  for (style in names(styles)) {
    for (type in styles[[style]]) {
      texts <- if (type == "bar-ping-pong") list(NULL) else list(NULL, "Loading...")
      for (text in texts) {
        fx6_check_case(list(family = "loaders", args = list(type = type, style = style, text = text)),
          paste("loaders", type, style, if (is.null(text)) "no text" else text))
      }
    }
  }
  for (type in c("curtain", "smartphone")) {
    fx6_check_case(list(family = "loaders", args = list(type = type, text = "Loading...")), paste(type, "text"))
  }
})

test_that("fx6 real-render gate covers SpinKit sizes and translucent swing/wander", {
  fxb_available()
  for (type in fx6_types$spinkit) {
    for (size in c("24px", "64px")) {
      fx6_check_case(list(family = "spinkit", args = list(type = type, size = size)), paste(type, size))
    }
  }
  for (type in c("swing", "wander")) {
    for (color in c("rgba(255,0,0,0.4)", "hsla(0,100%,50%,0.4)", "#FF000066")) {
      fx6_check_case(list(family = "spinkit", args = list(type = type, color = color)), paste(type, color))
    }
  }
})

test_that("fx6 real-render gate covers every supported vizLoad size", {
  fxb_available()
  for (type in fx6_types$vizLoad) {
    sizes <- if (type %in% c("line", "bordered_line")) c("fluid", "medium", "small") else c("medium", "small", "tiny")
    for (size in sizes) {
      fx6_check_case(list(family = "vizLoad", args = list(type = type, size = size)), paste(type, size))
    }
  }
})
