// Copyright 2011 Chris Mear.
// 
// This file is part of mammogr.am.
// 
// mammogr.am is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// mammogr.am is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Aggero General Public License for more details.
// 
// You should have received a copy of the GNU Affero General Public License
// along with mammogr.am.  If not, see <http://www.gnu.org/licenses/>.

var Mammogram = {
  latestShownIndex: 0,
  setPosition: function (element)
  {
    element = $(element);
    element.
      css('left', (element.data('longitude') + 180.0) * 960.0 / 360.0 - 80).
      css('top', (element.data('latitude') * -1.0 + 90.0) * 486.0 / 180.0 - 90);
  },
  fetchPhoto: function (callback)
  {
    $.ajax({
      type: 'GET',
      url: '/photos/random',
      dataType: 'html',
      success: function (data)
      {
        $('#map ul').append(data);
        callback();
      }
    });
  },
  showNext: function ()
  {
    if (Mammogram.latestShownIndex < $('#map li').length) {
      $($('#map li')[Mammogram.latestShownIndex]).fadeIn('fast');
      Mammogram.latestShownIndex += 1;
    } else {
      Mammogram.fetchPhoto(function ()
      {
        var oldPhoto = $($('#map li')[0]);
        var newPhoto = $($('#map li')[$('#map li').length - 1]);
        Mammogram.setPosition(newPhoto);
        oldPhoto.fadeOut('fast', function ()
        {
          oldPhoto.remove();
          newPhoto.fadeIn('fast');
        });
      });
    }
    window.setTimeout(Mammogram.showNext, 2000 + Math.random() * 2000);
  }
};

$(document).ready(function () {
  $('p.flag a').live('click', function (event) {
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
  
  $('li').live('mouseenter', function (event) {
    for (var i = 0; i < 11; i++) {
      if ($(this).hasClass('rot' + i)) {
        $(this).data('prevRotClass', 'rot' + i);
        $(this).removeClass('rot' + i);
      }
    }
    $(this).addClass('expand');
    $(this).find('div.background').show();
    $(this).find('div.caption').show();
  });
  $('li').live('mouseleave', function (event) {
    $(this).removeClass('expand');
    $(this).addClass($(this).data('prevRotClass'));
    $(this).find('div.background').hide();
    $(this).find('div.caption').hide();
  });
  
  $('#map li').each(function(index) {
    Mammogram.setPosition(this);
  });
  
  window.setTimeout(Mammogram.showNext, 2000 + Math.random() * 2000);
});
