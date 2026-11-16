/* Show/hide the standby loader for an output.
   event.target is the output element itself, so no selector is built from its
   id: valid HTML ids such as "a.b" or "a:b" need not be valid CSS selectors. */
function standbyToggleLoader(event, showLoader) {
  var output = event.target;
  if (!output || !output.parentElement) {
    return;
  }
  var parent = output.parentElement;
  if (!parent.classList || !parent.classList.contains('standby')) {
    return;
  }
  var loader = $(output).siblings('.standby-wait')[0];
  if (!loader) {
    return;
  }
  if (showLoader) {
    parent.classList.add('full-screen');
    output.style.visibility = 'hidden';
    loader.style.visibility = 'visible';
  } else {
    parent.classList.remove('full-screen');
    output.style.visibility = 'visible';
    loader.style.visibility = 'hidden';
  }
}

$(document).on('shiny:recalculating', function (event) {
  standbyToggleLoader(event, true);
});

$(document).on('shiny:value shiny:error', function (event) {
  standbyToggleLoader(event, false);
});
