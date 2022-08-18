$(document).on('shiny:recalculating', function (event) {
  let id = '#' + event.target.id;
  let output = document.querySelector(id);
  let loader = $(output).siblings('.standby-wait')[0];
  output.style.visibility = 'hidden';
  loader.style.visibility = 'visible';
});

$(document).on('shiny:value shiny:error', function (event) {
  let id = '#' + event.target.id;
  let output = document.querySelector(id);
  let loader = $(output).siblings('.standby-wait')[0];
  output.style.visibility = 'visible';
  loader.style.visibility = 'hidden';
});
