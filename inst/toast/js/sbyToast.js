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
