# DOM Properties and Methods
## nodeType
| Constant | Value | Description |
| --- | --- | --- |
| `Node.ELEMENT_NODE` | 1 | An Element representing an HTML tag |
| `Node.TEXT_NODE` | 3 | A Text node |
| `Node.COMMENT_NODE` | 8 | A Comment node |
| `Node.DOCUMENT_NODE` | 9 | A Document node |

## nodeValue
## textContent
## toString()
## instanceof

## Traversing DOM
| Parent Node Properties | Value |
| --- | --- |
| `firstChild` | `childNodes[0]` or `null` |
| `lastChild` | `childNodes[childNodes.length - 1]` or `null` |
| `childNodes` | *Live collection of all child nodes` |

```javascript
function walk(node) {
  console.log(node.nodeName);                         // do something with node
  for (var i = 0; i < node.childNodes.length; i++) {  // for each child node
    walk(node.childNodes[i]);                         // recursively call walk()
  }
}
walk(document.body);                                  // log nodeName of every node
```

| Method | Description | Returns |
| --- | --- | --- |
| `getAttribute(name)` | Retrieve value of attribute `name` | Value of attribute as String |
| `setAttribute(name, newValue)` | Set value of attribute `name` to `newValue` | `undefined` |
| `hasAttribute(name)` | Check whether element has attribute `name` | `true` or `false` |

`getAttribute()` and `setAttribute()` work for *all* attributes but some can be accessed in another way.

Most browsers have the `classList` property. It references an Array-like `DOMTokenList` object with these properties and methods:
| Name | Description |
| --- | --- |
| `add(name)` | Add class `name` to element |
| `remove(name)` | Remove class `name` from element |
| `toggle(name)` | Add class `name` to element if it doesn't exist, remove if it does exist. |
| `contains(name)` | Return `true` or `false` depending on whether element has class `name`. |
| `length` | The number of classes to which element belongs. |

| Method | Returns |
| --- | --- |
| `document.getElementById(id)` | Element with given `id` |

| Method | Returns |
| --- | --- |
| `document.getElementsByTagName(tagName)` | `HTMLCollection` or `NodeList` of matching Elements |
| `document.getElementsByClassName(className)` | `HTMLCollection` or `NodeList` of matching Elements |

| Method | Returns |
| --- | --- |
| `document.querySelector(selector)` | First matching Element or `null` |
| `document.querySelectorAll(selector)` | `NodeList` of matching Elements |

| Parent Element Properties | Value |
| --- | --- |
| `firstElementChild` | `children[0]` or null |
| `lastElementChild` | `children[children.length-1]` or null |
| `children` | *Live collection* of all child elements |
| `childElementCount` | `children.length` |

| Child Element Properties | Value |
| --- | --- |
| `nextElementSibling` | `parentNode.children[n+1]` or `null` |
| `previousElementSibling` | `parentNode.children[n-1]` or `null` |

| Node Creation Method | Returns |
| --- | --- |
| `document.createElement(tagName)` | A new Element node |
| `document.createTextNode(text)` | A new Text node |
| `node.cloneNode(deepClone)` | Returns a copy of `node` |

| Parent Node Method | Description |
| --- | --- |
| `parent.appendChild(node)` | Append node to the end of `parent.childNodes` |
| `parent.insertBefore(node, targetNode)` | Insert `node` into `parent.childNodes` before `targetNode` |
| `parent.replaceChild(node, targetNode)` | Remove `targetNode` from `parent.childNodes` and insert `node` at its former position |

| Element Insertion Method | Description |
| --- | --- |
| `element.insertAdjacentElement(position, newElement)` | Inserts `newElement` at `position` relative to `element` |
| `element.insertAdjacentText(position, text)` | Inserts Text Node that contains `text` at `position` relative to `element` |

| Position | Description |
| --- | --- |
| `"beforebegin"` | Before the element |
| `"afterbegin"` | Before the first child of the element |
| `"beforeend"` | After the last child of the element |
| `"afterend"` | After the element |
