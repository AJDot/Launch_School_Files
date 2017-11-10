$(function() {
  var $closeLinks = $('.modal a');
  var $modals = $('.modal');

  $('#team li > a').on('click', function(e) {
    e.preventDefault();
    $e = $(this);

    var $siblings = $e.nextAll();
    $e.siblings(".modal").css({
      top: $(window).scrollTop() + 30,
    });

    $e.nextAll("div").fadeIn(400);
  });

  $(".modal_layer, a.close").on("click", function(e) {
    e.preventDefault();

    $(".modal_layer, .modal").filter(":visible").fadeOut(400);
  });

  $(document).on("keyup", function(e) {
    var escape = 27;
    if (e.which === escape) {
      $("a.close").eq(1).trigger("click");
    }
  });
});
