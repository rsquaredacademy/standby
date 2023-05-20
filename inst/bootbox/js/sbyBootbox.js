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
