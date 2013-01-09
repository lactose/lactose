var LACTOSE = LACTOSE || { };

(function() {
  var blackout = $('<div></div>'),
      children = [];


  function generateBars() {
    var $window = $(window),
        wh      = $window.height(),
        h       = Math.floor(wh/15),
        c       = 15,
        pos     = 0;
    do {
      var child = $('<div class="lac-black-bar"></div>').css('top', pos).hide();
      children.push(child);
      blackout.append(child);
      pos += h;
    } while(c--);
    $('body').append(blackout);
    var time = 100;
    $.each(children, function() {
      var c = $(this);
      (function(child) {
        setTimeout(function() {
          child.slideDown();
        }, time);
      })(c);
      time += 100;
    });
  }
  function homepageBlackOut() {

  }

  Linc.add('init', generateBars);
  //Linc.run({ all: true });

}).call(this);
