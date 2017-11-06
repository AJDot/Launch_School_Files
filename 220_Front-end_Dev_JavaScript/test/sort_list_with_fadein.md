# Sort List with Fadein

It's messy but it works. It's not generalized but it works.

This code will sort the `li`s based on their number. Then I got a little carried away and barely implemented a way to have them fade in.
This fade in component utilizes the `setTimeout` function. Once to increment the opacity of a list element from `0` to `1` over a number of steps. Each step is delayed by a little more than the previous step. The second instance is to stagger the start of each `li` element fade in so all elements do not fade in at the same time. It's more of a waterfall effect this way.
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title></title>
    <style>
      body {
        font: normal 14px sans-serif;
      }

      ul {
        list-style-type: none;
        padding: 0;
        margin: 0;
        transition: all 1s ease;
      }

      li {
        border: 2px dotted black;
        padding: 10px;
        margin: 5px;
        opacity: 1;
        transition: all 1s ease;
      }

      button {
        display: block;
        width: 100%;
        padding: 10px;
        margin: 5px 0;
        outline: none;
        border: none;
        border-radius: 3px;
        color: white;
        background: #44dda0;
        box-shadow: 1px 1px 2px 0 rgba(0, 0, 0, 0.5);
        cursor: pointer;
        box-sizing: border-box;
      }

      button:active {
        box-shadow: none;
        transform: translateY(1px);
      }


    </style>
  </head>
  <body>
    <button type="button" name="button">Sort</button>
    <ul>
      <li>7. List Item</li>
      <li>2. List Item</li>
      <li>4. List Item</li>
      <li>8. List Item</li>
      <li>6. List Item</li>
      <li>5. List Item</li>
      <li>3. List Item</li>
      <li>9. List Item</li>
      <li>10. List Item</li>
      <li>1. List Item</li>
    </ul>
    <script>
      // Utilizes the partial function application technique
      // get the number at the beginning of the string
      function getNumberStart(text) {
        return parseInt(text.match(/^\d+/)[0], 10);
      }

      // general function to set the value of a numeric property
      function makeSetProperty(element, property, step) {
        return function() {
          element.style[property] = step.toString();
        }
      };

      function step(element, property, start, stop, steps) {
        element.style[property] = start;
        var range = stop - start;
        var stepSize = range / steps;
        var delay = 0;
        for (var i = start; i <= stop; i += stepSize) {
          var setProperty = makeSetProperty(element, property, i);
          setTimeout(setProperty, delay * .5);
          delay++;
        }
        setTimeout(function() {
          element.style[property] = stop;
        }, delay * .5);
      }

      function makeSortList(ul, callback) {
        return function(event) {
          sortListItems(event, ul, callback);
        };
      }

      function sortListItems(event, ul, callback) {
        var lis = ul.querySelectorAll("li");
        var lisArray = Array.prototype.slice.call(lis);

        var sorted = lisArray.sort(function(a, b) {
          var aNumber = getNumberStart(a.textContent);
          var bNumber = getNumberStart(b.textContent);
          return aNumber - bNumber;
        });

        sorted.forEach(function(li, index) {
          ul.appendChild(li);
          if (callback) {
            callback(li, index);
          }
        });

      }

      function fadein(li, index) {
        li.style.opacity = "0";
        setTimeout(function() {
          step(li, "opacity", 0, 1, 100);
        }, index * 100);
      }

      document.addEventListener("DOMContentLoaded", function() {
        var sortButton = document.querySelector("button");
        var ul = document.querySelector("ul");
        var sortList = makeSortList(ul, fadein);
        // var sortList = makeSortList(ul);

        sortButton.addEventListener("click", sortList);

      });
    </script>
  </body>
</html>
```
