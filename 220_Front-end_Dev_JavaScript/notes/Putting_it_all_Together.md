# Putting it All Together
<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Putting it All Together](#putting-it-all-together)
  * [HTML Data Attributes](#html-data-attributes)

<!-- tocstop -->


## HTML Data Attributes
Attributes in HTML page for the purpose of the JavaScript. Example: want to switch visibility of tabs. This can create an association between the tab links and the blocks using HTML. In this way, if the tabs are reordered, the JavaScript will still display the right information.

Custom data attributes can be added to any HTML element for the sole purpose of storing data. They always start with `data-`.

In jQuery, this data can be read using `.attr()` or `.data()`. **NOTE:** `.data()` sets a key/value pair in an internal store for data on that DOM element. This is not the same as the HTML data attributes. Be careful.

Example:
```html
<a href="#" data-block="gold">Gold Sponsors</a>
```
```javascript
var $a = $('a[data-block=gold]');

console.log($a.attr('data-block')); // gold
console.log($a.data('block')); // gold

$a.data('block', 'silver');

console.log($a.attr('data-block')); // gold
console.log($a.data('block')); // silver
```

So use `.attr()` to get and set data attributes.
