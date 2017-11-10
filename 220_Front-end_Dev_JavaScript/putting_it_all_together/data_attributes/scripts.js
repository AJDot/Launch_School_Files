$(function() {
  $('a').on("click", function(e) {
    e.preventDefault();

    $('article').hide().filter('article[data-block=' + $(this).attr("data-block") + ']').show();
  });
});
