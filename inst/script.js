$(document).on('shiny:busy', function (event) {
  let noman = [];

  document.querySelectorAll('.standby').forEach(function (item, index) {
    noman.push('#' + item.lastElementChild.id);
  });

  noman.map(function (item) {
    document.querySelector(item).style.visibility = 'hidden';
  });

  let allWait = $('.wait');
  $('.standby').find(allWait).css('visibility', 'visible');
});

$(document).on('shiny:idle', function (event) {
  let noman = [];
  document.querySelectorAll('.standby').forEach(function (item, index) {
    noman.push('#' + item.lastElementChild.id);
  });
  noman.map(function (item) {
    document.querySelector(item).style.visibility = 'visible';
  });

  let allWait = $('.wait');
  $('.standby').find(allWait).css('visibility', 'hidden');
});

// let noman = [];
// document.querySelectorAll('.standby').forEach(function (item, index) {
//   noman.push('#' + item.lastElementChild.id);
// });
// noman.map(function (item) {
//   document.querySelector(item).style.visibility = 'hidden';
// });
