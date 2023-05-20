/* Notification Style */
Shiny.addCustomMessageHandler((type = 'ns.send'), function (message) {
  let notification = new NotificationFx(message);
  notification.show();
});
