# setInterval
This code adds an event listener to `document` so that whenever `document` is clicked it will toggle adding list items to the `ul`.
#### HTML
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title></title>
  </head>
  <body>
    <ul>
    </ul>
  </body>
</html>
```
#### CSS
```css
ul {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

li {
  display: inline-block;
  width: 150px;
  padding: 10px;
  margin: 0 0 10px 0;
  border: 2px dotted black;
  border-radius: 5px;
}

.red {
  border-color: red;
}

a.red-highlight {
  color: red;
}
```
#### JS
```javascript
function addLi(ul) {
  var li = document.createElement("li");
  ul.appendChild(li);
  return li;
}

function makeAddLi(ul, i) {
  return function() {
    addLi(ul).textContent = i + ". This is a test.";
  }
}

var int;
var i = 1;
function listInterval() {
  var ul = document.querySelector("ul");
  int = setInterval(function() {
    var addListItem = makeAddLi(ul, i);
    addListItem();
    i++;
  }, 500);
}

function toggleListInterval() {
  if (int) {
    clearInterval(int);
    int = null;
  } else {
    listInterval();
  }
}

document.addEventListener("DOMContentLoaded", function() {
  document.addEventListener("click", toggleListInterval)
});
```
