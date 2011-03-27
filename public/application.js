$(document).ready(function () {
  $('p.flag a').click(function (event) {
    event.preventDefault();
    var postUrl = $(this).attr('href');
    var flagP = $(this).parent();
    var photoLi = $(this).parents('li');
    flagP.html('Flagging...');
    $.ajax({
      type: 'POST',
      url: postUrl,
      success: function () {
        flagP.html('Thanks.');
        window.setTimeout(function () {
          $(photoLi).fadeOut('fast', function () {
            $(this).remove();
          });
        }, 1000);
      }
    });
  });
  $('li').hoverIntent(function (event) {
    for (var i = 0; i < 11; i++) {
      if ($(this).hasClass('rot' + i)) {
        $(this).data('prevRotClass', 'rot' + i);
        $(this).removeClass('rot' + i);
      }
    }
    $(this).addClass('expand');
    $(this).find('div.background').show();
    $(this).find('div.caption').show();
  },
  function (event) {
    $(this).removeClass('expand');
    $(this).addClass($(this).data('prevRotClass'));
    $(this).find('div.background').hide();
    $(this).find('div.caption').hide();
  });
  
  $('#map li').each(function(index) {
    var element = $(this);
    element.
      css('left', (element.data('longitude') + 180.0) * 960.0 / 360.0 - 80).
      css('top', (element.data('latitude') * -1.0 + 90.0) * 486.0 / 180.0 - 90);
    window.setTimeout(function() {
      // element.show('scale', {from: {height: 1, width: 1}, percent: 100}, 500);
      element.fadeIn();
      // Ought to be a CSS transition
    }, index * 1000 + Math.random() * 3000);
  });
});
