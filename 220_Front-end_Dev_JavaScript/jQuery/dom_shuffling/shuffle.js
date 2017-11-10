$(function() {
  var $header = $('body > header');
  var $figures = $('figure');

  $('body').prepend($header);
  $header.prepend($("main > h1"));

  $('article').append($figures);

  var $main = $('main');

  var $imgs = $('img');
  $figures.eq(0).prepend($imgs.eq(1));
  $figures.eq(1).prepend($imgs.eq(0));
});
