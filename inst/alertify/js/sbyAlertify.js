/* Alertify */
Shiny.addCustomMessageHandler((type = 'alertify.alert'), function (message) {
  var dialog = alertify
    .alert()
    .setting({
      title: message.title,
      message: message.message,
      label: message.label,
      autoReset: message.autoReset,
      closable: message.closable,
      frameless: message.frameless,
      maximizable: message.maximizable,
      modal: message.modal,
      movable: message.movable,
      moveBounded: message.moveBounded,
      overflow: message.overflow,
      padding: message.padding,
      pinnable: message.pinnable,
      resizable: message.resizeable,
      startMaximized: message.startMaximized,
      transition: message.transition,
      transitionOff: message.transitionOff,
      onok: function () {},
    })
    .show();

  // Give the dialog a defined type: a class plus a type-specific border and
  // header colour (see css/sbyAlertify.css).
  if (dialog && dialog.elements && dialog.elements.dialog) {
    var el = dialog.elements.dialog;
    var known = ['success', 'warning', 'error', 'message'];
    var dialogType = known.indexOf(message.type) === -1 ? 'message' : message.type;
    el.classList.add('sby-alert', 'sby-alert-' + dialogType);
  }
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
