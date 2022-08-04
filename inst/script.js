function detectLocation() {
  let byHeight = $('.wait').parent().height();
  let byWidth = $('.wait').parent().width();
  let loaderWidth = $('.wait').width();
  let loaderHeight = $('.wait').height();
  $('.wait').css('left', (byWidth - loaderWidth) / 2);
  $('.wait').css('top', (byHeight - loaderHeight) / 2);
}

// $(document).ready(function () {
//   let byHeight = $('.wait').parent().height();
//   let byWidth = $('.wait').parent().width();
//   let loaderWidth = $('.wait').width();
//   let loaderHeight = $('.wait').height();
//   $('.wait').css('left', (byWidth - loaderWidth) / 2);
//   $('.wait').css('top', (byHeight - loaderHeight) / 2);
// });

$(document).ready(detectLocation);
$(window).on('resize', detectLocation);

$(document).on('shiny:busy', function (event) {
  let allWait = $('.wait');
  $('.standby').find(allWait).css('visibility', 'visible');
});

$(document).on('shiny:idle', function (event) {
  let allWait = $('.wait');
  $('.standby').find(allWait).css('visibility', 'hidden');
});
