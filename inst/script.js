$(document).on('shiny:busy', function (event) {
  let allWait = $('.wait');
  $('.standby').find(allWait).css('visibility', 'visible');
});

$(document).on('shiny:idle', function (event) {
  let allWait = $('.wait');
  $('.standby').find(allWait).css('visibility', 'hidden');
});
