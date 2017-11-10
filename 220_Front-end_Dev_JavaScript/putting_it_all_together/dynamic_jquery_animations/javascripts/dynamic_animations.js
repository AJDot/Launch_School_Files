// LS Solution
$(function() {
  var $canvas = $('.canvas');

  function getFormObject($f) {
    var o = {};

    $f.serializeArray().forEach(function(input) {
      o[input.name] = input.value;
    });

    return o;
  }

  function createElement(data) {
    var $d = $("<div>", {
      "class": data.shape_type,
      data: data,
    });

    resetElement($d);

    return $d;
  }

  function animateElement() {
    var $e = $(this);
    var data = $e.data();

    resetElement($e);
    $e.animate({
      top: data.end_y + "px",
      left: data.end_x + "px",
    }, 1000);
  }

  function resetElement($e) {
    var data = $e.data();
    $e.css({
      top: data.start_y + "px",
      left: data.start_x + "px",
    });
  }

  function stopAnimations() {
    $canvas.find("div").stop();
  }

  $('form').on('submit', function(e) {
    e.preventDefault();

    var $f = $(this);
    var data = getFormObject($f);

    $canvas.append(createElement(data));

  });

  $('#start').on('click', function(e) {
    e.preventDefault();

    $canvas.find('div').each(animateElement);
  });

  $('#stop').on('click', function(e) {
    e.preventDefault();

    stopAnimations();
  })
});

// My Solution
// $(function() {
//   var $canvas = $('.canvas');
//   var positions = [];
//
//   $('form').on("submit", function(e) {
//     e.preventDefault();
//
//     var shape = $(":radio").filter(":checked").val();
//
//     var $newShape = $('<div>').addClass(shape);
//     $newShape.css({
//       top: $('[name="start_y"]').val() + "px",
//       left: $('[name="start_x"]').val() + "px",
//     });
//     $canvas.append($newShape);
//
//     positions.push({
//       start_x: $('[name="start_x"]').val() || "0",
//       start_y: $('[name="start_y"]').val() || "0",
//       end_x: $('[name="end_x"]').val() || "0",
//       end_y: $('[name="end_y"]').val() || "0",
//     })
//   });
//
//   $('#start').on("click", function(e) {
//     e.preventDefault();
//
//     $shapes = $('.canvas > div');
//     $shapes.each(function(i) {
//       $(this).css({
//         top: positions[i].start_y + "px",
//         left: positions[i].start_x + "px",
//       })
//       .animate({
//         top: positions[i].end_y + "px",
//         left: positions[i].end_x + "px",
//       }, 1000);
//     });
//   });
//
//   $('#stop').on("click", function(e) {
//     e.preventDefault();
//
//     $('.canvas > div').stop();
//   });
// });
