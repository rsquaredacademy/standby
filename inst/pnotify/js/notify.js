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
