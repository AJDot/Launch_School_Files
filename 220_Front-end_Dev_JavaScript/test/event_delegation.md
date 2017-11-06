# Event Delegation
Attach an event listener to any of the parents of the elements you want to target. Then "grab" the target in the event listener and do something with.

### When to use Event Delegation
When a project is small, initially bind event handlers directly to the elements. As the project grows, it may make sense to use delegation to reduce the number of listeners.

Example:
```css
li:hover {
  border-style: solid;
}

ul {
  list-style-type: none;
  padding: 0;
  margin: 0;
}

li {
  padding: 10px;
  margin: 0 0 10px 0;
  border: 2px dotted black;
  border-radius: 5px;
}

.red {
  border-color: red;
}
```
```html
<p>Nothing has yet to be clicked!</p>
<ul>
  <li>List item 1</li>
  <li>List item 2</li>
  <li>List item 3</li>
  <li>List item 4</li>
  <li>List item 5</li>
  <li>List item 6</li>
  <li>List item 7</li>
  <li>List item 8</li>
  <li>List item 9</li>
  <li>List item 10</li>
</ul>
```
```javascript
function turnRed(event) {
  event.stopPropagation();
  var target = event.target;
  var tag = target.tagName;
  if (tag === "LI") {
    console.log(target.nodeName);
    target.classList.toggle("red");
  }
}

function displayClickItem(event) {
  var target = event.target;
  var tag = target.tagName;
  if (tag === "LI") {
    var text = target.textContent;
    var p = document.querySelector('p');
    p.innerHTML = text + " was clicked!";
  }
}

document.addEventListener("DOMContentLoaded", function() {
  function clickAction(event) {
    turnRed(event);
    displayClickItem(event);
  }

  document.querySelector("ul").addEventListener("click", clickAction);
});
```
The event listener is attached to the `ul` element, NOT the individual `li` elements. The `li` elements get manipulated because we can select the `target` of the `event` which is the inner-most element that allowed that event to trigger.

This is a great technique because it can severely reduce the number of listeners.
This is not so great of a technique because it can cause the event listener to become much more complicated.
Example:
```css
a.red-highlight {
  color: red;
}
```
```javascript
function turnRed(event) {
  event.stopPropagation();
  var target = event.target;
  var tag = target.tagName;
  if (tag === "LI") {
    target.classList.toggle("red");
  } else if (tag === "A") {
    event.preventDefault();
    target.classList.toggle("red-highlight");
  }
}

document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("ul").addEventListener("click", turnRed);
});
```

Now we have the ability to click the `li` elements to turn their borders red or we can specifically click the `a` elements to turn their color `red`. Since the event listener is on the parent of all these elements, we have to figure out the tag of the target first, then we can execute the appropriate action.
