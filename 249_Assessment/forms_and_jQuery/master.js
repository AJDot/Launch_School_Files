function getFormObject($f) {
  var o = {};

  $f.serializeArray().forEach(function(input) {
    if (!o.hasOwnProperty(input.name)) {
      o[input.name] = input.value;
    } else if (typeof o[input.name] === "string") {
      o[input.name] = [o[input.name]];
      o[input.name].push(input.value);
    } else {
      o[input.name].push(input.value);
    }
  });

  return o;
}

$(function() {
  $f = $('form');
});
