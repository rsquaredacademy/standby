# The gate uses exported wrappers and their real dependency order, including
# standby.css. Inspecting the upstream CSS on its own misses cascade failures.
fx6_types <- list(
  threeDots = c("elastic", "pulse", "flashing", "collision", "revolution",
    "carousel", "typing", "windmill", "bricks", "floating", "fire", "spin",
    "falling", "stretching", "gathering", "hourglass", "overtaking", "shuttle",
    "bouncing", "rolling"),
  loaders = c("default", "bar", "bar-ping-pong", "border", "double", "clock",
    "curtain", "pokeball", "ball", "smartphone", "bouncing", "music"),
  spinkit = c("plane", "chase", "bounce", "wave", "pulse", "flow", "swing",
    "circle", "circle-fade", "grid", "fold", "wander"),
  spinners = as.character(1:8),
  vizLoad = c("bars", "squares", "circles", "dots", "spinner", "dashed",
    "line", "bordered_line")
)

fx6_cases <- function() {
  cases <- list()
  for (family in names(fx6_types)) {
    for (type in fx6_types[[family]]) {
      cases[[paste(family, type)]] <- list(family = family, args = list(type = type))
    }
  }
  cases
}

fx6_page <- function(case, all_dependencies = TRUE) {
  helpers <- c(threeDots = "useThreeDots", loaders = "useLoaders",
    spinkit = "useSpinkit", spinners = "useSpinners", vizLoad = "useVizLoad")
  dependencies <- lapply(helpers[if (all_dependencies) names(helpers) else case$family],
    function(helper) get(helper, asNamespace("standby"))())
  widget <- do.call(get(case$family, asNamespace("standby")),
    c(list(uiOutput = shiny::div(id = "output", style = "height:320px;width:100%;")), case$args))
  rt <- htmltools::renderTags(htmltools::tagList(dependencies, widget))
  css <- unlist(lapply(rt$dependencies, function(d) file.path(d$src$file, d$stylesheet)), use.names = FALSE)
  # All spinner families share this one bridge. Include it, and jquery, exactly
  # as on a Shiny page; use*() resolves duplicates via htmltools.
  fxb_page(body = rt$html, head = rt$head, css = css,
    js = fxb_file("standby/js/standby.js"), jquery = TRUE)
}

fx6_open <- function(case) {
  s <- fxb_open(fx6_page(case))
  s$Emulation$setDeviceMetricsOverride(width = 360L, height = 320L,
    deviceScaleFactor = 1, mobile = FALSE)
  s
}

fx6_phase <- function(s, phase) {
  fxb_eval(s, sprintf("(function(){
    document.getAnimations().forEach(function(a){
      a.pause(); a.currentTime=1000*%f;
    }); return new Promise(function(resolve){requestAnimationFrame(function(){
      requestAnimationFrame(resolve);});});})()", phase), await = TRUE)
}

fx6_capture <- function(s) s$Page$captureScreenshot(format = "png")$data

# Inspect real raster pixels rather than counting the transparent anchor box.
# Decode in Chrome's canvas so the optional gate needs no image library in R.
fx6_pixels <- function(s, first, second, overlay = FALSE) {
  fxb_eval(s, paste0("(async function(){
    async function pixels(data){var img=new Image();img.src='data:image/png;base64,'+data;
      await img.decode();var c=document.createElement('canvas');c.width=img.width;c.height=img.height;
      var ctx=c.getContext('2d');ctx.drawImage(img,0,0);return ctx.getImageData(0,0,c.width,c.height).data;}
    var a=await pixels(", jsonlite::toJSON(first, auto_unbox = TRUE), "),
        b=await pixels(", jsonlite::toJSON(second, auto_unbox = TRUE), ");
    var bg=", if (overlay) "38" else "255", ", count=0, diff=0, left=360, right=-1, top=320, bottom=-1;
    for(var i=0;i<a.length;i+=4){
      if(Math.max(Math.abs(a[i]-b[i]),Math.abs(a[i+1]-b[i+1]),Math.abs(a[i+2]-b[i+2]))>8)diff++;
      if(Math.max(Math.abs(a[i]-bg),Math.abs(a[i+1]-bg),Math.abs(a[i+2]-bg),
          Math.abs(b[i]-bg),Math.abs(b[i+1]-bg),Math.abs(b[i+2]-bg))>12){
        var x=(i/4)%360,y=Math.floor(i/4/360);count++;
        left=Math.min(left,x);right=Math.max(right,x);top=Math.min(top,y);bottom=Math.max(bottom,y);}}
    return {count:count,diff:diff,left:left,right:right,top:top,bottom:bottom};})()"), await = TRUE)
}
