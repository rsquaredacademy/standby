/* iziToast */
(function () {
  var queue = [];
  var active = new Set();
  var replacing = false;

  function showNow(message, method) {
    var options = Object.assign({}, message);
    var userOnOpening = options.onOpening;
    var userOnClosed = options.onClosed;
    options.onOpening = function (instance, element) {
      active.add(element);
      if (typeof userOnOpening === 'function') userOnOpening(instance, element);
    };
    options.onClosed = function (instance, element, closedBy) {
      // iziToast can call a replacement's callback for the outgoing element.
      // Account for actual live identities, once each, rather than callbacks.
      if (!active.delete(element)) return;
      if (typeof userOnClosed === 'function') {
        userOnClosed(instance, element, closedBy);
      }
      if (!replacing) {
        drain();
      }
    };
    // Modes 0 and 1 are implemented here; forwarding mode 1 to iziToast would
    // also apply its "once per generated id" rule and discard the new toast.
    if (options.displayMode === 0 || options.displayMode === '0' ||
        options.displayMode === 1 || options.displayMode === '1') {
      delete options.displayMode;
    }
    if (typeof method === 'string' && typeof iziToast[method] === 'function') {
      iziToast[method](options);
    } else {
      iziToast.show(options);
    }
  }

  function drain() {
    while (active.size === 0 && queue.length > 0) {
      var next = queue.shift();
      showNow(next.message, next.method);
    }
  }

  function replaceAll(message, method) {
    replacing = true;
    Array.prototype.slice.call(document.querySelectorAll('.iziToast'))
      .filter(function (el) {
        return !el.classList.contains('iziToast-closing');
      })
      .forEach(function (el) {
        iziToast.hide({}, el);
      });
    showNow(message, method);
    // Let the outgoing toasts finish their close animation before the queue
    // (which is intentionally held during the replacement) resumes.
    setTimeout(function () {
      replacing = false;
      drain();
    }, 1400);
  }

  function display(message, method) {
    // Documented semantics:
    //   0 - wait for the current toast to close
    //   1 - replace the displayed toast(s)
    //   2 - library behaviour: replace an identical toast only
    var mode = message.displayMode;
    if (mode === 0 || mode === '0' || mode === null || mode === undefined) {
      if (active.size > 0) {
        queue.push({ message: message, method: method });
      } else {
        showNow(message, method);
      }
    } else if (mode === 1 || mode === '1') {
      replaceAll(message, method);
    } else {
      showNow(message, method);
    }
  }

  Shiny.addCustomMessageHandler((type = 'toast.send'), function (message) {
    switch (message.type) {
      case 'info':
        display(message, 'info');
        break;
      case 'success':
        display(message, 'success');
        break;
      case 'warning':
        display(message, 'warning');
        break;
      case 'error':
        display(message, 'error');
        break;
      case 'question':
        display(message, 'question');
        break;
      default:
        display(message, 'show');
    }
  });
})();
