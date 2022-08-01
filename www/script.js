$(document).on('shiny:busy', function (event) {
  let waiter = document.querySelector('.wait');
  waiter.style.visibility = 'visible';
});

$(document).on('shiny:idle', function (event) {
  let waiter = document.querySelector('.wait');
  waiter.style.visibility = 'hidden';
});
