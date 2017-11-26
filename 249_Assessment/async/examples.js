$(function() {
  //////////////////////////////////////
  // Example 1
  //////////////////////////////////////

  var $example1 = $('#example1');
  var $example1Ul = $example1.find('ul');
  var listItem = Handlebars.compile($('#listItem').html());

  function makeAppender(text) {
    return function() {
      $example1Ul.append(listItem({ item: text }));
    }
  }

  function delayLog(min, max) {
    var count = 1;
    for (var i = min; i <= max; i++) {
      var action = makeAppender(i);
      setTimeout(action, count * 500);
      count++;
    }
  }

  delayLog(1, 10);

  //////////////////////////////////////
  // Example 2
  //////////////////////////////////////

  var $example2 = $('#example2');
  var $example2Ul = $example2.find('ul');
  var listItem = Handlebars.compile($('#listItem').html());

  var count = 1;
  function appender(text) {
    $example2Ul.append(listItem({ item: text }));
    count++
  }

  var int = setInterval(function() {
    appender(count);
    if (count > 10) { clearInterval(int) ; }
  }, 500);

});
