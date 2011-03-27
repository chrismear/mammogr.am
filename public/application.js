$(document).ready(function () {
  $('div.flag a').click(function (event) {
    event.preventDefault();
    var postUrl = $(this).attr('href');
    var flagDiv = $(this).parent();
    var photoLi = $(this).parents('li');
    flagDiv.html('Flagging...');
    $.ajax({
      type: 'POST',
      url: postUrl,
      success: function () {
        flagDiv.html('Thanks.');
        window.setTimeout(function () {
          $(photoLi).fadeOut('fast', function () {
            $(this).remove();
          });
        }, 1000);
      }
    });
  });
  $('li').hoverIntent(function (event) {
    $(this).children('div.flag').show();
  },
  function (event) {
    var flag = $(this).children('div.flag');
    window.setTimeout(function () {flag.hide();}, 500);
  });
  
  $('#map li').each(function(index) {
    var element = $(this);
    element.css('left', Math.random() * 960 - 75).
      css('top', Math.random() * 485 - 85);
    window.setTimeout(function() {
      element.show('scale', {from: {height: 1, width: 1}, percent: 100}, 500);
      // Ought to be a CSS transition
    }, index * 1000 + Math.random() * 500);
  });
});
