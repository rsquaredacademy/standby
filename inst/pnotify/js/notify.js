/* PNotify */
// A single delegated listener works even while the notice passes events through
// and does not retain notices after PNotify removes them.
document.addEventListener('mousemove', function (event) {
  document.querySelectorAll('.pnotify.sby-nonblocking').forEach(function (notice) {
    var rect = notice.getBoundingClientRect();
    notice.classList.toggle('sby-nonblock-hover',
      event.clientX >= rect.left && event.clientX <= rect.right &&
      event.clientY >= rect.top && event.clientY <= rect.bottom);
  });
});
Shiny.addCustomMessageHandler((type = 'notify.send'), function (message) {
  switch (message.type) {
    case 'notice':
      PNotify.notice(message);
      break;
    case 'success':
      PNotify.success(message);
      break;
    case 'info':
      PNotify.info(message);
      break;
    case 'error':
      PNotify.error(message);
      break;
    default:
      PNotify.notice(message);
  }
});
