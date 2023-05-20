/* Tingle */
Shiny.addCustomMessageHandler((type = 'tingle.send'), function (message) {
  let tingleModal;

  if (message.footer) {
    tingleModal = new tingle.modal({ footer: message.footer });
    btnClass =
      'tingle-btn tingle-btn--' +
      message.btnType +
      ' tingle-btn--pull-' +
      message.btnPosition;
    tingleModal.addFooterBtn(message.btnLabel, btnClass, function () {
      tingleModal.close();
    });
  } else {
    tingleModal = new tingle.modal();
  }
  tingleModal.setContent(message.content);
  tingleModal.open();
});
