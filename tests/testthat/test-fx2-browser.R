# Fresh-audit cases plus nearby inputs. Each test fails on f624cf4.
test_that("fx2 H01: flashing preserves hue and alpha at every phase", {
  fxb_available()
  colors <- c("red", "blue", "transparent", "rgba(255,0,0,0)", "#00f8")
  widgets <- lapply(colors, function(color) fxb_render(threeDots(shiny::div(), type = "flashing", color = color)))
  s <- fxb_open(fxb_page(body = paste(vapply(widgets, `[[`, "", "html"), collapse = ""),
    head = paste(vapply(widgets, `[[`, "", "head"), collapse = ""), css = fxb_file("three-dots/css/three-dots.css")))
  on.exit(s$close())
  for (time in c(0, 250, 500, 750, 1000, 1500)) {
    values <- fxb_eval(s, sprintf("Array.from(document.querySelectorAll('.dot-flashing')).map(el => {
      el.getAnimations({subtree:true}).forEach(a=>{a.pause(); a.currentTime=%d;});
      return ['', '::before','::after'].map(p=>getComputedStyle(el,p).backgroundColor);
    })", time))
    for (i in seq_along(colors)) for (paint in values[[i]]) {
      rgba <- as.numeric(regmatches(paint, gregexpr("[0-9.]+", paint))[[1]])
      if (i %in% c(3, 4)) expect_equal(tail(rgba, 1), 0)
      else {
        expect_equal(rgba[2], 0)
        expect_equal(rgba[if (i == 1) 3 else 1], 0)
        expect_equal(rgba[if (i == 1) 1 else 3], 255)
        if (i == 5) expect_lte(tail(rgba, 1), 8 / 15 + .001)
      }
    }
  }
})

test_that("fx2 M01: reused Alertify alerts replace their type accent", {
  fxb_available()
  s <- fxb_open(fxb_page(js = c(fxb_file("alertify/js/alertify.min.js"), fxb_file("alertify/js/sbyAlertify.js")),
    css = c(fxb_file("alertify/css/alertify.min.css"), fxb_file("alertify/css/sbyAlertify.css"))))
  on.exit(s$close())
  for (type in c("error", "success", "error", "warning", "message")) {
    p <- fxb_payload(alertify_alert, type = type, transition_off = TRUE)
    fxb_eval(s, sprintf("alertify.alert().close(); Shiny.handlers['alertify.alert'](%s); true;", p))
    state <- fxb_eval(s, "var e=alertify.alert().elements.dialog; ({types:Array.from(e.classList).filter(x=>x.indexOf('sby-alert-')===0),color:getComputedStyle(e).borderTopColor})")
    expect_identical(unlist(state$types), paste0("sby-alert-", type))
    if (type %in% c("success", "warning")) expect_identical(state$color,
      if (type == "success") "rgb(92, 184, 92)" else "rgb(240, 173, 78)")
  }
})

test_that("fx2 M02: accepted CSS colours actually paint in Chrome", {
  fxb_available()
  colors <- c("#f00", "#f008", "#ff0000", "#ff000080", "rgb(255,0,0)",
              "rgba(255,0,0,.5)", "hsl(0 100% 50% / 50%)", "transparent")
  widgets <- lapply(colors, function(color) fxb_render(spinners(shiny::div(), type = 8, color = color)))
  s <- fxb_open(fxb_page(body = paste(vapply(widgets, `[[`, "", "html"), collapse=""),
    head = paste(vapply(widgets, `[[`, "", "head"), collapse=""), css=fxb_file("spinners/css/spinners.css")))
  on.exit(s$close())
  paint <- fxb_eval(s, "Array.from(document.querySelectorAll('.load8 .loader')).map(e=>getComputedStyle(e).borderLeftColor)")
  expect_length(paint, length(colors))
  for (i in seq_along(colors)) {
    if (i < 8) expect_match(paint[[i]], "255, 0, 0", fixed=TRUE)
    else expect_identical(paint[[i]], "rgba(0, 0, 0, 0)")
  }
  # The audit's invalid input must be stopped before any DOM is emitted.
  expect_error(spinners(shiny::div(), type=8, color="rgb(255,0,0,)"), "Invalid `color`")
  expect_error(spinners(shiny::div(), type=8, color="rgb(100%,0,0)"), "Invalid `color`")
})

test_that("fx2 M03: viz dots darken clamped CSS channels", {
  fxb_available()
  colors <- c("rgb(300,0,0)", "rgb(1000 0 0)", "rgb(120% 0% 0%)", "rgba(-50,300,0,.5)")
  widgets <- lapply(colors, function(color) fxb_render(vizLoad(shiny::div(), type="dots", color=color)))
  s <- fxb_open(fxb_page(body=paste(vapply(widgets, `[[`, "", "html"),collapse=""),
    head=paste(vapply(widgets, `[[`, "", "head"),collapse=""), css=fxb_file("vizload/css/ridics.css")))
  on.exit(s$close())
  paint <- fxb_eval(s, "Array.from(document.querySelectorAll('.lv-dots')).map(e=>{var d=e.querySelector('div'), a=d.getAnimations()[0];a.pause();a.currentTime=500;return getComputedStyle(d).backgroundColor;})")
  expect_identical(unlist(paint), c(rep("rgb(115, 0, 0)",3), "rgba(0, 115, 0, 0.5)"))
})

test_that("fx2 M04: wander travel scales with each widget size", {
  fxb_available()
  widgets <- lapply(c("4px", "400px", "5em"), function(size) fxb_render(spinkit(shiny::div(), type="wander", size=size)))
  s <- fxb_open(fxb_page(body=paste(vapply(widgets, `[[`, "", "html"),collapse=""),
    head=paste(vapply(widgets, `[[`, "", "head"),collapse=""), css=fxb_file("spinkit/css/spinkit.min.css")))
  on.exit(s$close())
  state <- fxb_eval(s, "Array.from(document.querySelectorAll('.sk-wander')).map(e=>{var c=e.firstElementChild,a=c.getAnimations()[0];a.pause();a.currentTime=a.effect.getTiming().duration/4;return {width:e.getBoundingClientRect().width,travel:new DOMMatrix(getComputedStyle(c).transform).m41};})")
  for (x in state) expect_equal(x$travel, x$width * .75, tolerance=.01)
})

test_that("fx2 M06: relative cover widths reserve used space and resize", {
  fxb_available()
  s <- fxb_toast_page()
  on.exit(s$close())
  for (rtl in c(FALSE, TRUE)) for (width in c("5em", "10vw")) {
    p <- fxb_payload(toast, title="Image", message="Body", image="some-image.png",
                     image_width=width, rtl=rtl, display_mode=2, duration=FALSE)
    fxb_eval(s, sprintf("Shiny.handlers['toast.send'](%s); true;", p))
    fxb_wait(s, 100)
    for (viewport in c(992, 1200)) {
      s$Emulation$setDeviceMetricsOverride(width=viewport,height=800,deviceScaleFactor=1,mobile=FALSE)
      fxb_wait(s, 80)
      state <- fxb_eval(s, "var t=Array.from(document.querySelectorAll('.iziToast')).pop(),b=t.querySelector('.iziToast-body'),c=t.querySelector('.iziToast-cover');({width:c.getBoundingClientRect().width,margin:parseFloat(getComputedStyle(b)[t.dir==='rtl'?'marginRight':'marginLeft'])})")
      expect_equal(state$margin, state$width+10, tolerance=.05)
    }
  }
})

test_that("fx2 M07: stale Escape and repeated clicks cannot drain the queue", {
  fxb_available()
  for (click in c(FALSE, TRUE)) {
    s <- fxb_toast_page()
    tryCatch({
      send <- function(title, ...) fxb_eval(s, sprintf("Shiny.handlers['toast.send'](%s);true;",
        fxb_payload(toast,title=title,message=title,duration=FALSE,...)))
      send("A",close_on_escape=!click,close_on_click=click)
      fxb_wait(s, 150)
      if (!click) {
        fxb_eval(s,"document.dispatchEvent(new KeyboardEvent('keyup',{keyCode:27}));true;")
        fxb_wait(s,1400)
        send("B",close_on_escape=FALSE)
      } else send("B",display_mode=2)
      send("C",display_mode=0)
      fxb_eval(s,if(click) "var a=document.querySelector('.iziToast');a.click();a.click();true;" else "document.dispatchEvent(new KeyboardEvent('keyup',{keyCode:27}));true;")
      fxb_wait(s,1400)
      expect_identical(unlist(fxb_eval(s,"Array.from(document.querySelectorAll('.iziToast:not(.iziToast-closing) .iziToast-message')).map(e=>e.textContent)")),"B")
      fxb_eval(s,"iziToast.hide({},document.querySelector('.iziToast:not(.iziToast-closing)'));true;")
      fxb_wait(s,1400)
      expect_identical(unlist(fxb_eval(s,"Array.from(document.querySelectorAll('.iziToast:not(.iziToast-closing) .iziToast-message')).map(e=>e.textContent)")),"C")
    }, finally=s$close())
  }
  # Mode 2 copies new options onto outgoing toasts, including callbacks. Track
  # the old element identities correctly even through rapid replacements.
  s <- fxb_toast_page()
  on.exit(s$close())
  same <- fxb_payload(toast,title="Same",message="Same",display_mode=2,duration=FALSE)
  queued <- fxb_payload(toast,title="Next",message="Next",display_mode=0,duration=FALSE)
  fxb_eval(s,sprintf("for(var i=0;i<3;i++)Shiny.handlers['toast.send'](%s);Shiny.handlers['toast.send'](%s);true;",same,queued))
  fxb_wait(s,1400)
  expect_identical(unlist(fxb_eval(s,"Array.from(document.querySelectorAll('.iziToast:not(.iziToast-closing) .iziToast-message')).map(e=>e.textContent)")),"Same")
  fxb_eval(s,"iziToast.hide({},document.querySelector('.iziToast:not(.iziToast-closing)'));true;")
  fxb_wait(s,1400)
  expect_identical(unlist(fxb_eval(s,"Array.from(document.querySelectorAll('.iziToast:not(.iziToast-closing) .iziToast-message')).map(e=>e.textContent)")),"Next")
})

test_that("fx2 M08: comma-decimal options preserve computed toast sizes", {
  fxb_available()
  old <- options(OutDec=",")
  on.exit(options(old))
  s <- fxb_toast_page()
  on.exit(s$close(),add=TRUE)
  for (size in c(12.5,.5)) {
    p <- fxb_payload(toast,title="Title",message="Body",title_size=size,message_size=18.5,
      image="some-image.png",image_width=size,display_mode=2,duration=FALSE,animate_inside=FALSE)
    fxb_eval(s,sprintf("Shiny.handlers['toast.send'](%s);true;",p))
    fxb_wait(s,100)
    value <- fxb_eval(s,"var t=Array.from(document.querySelectorAll('.iziToast:not(.iziToast-closing)')).pop(); [parseFloat(getComputedStyle(t.querySelector('.iziToast-title')).fontSize),parseFloat(getComputedStyle(t.querySelector('.iziToast-message')).fontSize),t.querySelector('.iziToast-cover').getBoundingClientRect().width]")
    expect_equal(unlist(value),c(size,18.5,size),tolerance=.01)
  }
})

test_that("fx2 M09: nonblocking notices fade and pass clicks through with controls", {
  fxb_available()
  for (translucent in c(FALSE,TRUE)) {
    s <- fxb_notify_page()
    tryCatch({
      p <- fxb_payload(notify,title="Notice",text="Body",hide=FALSE,animation="none",
        non_blocking=TRUE,translucent=translucent)
      fxb_eval(s,sprintf("Shiny.handlers['notify.send'](%s);window.clicks=0;true;",p))
      fxb_wait(s,150)
      rect <- fxb_eval(s,"var n=document.querySelector('.pnotify'),r=n.getBoundingClientRect(); var b=document.createElement('button');b.id='under';b.style.cssText='position:fixed;inset:0;width:100vw;height:100vh';b.onclick=()=>window.clicks++;document.body.prepend(b);({x:r.left+20,y:r.top+30})")
      s$Input$dispatchMouseEvent(type="mouseMoved",x=rect$x,y=rect$y)
      fxb_wait(s,300)
      state <- fxb_eval(s,"var n=document.querySelector('.pnotify');({opacity:parseFloat(getComputedStyle(n).opacity),controls:n.querySelectorAll('.pnotify-closer,.pnotify-sticker').length})")
      expect_lt(state$opacity,.7)
      expect_equal(state$controls,2)
      s$Input$dispatchMouseEvent(type="mousePressed",x=rect$x,y=rect$y,button="left",clickCount=1)
      s$Input$dispatchMouseEvent(type="mouseReleased",x=rect$x,y=rect$y,button="left",clickCount=1)
      expect_equal(fxb_eval(s,"window.clicks"),1)
      s$Input$dispatchMouseEvent(type="mouseMoved",x=1,y=1)
      fxb_wait(s,300)
      expect_equal(fxb_eval(s,"parseFloat(getComputedStyle(document.querySelector('.pnotify')).opacity)"),if(translucent) .7 else 1)
      # Hover must reveal usable controls, not just preserve invisible nodes.
      s$Input$dispatchMouseEvent(type="mouseMoved",x=rect$x,y=rect$y)
      control <- fxb_eval(s,"var c=document.querySelector('.pnotify-closer'),r=c.getBoundingClientRect();({x:r.left+r.width/2,y:r.top+r.height/2,visibility:getComputedStyle(c).visibility})")
      expect_identical(control$visibility,"visible")
      s$Input$dispatchMouseEvent(type="mousePressed",x=control$x,y=control$y,button="left",clickCount=1)
      s$Input$dispatchMouseEvent(type="mouseReleased",x=control$x,y=control$y,button="left",clickCount=1)
      fxb_wait(s,300)
      expect_equal(fxb_eval(s,"document.querySelectorAll('.pnotify').length"),0)
    },finally=s$close())
  }
})

test_that("fx2 M10: repeated Tingle closes remove nodes and listeners", {
  fxb_available()
  s <- fxb_open(fxb_page(js=c(fxb_file("tingle/js/tingle.min.js"),fxb_file("tingle/js/sbyTingle.js")),css=fxb_file("tingle/css/tingle.min.css")))
  on.exit(s$close())
  fxb_eval(s,"window.live={resize:0,keydown:0}; [window,document].forEach(t=>{var add=t.addEventListener,remove=t.removeEventListener;t.addEventListener=function(k,f,o){if(k in live)live[k]++;return add.call(this,k,f,o)};t.removeEventListener=function(k,f,o){if(k in live)live[k]--;return remove.call(this,k,f,o)};});true;")
  for (footer in c(FALSE,TRUE)) for (n in c(3,25)) {
    p <- fxb_payload(tingle,content="x",close_button=footer)
    state <- fxb_eval(s,sprintf("for(var j=0;j<%d;j++){Shiny.handlers['tingle.send'](%s);document.querySelector('%s').click();} ({nodes:document.querySelectorAll('.tingle-modal').length,resize:live.resize,keydown:live.keydown});",n,p,if(footer) ".tingle-modal--visible .tingle-btn" else ".tingle-modal--visible .tingle-modal__close"))
    expect_equal(unlist(state),c(nodes=0,resize=0,keydown=0))
  }
})

test_that("fx2 M11: notice types have distinct computed appearance", {
  fxb_available()
  css <- useNS()$stylesheet
  s <- fxb_open(fxb_page(js=vapply(c("modernizr.custom.js","classie.js","notificationFx.js","ns.js"),function(x)fxb_file("ns/js",x),""),css=vapply(css,function(x)fxb_file("ns",x),"")))
  on.exit(s$close())
  # The harness inlines scripts in the head; real dependency scripts are deferred.
  fxb_eval(s,"NotificationFx.prototype.options.wrapper=document.body;true;")
  for (pair in list(c("growl","jelly"),c("bar","slidetop"))) {
    colors <- vapply(c("notice","success","warning","error"),function(type){
      p <- fxb_payload(notice,message="Same",type=type,layout=pair[1],effect=pair[2])
      fxb_eval(s,sprintf("Shiny.handlers['ns.send'](%s);getComputedStyle(document.querySelector('.ns-type-%s')).backgroundColor;",p,type))
    },"")
    expect_length(unique(colors),4)
  }
})

test_that("fx2 L01: extra-large BootBox works with default Bootstrap 3", {
  fxb_available()
  bs <- system.file("www/shared/bootstrap",package="shiny")
  s <- fxb_open(fxb_page(jquery=TRUE,js=c(file.path(bs,"js/bootstrap.min.js"),fxb_file("bootbox/js/bootbox.all.min.js"),fxb_file("bootbox/js/sbyBootbox.js")),css=c(file.path(bs,"css/bootstrap.min.css"),vapply(useBootBox()[[1]]$stylesheet,function(x)fxb_file("bootbox",x),""))))
  on.exit(s$close())
  for(viewport in c(992,1200)) {
    s$Emulation$setDeviceMetricsOverride(width=viewport,height=800,deviceScaleFactor=1,mobile=FALSE)
    widths <- vapply(c("small","large","extra-large"),function(size){
      p <- fxb_payload(bootBox,size=size,animate=FALSE)
      fxb_eval(s,sprintf("bootbox.hideAll();Shiny.handlers['bootbox.send'](%s);document.querySelector('.bootbox .modal-dialog').getBoundingClientRect().width;",p))
    },0)
    expect_gt(widths[3],widths[2])
    expect_gt(widths[2],widths[1])
    expect_lte(widths[3],viewport-30)
  }
})
