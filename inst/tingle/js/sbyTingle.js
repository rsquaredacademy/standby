/* Tingle */
Shiny.addCustomMessageHandler((type = 'tingle.send'), function (message) {
  var tingleModal = new tingle.modal({
    footer: message.footer,
    onClose: function () { this.destroy(); }
  });

  if (message.footer) {
    var btnClass =
      'tingle-btn tingle-btn--' +
      message.btnType +
      ' tingle-btn--pull-' +
      message.btnPosition;
    tingleModal.addFooterBtn(message.btnLabel, btnClass, function () {
      tingleModal.close();
    });
  }
  tingleModal.setContent(message.content);
  tingleModal.open();
});
