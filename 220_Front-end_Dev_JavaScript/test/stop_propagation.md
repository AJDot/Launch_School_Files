# Stop Propagation
## Without event.stopPropagation()
```html
<ul>
  This is ul
  <li>List item 1</li>
</ul>
```
```css
body * {
  margin: 10px;
  border: 2px dotted black;
}

body *:hover {
  border-style: solid;
}

.red {
  border-color: red;
}
```
```javascript
function turnRed(event) {
  var target = event.currentTarget;
  console.log(target.nodeName);
  target.classList.toggle("red");
}

document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("ul").addEventListener("click", turnRed);
  document.querySelector("li").addEventListener("click", turnRed);
});
```

Click on the list item and its border will turn red but the unordered list's border will also turn red. This is due to the event propagating through its parents up to the document.

To prevent the event firing from bubbling up through the currentTarget's parents, include `event.stopPropagation()` as soon as possible inside the `addEventListener` callback.
```javascript
function turnRed(event) {
  event.stopPropagation();
  var target = event.currentTarget;
  console.log(target.nodeName);
  target.classList.toggle("red");
}

document.addEventListener("DOMContentLoaded", function() {
  document.querySelector("ul").addEventListener("click", turnRed);
  document.querySelector("li").addEventListener("click", turnRed);
});
```
