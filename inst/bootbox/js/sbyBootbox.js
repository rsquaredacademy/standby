Shiny.addCustomMessageHandler((type = 'bootbox.send'), function (message) {
  // Bootbox's alert helper overwrites onEscape with its own OK callback, so
  // close_on_escape = FALSE had no effect. A dialog with an explicit OK button
  // keeps the requested Escape policy and the same single-button appearance.
  var dialog = bootbox.dialog({
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
  // Bootstrap 3 (Shiny's default) does not define modal-xl.
  if (message.size === 'extra-large' && $.fn.modal &&
      /^3\./.test($.fn.modal.Constructor.VERSION)) {
    dialog.find('.modal-dialog').addClass('sby-modal-xl');
  }
});
