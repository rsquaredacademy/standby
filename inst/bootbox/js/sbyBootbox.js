Shiny.addCustomMessageHandler((type = 'bootbox.send'), function (message) {
  // Bootbox's alert helper overwrites onEscape with its own OK callback, so
  // close_on_escape = FALSE had no effect. A dialog with an explicit OK button
  // keeps the requested Escape policy and the same single-button appearance.
  bootbox.dialog({
    title: message.title,
    message: message.message,
    size: message.size,
    onEscape: message.onEscape,
    show: message.show,
    backdrop: message.backdrop,
    closeButton: message.closeButton,
    animate: message.animate,
    className: message.className,
    buttons: {
      ok: {
        label: "OK",
        className: "btn-primary"
      }
    }
  });
});
