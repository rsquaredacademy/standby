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
