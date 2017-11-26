# jQuery

<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [jQuery](#jquery)
  * [Introduction to jQuery](#introduction-to-jquery)
  * [jQuery Events](#jquery-events)
  * [jQuery DOM Traversal](#jquery-dom-traversal)
  * [Practice Problems: jQuery Events](#practice-problems-jquery-events)

<!-- tocstop -->
Douglas Crockford Lecture: The Metamorphosis of Ajax => [Link](https://www.youtube.com/watch?v=Fv9qT9joc0M)

## Introduction to jQuery

The primary role of jQuery is to make browser support universal so JavaScript works with all browsers.

Most of jQuery acts on DOM elements so the page must load before action is taken.
```javascript
$(document).ready(function() {
  // DOM loaded and ready, img tags not ready
});
```

To wait for images to load use this:
```javascript
$(window).load(function() {
  // DOM loaded and ready, img tags loaded and ready
});
```

The traversing the document and binding can be done by the `ready` event itself:
```javascript
$(function() {
  // DOM is now loaded
});
```

**The argument of the jQuery function:**
If it's a string or DOM element, it will be wrapped in a collection of jQuery objects and returns them. If it's a function, it will be the callback after the document is ready.

`jQuery` and `$` are the same thing.
```javascript
var $content = jQuery('#content');
var $sameContent = $('#content');
```

Example:
Ways to change and access CSS
```javascript
$content.css('font-size'));           // getter for font-size
$content.css('font-size', '18px'));   // setter for font-size

// Set multiple properties
$content.css('font-size', '18px').css('color', '#b00b00');


// Better way to set multiple properties
$content.css({
  'font-size': '18px',
  color: '#b00b00'
});
```

**Note:** Any hyphenated property needs quotes or else it will be interpreted as subtraction. camelCase can also be used.
```javascript
$content.css({
  fontSize: '18px',
  color: '#b00b00'
});
```

## jQuery Events
Example:

A Click Handler for Links
```html
<ul>
  <li><a href="#">Apples</a></li>
  <li><a href="#">Bananas</a></li>
  <li><a href="#">Oranges</a></li>
</ul>

<form action="#" method="post">
  <fieldset>
    <input type="text" />
    <input type="submit" value="Choose" />
  </fieldset>
</form>

<p>Choose your favorite fruit!</p>
```
```javascript
$(function() {
  // find the paragraph on the page
  var $p = $('p');
  var OUTPUT = 'Your favorite fruit is ';

  $('a').on('click', function(e) {
//$('a').click(function(e) {
    e.preventDefault();
    // make clicked DOM element into jQuery object
    var $e = $(this);
    // Update paragraph text to be text of clicked link
    $p.text(OUTPUT + $e.text());
  });

  $('form').on('submit', function(e) {
//$('form').submit(function(e) {
    e.preventDefault();
    // get input and store as jQuery object
    var $input = $(this).find('input[type=text]');
    // update paragraph text with value from input
    $p.text(OUTPUT + $input.val());
  });
});
```

## jQuery DOM Traversal
| Method | Returns |
| --- | --- |
| `parent(selector)` | jQuery of parent DOM element selector matches |
| `closest(selector)` | jQuery of closest DOM element that matches selector |
| `children()` | jQuery of children of element |
| `nextAll()` | grab all siblings that come after the element |
| `prevall()` | grab all siblings that precede the element |

## Practice Problems: jQuery Events
```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title></title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  </head>
  <body>
    <form action="#" method="post">
      <fieldset>
        <input type="text" id="key" maxlength="1" />
        <input type="submit" value="Submit">
      </fieldset>
    </form>
    <a href="#">Toggle</a>
    <div id="accordion">
      <p>Text in a paragraph.</p>
    </div>

    <script>
      $(function() {
        $('form').on('click', function(e) {
          e.preventDefault();
          var key = $('#key').val();
          var character_code = key.charCodeAt(0);

          $(document).off('keypress').on('keypress', function(e) {
            if (e.which !== character_code) { return; }
            $('a').trigger('click');
          });

        });

        $('a').on('click', function(e) {
          e.preventDefault();
          $('#accordion').slideToggle();
        })
      })
    </script>
  </body>
</html>
```
