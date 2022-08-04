$(document).on('shiny:busy', function (event) {
  let allWait = $('.wait');
  let output = $('.standby').children().last()[0].id;
  let selector = '#' + output;
  $(selector).css('visibility', 'hidden');
  $('.standby').find(allWait).css('visibility', 'visible');
});

$(document).on('shiny:idle', function (event) {
  let allWait = $('.wait');
  let output = $('.standby').children().last()[0].id;
  let selector = '#' + output;
  $(selector).css('visibility', 'visible');
  $('.standby').find(allWait).css('visibility', 'hidden');
});
