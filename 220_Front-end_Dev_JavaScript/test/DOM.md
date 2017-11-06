# The DOM

3 Types of Nodes:
* Elements represent HTML tags
* Text nodes represent the text that appears in the document.
* Comment nodes represent the HTML comments.

****There are some other types that can be ignored for now.

The following isn't perfect but it is a starting to recursively mapping out the DOM into a big tree displayable on the page.

```javascript
function createTree(node) {
  var parent = node.parentNode;
  var ul = document.createElement("ul");
  var text = document.createTextNode(node.nodeName);
  ul.appendChild(text);
  for (var i = 0; i < node.childNodes.length; i++) {
    var child = node.childNodes[i];
    var li = document.createElement("li");
    li.appendChild(createTree(child));
    ul.appendChild(li);
  }

  return ul;
}


document.addEventListener("DOMContentLoaded", function() {
  document.body.appendChild(createTree(document.body));
});
```
