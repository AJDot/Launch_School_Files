$(function() {
  $blinds = $("[id^=blind]");
  var speed = 250;
  var delay = 500;

  function startAnimation(delay, speed) {
    $blinds.each(function(i) {
      var $blind = $blinds.eq(i);
      $blind.delay(delay * i + speed).animate({
        top: "+=" + $blind.height(),
        height: 0,
      }, speed);
    });
  }
  $("a").on("click", function(e) {
    e.preventDefault();

    $blinds.finish();
    $blinds.removeAttr("style");
    startAnimation(delay, speed);
  });

  startAnimation(delay, speed);
});
