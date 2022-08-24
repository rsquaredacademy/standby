/* iziToast */
Shiny.addCustomMessageHandler((type = 'toast.send'), function (message) {
  switch (message.type) {
    case 'info':
      iziToast.info(message);
      break;
    case 'success':
      iziToast.success(message);
      break;
    case 'warning':
      iziToast.warning(message);
      break;
    case 'error':
      iziToast.error(message);
      break;
    default:
      iziToast.show(message);
  }
});

/* MicroTip */
Shiny.addCustomMessageHandler((type = 'tip.send'), function (message) {
  let selector = '#' + message.id;
  let el = document.querySelector(selector);
  el.setAttribute('aria-label', message.tip);
  el.setAttribute('data-microtip-position', message.position);
  el.setAttribute('role', 'tooltip');
  console.log(message.size);
  if (message.size !== null) {
    el.setAttribute('data-microtip-size', message.size);
  }
});

/* PNotify */
Shiny.addCustomMessageHandler((type = 'notify.send'), function (message) {
  switch (message.type) {
    case 'notice':
      PNotify.notice(message);
      break;
    case 'success':
      PNotify.success(message);
      break;
    case 'info':
      PNotify.info(message);
      break;
    case 'error':
      PNotify.error(message);
      break;
    default:
      PNotify.notice(message);
  }
});

/* Notification Style */
Shiny.addCustomMessageHandler((type = 'ns.send'), function (message) {
  let notification = new NotificationFx(message);
  notification.show();
});

/* Tingle */
Shiny.addCustomMessageHandler((type = 'tingle.send'), function (message) {
  let tingleModal;

  if (message.footer) {
    tingleModal = new tingle.modal({ footer: message.footer });
    btnClass =
      'tingle-btn tingle-btn--' +
      message.btnType +
      ' tingle-btn--pull-' +
      message.btnPosition;
    tingleModal.addFooterBtn(message.btnLabel, btnClass, function () {
      tingleModal.close();
    });
  } else {
    tingleModal = new tingle.modal();
  }
  tingleModal.setContent(message.content);
  tingleModal.open();
});

/* Alertify */
Shiny.addCustomMessageHandler((type = 'alertify.alert'), function (message) {
  alertify
    .alert()
    .setting({
      title: message.title,
      message: message.message,
      autoReset: message.autoReset,
      closable: message.closable,
      frameless: message.frameless,
      maximiable: message.maximiable,
      modal: message.modal,
      movable: message.movable,
      moveBounded: message.moveBounded,
      overflow: message.overflow,
      padding: message.padding,
      pinnable: message.pinnable,
      resizeable: message.resizeable,
      startMaximized: message.startMaximized,
      transition: message.transition,
      transitionOff: message.transitionOff,
      onok: function () {},
    })
    .show();
});

Shiny.addCustomMessageHandler((type = 'alertify.notify'), function (message) {
  alertify.set('notifier', 'delay', message.delay);
  alertify.set('notifier', 'position', message.position);
  switch (message.type) {
    case 'success':
      alertify.success(message.message);
      break;
    case 'warning':
      alertify.warning(message.message);
      break;
    case 'error':
      alertify.error(message.message);
      break;
    case 'message':
      alertify.message(message.message);
      break;
    default:
      alertify.message(message.message);
  }
});

Shiny.addCustomMessageHandler((type = 'bootbox.send'), function (message) {
  bootbox.alert({
    title: message.title,
    message: message.message,
    size: message.size,
    onEscape: message.onEscape,
    show: message.show,
    backdrop: message.backdrop,
    closeButton: message.closeButton,
    animate: message.animate,
    className: message.className,
  });
});
