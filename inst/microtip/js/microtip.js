/* MicroTip */
Shiny.addCustomMessageHandler((type = 'tip.send'), function (message) {
  let selector = '#' + message.id;
  let el = document.querySelector(selector);
  el.setAttribute('aria-label', message.tip);
  el.setAttribute('data-microtip-position', message.position);
  el.setAttribute('role', 'tooltip');
  console.log(message.size);
  if (message.size !== null) {
    el.setAttribute('data-microtip-size', message.size);
  }
});
