/* MicroTip */
Shiny.addCustomMessageHandler((type = 'tip.send'), function (message) {
  if (!message || message.id === null || message.id === undefined) {
    return;
  }
  // Use the literal id: HTML ids are not necessarily valid CSS selectors.
  var el = document.getElementById(String(message.id));
  if (!el) {
    return;
  }
  el.setAttribute('aria-label', message.tip);
  el.setAttribute('data-microtip-position', message.position);
  el.setAttribute('role', 'tooltip');
  if (message.size === null || message.size === undefined ||
      message.size === '' || message.size === 'fit') {
    // No fixed size: fall back to MicroTip's fit-to-text behaviour.
    el.removeAttribute('data-microtip-size');
  } else {
    el.setAttribute('data-microtip-size', message.size);
  }
});
