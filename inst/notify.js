Shiny.addCustomMessageHandler((type = 'pnotify-send'), function (message) {
  PNotify.notice(message);
});
