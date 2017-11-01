# The DOM
## The Document Object Model (DOM)
It is an in-memory object representation of an HTMl document. It is a way to interact with a web page using JS for interactive experiences.

## A Hierarchy of Nodes
That's the DOM - a tree structure of nodes built from the structure of the HTML source. In addition to the nodes that represent the HTML tags there are two others.
* Elements represent HTML tags
* Text nodes represent text that appears in the Document (some are **empty nodes**)
* Comments represent the HTML comments.

Empty nodes are present all over the HTML. For example, the space between a `</h1>` and `<p>` tags creates an empty text node of a newline and 2 space characters. These can lead to **bugs**.
> **What about DOM Levels?**
>
> "DOM Levels" (e.g. "DOM Level 1") are W3 standards specifications that define the DOM features that browsers should support. You may encounter references to specific DOM Levels when researching the DOM, but you don't need to remember this information. It's more important to know which features are available in modern browsers. For this, use the browser compatibility tables at the bottom of the MDN pages.

### Problems
1. True or False: there is a direct one-to-one mapping between the tags that appear in an HTML file and the nodes in the DOM.
Answer: false. The browser can insert nodes into invalid markup. Text and whitespace also create nodes that don't map to tags.


2. True or False: Text nodes sometimes contain nothing but whitespace.
Answer: True


3. Given the HTML shown below, draw the DOM that the browser will construct when it loads the HTML. Determine which nodes are:

* elements,
* text nodes with nothing but whitespace
* text nodes containing text,
* or comments.
```html
<html>
  <head>
    <title>Newsletter Signup</title>
  </head>
  <body>
    <!-- A short comment -->
    <h1>Newsletter Signup</h1>
    <p class="intro" id="simple">
      To receive our weekly emails, enter your email address below.
      <a href="info.html">Get more info</a>.
    </p>
    <div class="form">
      <form>
        <label>
          Enter your email:
          <input name="email" placeholder="user.name@domain.test"/>
        </label>
        <p class="controls">
          <button id="cancelButton">Cancel</button>
          <button type="submit" id="submitButton">Subscribe</button>
        </p>
      </form>
    </div>
  </body>
</html>
```
Answer:
* HTML
  * HEAD
    * #text (empty)
    * TITLE
      * text "Newsletter Signup"
    * #text (empty)
  * #text (empty)
  * BODY
    * #text (empty)
    * #comment
    * #text (empty)
    * H1
      * #text "Newsletter Signup"
    * #text (empty)
    * P
      * #text "To receive our weekly emails, enter your email address below."
      * a
        * #text "Get more info"
      * #text "."
    * #text (empty)
    * DIV
      * #text (empty)
      * FORM
        * #text (empty)
        * LABEL
          * #text "Enter your email:"
          * INPUT
          * #text (empty)
        * #text (empty)
        * P
          * #text (empty)
          * BUTTON
            * #text "Cancel"
          * #text (empty)
          * BUTTON
            * #text "Subscribe"
          * #text (empty)
        * #text (empty)
      * #text (empty)
    * #text (empty)

[Link to DOM Visualizer](https://dom-viewer.herokuapp.com/index.html)

## Node Properties
In the developer tools in the browser, use `querySelector()` to get a reference to one of the DOM nodes. It returns the first node that matches the specified CSS selector. Need a node to call this method on.

The `document` node represents the entire HTML document and can be used as the top-most DOM node.

To find the first paragraph tag...
```javascript
> document.querySelector("p")
= <p class="intro" id="simple">...</p>
```

This reference can be stored in a variable.
```javascript
> var p = document.querySelector("p")
```

### Node Properties
#### nodeName
Contains a string the represents the node type.
```javascript
> p.nodeName
= "P"
```
`#text` for text nodes and `#comment` for comments.

#### nodeType
Returns a number that matches a node type constant.

| Constant | Value | Description |
| --- | --- | --- |
| `Node.ELEMENT_NODE` | 1 | An Element representing an HTML tag |
| `Node.TEXT_NODE` | 3 | A Text node |
| `Node.COMMENT_NODE` | 8 | A Comment node |
| `Node.DOCUMENT_NODE` | 9 | A Document node |

Use the constant names instead of numbers to make code clear.
```javascript
> p.nodeType === Node.ELEMENT_NODE
= true
> document.nodeTYPE === Node.DOCUMENT_NODE
= true
```

#### nodeValue
References the value of a node. Element nodes don't have values.
```javascript
> p.nodeValue
= null
```
Text nodes do.
```javascript
> var t = p.childNodes[0];
> t.nodeName;
= "#text"
> t.toString();
= "[object Text]"
> t.nodeValue
= "To receive our weekly emails, enter your email address below. "
```

#### textContent
Use `textContent` if you need the text within an Element. It is like `nodeValue` for all the Element's child nodes concatenated into a single String.
```javascript
> document.querySelector("p").textContent
= "
      To receive our weekly emails, enter your email address below.
      Get more info.
    "
```
The empty nodes are the cause of all the whitespace.

## Determining the Type of a Node
### Nodes and Elements
* **All** DOM objects are nodes.
* **All** DOM objects have a type that inherits from Node, which means they all have properties and methods they inherit from Node.
* The most common DOM object types you will use are **Element** and **Text**.

It's a hierarchy. Here's a partial list.

* EventTarget
  * Node
    * Text
    * Comment
    * Element
      * HTMLElement
        * HTMLAnchorElement
        * HTMLBodyElement
        * HTMLButtonElement
        * etc, etc.
      * SVGElement
      * SVGColorElement
      * SVGRectElement
      * etc, etc.

About the different types:
> * EventTarget provides the event-handling behavior that supports interactive web applications. We'll study this in detail in an upcoming lesson.
> * Node provides common behavior to all nodes.
> * Text and Element are the chief subtypes of Node.
>   * Text nodes hold text.
>   * Element nodes represent HTML tags.
> * Most HTML tags map to specific element subtypes that inherit from HTMLElement.
> * Other element types exist, such as SVGElement and its subtypes.

### Determining the Node Type

There are two useful ways to determine node type. One is best in interactive console, the other is best while programming.

#### In the console:
```javascript
> p.toString();
< "[object HTMLParagraphElement]"
```
Most nodes return the same thing for `toString()` and `String` but not all.
```javascript
> var a = document.querySelector('a');
> a
< <a href="http://domain.com/page">...</a>
> a.toString();
< "http://domain.com/page"
```

A workaround for this inconsistent behavior is to use the Node's `constructor`. It references a function that creates Objects of the appropriate Element type. **This is browser-dependent** so be careful with its return value.

### From Code
Use `instanceof` function or `tagName` property.
```javascript
> var p = document.querySelector('p');
> p instanceof HTMLParagraphElement;
< true
> p instanceof HTMLAnchorElement;
< false
> p instanceof Element;
< true
```
Downside is you have to test against multiple types to find the right match. If you just need to know if it is an Element, use `instanceof Element`.
Use this if you need to process 2 or more Element types in different ways.

Use `tagName` if all you need is the HTML tag name instead. (Remember it returns an uppercase value.)
```javascript
> p.tagNmae
< "P"
```

## Inheritance and Finding Documentation
Search for "mdn" + whatever type of element it is (like `HTMLParagraphElement`).
Inheritance tree is displayed on the left.
`HTMLElement` will contain most of the things needed for interacting with a web page.
Browser Compatibility Table is at the bottom.

## Traversing Nodes
Example: `childNodes` property returns a collection of nodes directly beneath the given node.
Example: Each element in the return collection has a `parentNode`

| Parent Node Properties | Value |
| --- | --- |
| `firstChild` | `childNodes[0]` or `null` |
| `lastChild` | `childNodes[childNodes.length - 1]` or `null` |
| `childNodes` | *Live collection of all child nodes` |

> A *live collection* automatically updates to reflect changes in the DOM.

| Child Node Properties | Value |
| --- | --- |
| `nextSibling` | `parentNode.childNodes[n+1]` or null |
| `previousSibling` | `parentNode.childNodes[n-1]` or null |
| `parentNode` | Immediate parent of this node |

### Walking the Tree
Visiting every node that has a child, grandchild, etc. relationship with a given node, and doing something with each of them. **Recursive** function is used for this.

```javascript
function walk(node) {
  console.log(node.nodeName);                         // do something with node
  for (var i = 0; i < node.childNodes.length; i++) {  // for each child node
    walk(node.childNodes[i]);                         // recursively call walk()
  }
}
walk(document.body);                                  // log nodeName of every node
```

This function both walks the DOM and does something with it. To allow any action to be taken, introduce a "callback" function.
```javascript
function walk(node, callback) {
  callback(node);                                     // do something with node
  for (var i = 0; i < node.childNodes.length; i++) {  // for each child node
    walk(node.childNodes[i], callback);               // recursively call walk()
  }
}
walk(document.body, function(node) {                  // log nodeName of every node
  console.log(node.nodeName);
});
```

Now `walk` is a general-purpose, higher-level Function useful in any application. (Analogous to `Array.prototype.forEach` but for DOM nodes, not arrays.)

## Element Attributes
### Getting and Setting Attributes
```javascript
> var p = document.querySelector("p")
> p;
= <p class="intro" id="simple">...</p>
```
| Method | Description | Returns |
| --- | --- | --- |
| `getAttribute(name)` | Retrieve value of attribute `name` | Value of attribute as String |
| `setAttribute(name, newValue)` | Set value of attribute `name` to `newValue` | `undefined` |
| `hasAttribute(name)` | Check whether element has attribute `name` | `true` or `false` |

### Attribute Properties
`getAttribute()` and `setAttribute()` work for *all* attributes but some can be accessed in another way.

`id`, `name`, `title`, and `value` can be set using standard property access and assignment operations.
```javascript
> p;
= <p class="intro" id="simple">...</p>
> p.id
= "simple"
> p.id = "complex"
> p;
= <p class="intro" id="complex">...</p>
```
For the `class` attribute, use `className` (since `class` is a JavaScript reserved word)

### classList
`className` will return one space-delimited string of all the classes of that node. Because of this there would be several steps needed to change one class of a node.

Most browsers have the `classList` property. It references an Array-like `DOMTokenList` object with these properties and methods:
| Name | Description |
| --- | --- |
| `add(name)` | Add class `name` to element |
| `remove(name)` | Remove class `name` from element |
| `toggle(name)` | Add class `name` to element if it doesn't exist, remove if it does exist. |
| `contains(name)` | Return `true` or `false` depending on whether element has class `name`. |
| `length` | The number of classes to which element belongs. |

### style
Element nodes have a `style` attribute that references a `CSSStyleDeclaration` Object.
It can be used like this:
```javascript
> h1.style.color = 'red';
> h1.style.color = null;
> h1.style.lineHeight = '3em';      // when CSS property names contain dashes use camelCase
```

> Most applications don't use the `style` property often; it's easier and more manageable to use classes in your stylesheet to alter the characteristics of your elements. You can add or remove CSS class names to or from any DOM Element.

## Practice Problems: Traversing and Accessing Attributes
Use the following HTML to solve these practice problems:
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>On the River</title>
  </head>
  <body>
    <h1>On the River</h1>
    <p>A poem by Paul Laurence Dunbar</p>

    <p>
      The sun is low,<br>
      The waters flow,<br>
      My boat is dancing to and fro.<br>
      The eve is still,<br>
      Yet from the hill<br>
      The killdeer echoes loud and shrill.
    </p>
    <p>
      The paddles plash,<br>
      The wavelets dash,<br>
      We see the summer lightning flash;<br>
      While now and then,<br>
      In marsh and fen<br>
      Too muddy for the feet of men,
    </p>
    <p>
      Where neither bird<br>
      Nor beast has stirred,<br>
      The spotted bullfrog's croak is heard.<br>
      The wind is high,<br>
      The grasses sigh,<br>
      The sluggish stream goes sobbing by.
    </p>
    <p>
      And far away<br>
      The dying day<br>
      Has cast its last effulgent ray;<br>
      While on the land<br>
      The shadows stand<br>
      Proclaiming that the eve's at hand.
    </p>
  </body>
</html>
```
You may use the `walk` Function we looked at earlier:
```javascript
function walk(node, callback) {
  callback(node);

  for (var i = 0; i < node.childNodes.length; i++) {
    walk(node.childNodes[i], callback);
  }
}
```
You may also use any DOM traversal methods we've discussed so far except `querySelector` and `querySelectorAll`.

---

1. Starting with the `document` node, use the `lastChild` and `childNodes` properties to change the text color to red on the `On the River` heading and set its font size 48 pixels.

Answer:
```javascript
var html = document.childNodes[1];  // skip doctype
var body = html.lastChild;          // skip head and text nodes
var heading = body.childNodes[1];   // skip text node
heading.style.color = "red";
heading.style.fontSize = "48px";
```

2. Count and log the paragraphs on the page.

Answer:
```javascript
var count = 0;
walk(document, function(node) {
  if (node instanceof HTMLParagraphElement) {
    count += 1;
  }
});
// OR
walk(document, function(node) {
  if (node.nodeName === "P") {
    count++;
  }
});

console.log(pCount);
```

3. Retrieve the first word from each paragraph on the page and log the entire list.
```javascript
var words = [];
walk(document, function(node) {
  if (node.nodeName === "P") {
    var text = node.firstChild.data.trim();
    var firstWord = text.split(" ")[0];
    words.push(firstWord);
  }
});
console.log(words);
```

4. Add the class `stanza` to each paragraph *except* the first.
```javascript
walk(document, function(node) {
  if (node.nodeName === "P" && node.previousSibling.previousSibling.nodeName === "P") {
    node.classList.add("stanza");
  }
});
// OR
var first = true;
walk(document, function(node) {
  if (node.nodeName === "P") {
    if (first) {
      first = false;
    } else {
      node.classList.add("stanza");
    }
  }
});
```

NOTE: For the remaining practice problems, please use this Wikipedia page.

To test your code, download the page using "Save Page As" or "Save Page" in your browser, then edit the HTML file to insert your JavaScript. Note that some text editors may take a long time to load the HTML.

---

5. Count the images on the page, then count the PNG images. Log both results.
```javascript
var images = [];
walk(document, function(node) {
  if (node.nodeName === "IMG") {
    images.push(node);
  }
});

console.log(images.length);

var pngCount = images.filter(function(i) {
  return i.getAttribute("src").match(/png$/);
  }).length;

console.log(pngCount);
```

6. Change the link color to red for every link on the page.
```javascript
walk(document, function(node) {
  if (node.nodeName === "A") {
    node.style.color = "red";
  }
});
```

## Finding DOM Nodes
### Finding An Element By Id
`getElementById` is used for this.
| Method | Returns |
| --- | --- |
| `document.getElementById(id)` | Element with given `id` |

This method works well if you want to find a single item on the page. However, usually pages are easier to maintain if the application is structured to find all matching elements instead of one.

### Finding More Than One Element
#### Problems Group 1
1. Write a JavaScript Function that returns the `p` Elements in this DOM represented by this HTML:
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>On the River</title>
  </head>
  <body>
    <h1>On The River</h1>
    <p>The sun is low</p>
    <p>The waters flow</p>
  </body>
</html>
```
```javascript
function findAllParagraphs() {
  var matches = [];
  var nodes = document.body.childNodes;

  for (var i = 0; i < nodes.length; i++) {
    if (nodes[i] instanceof HTMLParagraphElement) {
      matches.push(nodes[i]);
    }
  }

  return matches;
}

console.log(findAllParagraphs());
```

2. Write a JavaScript Function that adds the CSS class "article-text" to every <p> tag in this HTML:
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>On the River</title>
  </head>
  <body>
    <div id="page1">
      <div class="intro">
        <p>The sun is low,</p>
      </div>
      <p>The waters flow,</p>
    </div>
    <div id="page2">
      <div class="intro">
        <p>My boat is dancing to and fro.</p>
      </div>
      <p>The eve is still,</p>
    </div>
    <div id="page3">
      <div class="intro">
        <p>Yet from the hill</p>
      </div>
      <p>The killdeer echoes loud and shrill.</p>
    </div>
  </body>
</html>
```
```javascript
function addClassToParagraphs(node) {
  if (node instanceof HTMLParagraphElement) {
    node.classList.add("article-text");
  }

  var nodes = node.childNodes;
  for (var i = 0; i < nodes.length; i++) {
    addClassToParagraphs(nodes[i]);
  }
}

addClassToParagraphs(document.body)
```

3. The solution to the previous problem does everything in one Function. It works, but if we need to perform a similar operation later, we must write most of the same code again. We can do better by rethinking the problem.

You can think of the problem as having two primary operations: find all the p Elements, and then add a class to each of them. We can structure our code similarly; this makes the code's intent clearer to other developers and increases the reusability of the components.

Using this task breakdown, rewrite the solution to the first problem. The core of your solution should be a Function named getElementsByTagName that returns an Array of all Elements with a given tag name. You should then add the CSS class article-text to each paragraph in the Array.

```javascript
function getElementsByTagName(tagName) {
  var matches = [];

  walk(document.body, function(node) {
    if (node.nodeName.toLowerCase() === tagName) {
      matches.push(node);
    }
  });

  return matches;
}

getElementsByTagName("p").forEach(function(paragraph) {
  paragraph.classList.add("article-text");
});
```

### Built-In Functions
| Method | Returns |
| --- | --- |
| `document.getElementsByTagName(tagName)` | `HTMLCollection` or `NodeList` of matching Elements |
| `document.getElementsByClassName(className)` | `HTMLCollection` or `NodeList` of matching Elements |

The difference with these is that they return Array-like objects, not Arrays.
They **do not support** `forEach` and other Array methods. To use those methods. use a `for` loop or convert the object into an Array and then use the higher-order Array functions.
```javascript
var paragraphs = document.getElementsByTagName("p");

// Fix # 1
var paragraphsArray = Array.prototype.slice.call(paragraphs);
paragraphsArray.forEach(function(paragraph) {
  console.log(paragraph.textContent);
})

// Fix # 2
for (var i = 0; i < paragraphs.length; i++) {
  var paragraph = paragraphs[i];
  console.log(paragraph.textContent);
}
```

#### Problems Group 2
1. Update the code we wrote above to use the `document.getElementsByTagName`:
```javascript

var paragraphs = document.body.getElementsByTagName("p")
var paragraphsArray = Array.prototype.slice.call(paragraphs);

paragraphsArray.forEach(function(paragraph) {
  paragraph.classList.add("article-text");
});
// OR
for (var i = 0; i < paragraphs.length; i++) {
  paragraphs[i].classList.add("article-text");
}
```

2. Let's make the previous problem more realistic. Instead of adding the `article-text` class to every paragraph on the page, let's restrict to those paragraphs inside a `<div class="intro">` tag. How can we do this? Keep in mind that you can call `getElementsByClassName` and `getElementsByTagName` on *any* Element; `document` is handiest when you need all matching elements from the page, but you can use any other element if you don't need everything on the page.

Update the code from Problem 1 to add the article-text class to paragraphs inside `<div class="intro">`, and nowhere else.

It's safer to search for specific code than to rely on relative positions of elements.

```javascript
var intros = document.getElementByClassName("intro");
for (var i = 0; i < intros.length; i++) {
  var paragraphs = intros[i].getElementsByTagName("p");
  for (var p = 0; p < paragraphs.length; p++) {
    paragraphs[p].classList.add("article-text");
  }
}
```

### Using CSS Selectors
Instead of searching for a tag name, class name, or relationship, popular JavaScript libraries and frameworks use CSS selectors to find Elements.
| Method | Returns |
| --- | --- |
| `document.querySelector(selector)` | First matching Element or `null` |
| `document.querySelectorAll(selector)` | `NodeList` of matching Elements |

The previous solution can now be written like so:
```javascript
var paragraphs = document.querySelectorAll('.intro p');
for (var i = 0; i < paragraphs.length; i++) {
  paragraphs[i].classList.add('article-text');
}
```
These methods also return Array-like object, not Arrays.

## Traversing Elements
If we're just looking for Element nodes and want to skip all the `#text` and `comment` nodes, use these methods.
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

Use them all on `document.body`.

### textContent
Used to access the text inside a node.
```javascript
document.querySelector('a').textContent
document.querySelector('a').textContent = 'step backward';
```

**Be Careful**: `textContent` removes all child nodes from the Element and replaces them with a Text Node.

To make this method safer, wrap the text you need to change in an Element (even a bare `span` or `div`) and use `textContent` on it.

## Practice Problems: Finding Nodes and Traversing Elements
Use [this Wikipedia page](https://en.wikipedia.org/wiki/Polar_bear) for these problems.

1. Write some JavaScript code to retrieve a word count for each h2 heading on the page.
```javascript
var h2s = document.querySelectorAll("h2");
h2Array = Array.prototype.slice.call(h2s);
var h2WordCounts = h2Array.map(function(h2) {
  return h2.textContent.split(" ").length;
});
console.log(h2WordCounts);
```

2. The page has a table of contents with the title "Contents" and links to the different content sections on "Naming and etymology," "Taxonomy and evolution," etc.
Use three different DOM methods to retrieve a reference to the div element that contains the table of contents.

```javascript
var toc = document.getElementById('toc');
var toc = document.querySelector("#toc");
var toc = document.querySelectorAll(".toc")[0]
```

3. Write some JavaScript code to change the color for every other link in the table of contents to green.
```javascript
var links = document.querySelectorAll("#toc a");
for (var i = 0; i < links.length; i++) {
  if (i % 2 === 0) {
    links[i].style.color = "green";
  }
}
```

4. Write some JavaScript code to retrieve the text of every thumbnail caption on the page.
```javascript
var nodes = document.querySelectorAll(".thumbcaption");
var captions = [];
for (var i = 0; i < nodes.length; i++) {
  captions.push(nodes[i].textContent.trim());
}
console.log(captions);
```

5. You can think of the scientific classification of an animal as a series of key-value pairs. Here, the keys are taxonomic ranks (*Domain*, *Kingdom*, *Phylum*, etc.). The values are the specific groups to which the animal belongs.

Write a JavaScript function to extract this information from the web page and return an Object that uses the ranks as keys and the groups as values.
```javascript
var keys = ["Kingdom", "Phylum", "Clade", "Class", "Order", "Suborder", "Family",
            "Genus", "Species"];

var classification = {};

var tds = document.querySelectorAll(".infobox td");

for (var i = 0; i < tds.length; i++) {
  var cell = tds[i];

  keys.forEach(function(key) {
    if (cell.textContent.indexOf(key) !== -1) {
      var link = cell.nextElementSibling.firstElementChild;
      classification[key] = link.textContent;
    }
  });
}

console.log(classification);
```

## Creating and Moving DOM Nodes
Start with this.
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>Empty Page</title>
  </head>
  <body>
  </body>
</html>
```
Add a paragraph.
```javascript
> var paragraph = document.createElement('p');
> paragraph.textContent = 'This is a test.';
> document.body.appendChild(paragraph);
```
Or create a text node and append it to the paragraph.
```javascript
> var text = document.createTextNode('This is a test.');
> var paragraph = document.createElement('p');
> paragraph.appendChild(text);
> document.body.appendChild(paragraph);
```

### Creating New Nodes
Two ways to do it:
1. Create empty nodes with `document.create*`
2. Clone an existing Node hierarchy

| Node Creation Method | Returns |
| --- | --- |
| `document.createElement(tagName)` | A new Element node |
| `document.createTextNode(text)` | A new Text node |
| `node.cloneNode(deepClone)` | Returns a copy of `node` |

If `deepClone` is `true`, the node and *all its children* are cloned. Otherwise, only that node is copied.

Add a copy of the paragraph.
```javascript
> paragraph
= <p>This is a test.</p>
> var paragraph2 = paragraph.cloneNode(true);
> document.body.appendChild(paragraph2);
```

### Adding Nodes to the DOM
Append, insert, and replace Nodes in relation to the Node's parent:

| Parent Node Method | Description |
| --- | --- |
| `parent.appendChild(node)` | Append node to the end of `parent.childNodes` |
| `parent.insertBefore(node, targetNode)` | Insert `node` into `parent.childNodes` before `targetNode` |
| `parent.replaceChild(node, targetNode)` | Remove `targetNode` from `parent.childNodes` and insert `node` at its former position |

**NOTE**: `document.appendChild` cause an error. Use `document.body.appendChild` instead.

> **No Node may appear twice in the DOM.** If you try to add a Node that is already in the DOM, it gets removed from the original location. Thus, you can move an existing Node by inserting it where you want it.

Insert before, after, or within an Element:

| Element Insertion Method | Description |
| --- | --- |
| `element.insertAdjacentElement(position, newElement)` | Inserts `newElement` at `position` relative to `element` |
| `element.insertAdjacentText(position, text)` | Inserts Text Node that contains `text` at `position` relative to `element` |

`position` must be one of the following String values:

| Position | Description |
| --- | --- |
| `"beforebegin"` | Before the element |
| `"afterbegin"` | Before the first child of the element |
| `"beforeend"` | After the last child of the element |
| `"afterend"` | After the element |

### Removing Nodes
A removed Node with be garbage collected unless a reference to the Node is kept in a variable.
| Element Method | Description |
| --- | --- |
| `node.remove()` | Remove `node` from the DOM |
| `parent.removeChild(node)` | Remove `node` from `parent.childNodes` |

## The Browser Object Model (BOM)
Other components of the browser accessible with JavaScript that are beyond the page contents.
* The windows used to display web pages
* The browser's history
* Sensors, including location

## Practice Problems: the DOM
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>DOM Exercise</title>
    <meta charset="UTF-8" />
    <style>
      .heading { text-align: center; }
      ul { list-style: none; }
      .bulleted { list-style: disc; }
      .hidden { display: none; }
      #notice {
        padding: 15px;
        color: #a2a299;
        background: #f0f0aa;
      }
      body#styled {
        padding: 25px 0;
        margin: 0;
        font: normal 16px Helvetica, Arial, sans-serif;
        color: #16997c;
        background: #5bccb3;
      }
      body#styled main {
        display: block;
        max-width: 550px;
        padding: 20px;
        margin: 0 auto;
        background: #ffffff;
        box-sizing: border-box;
      }
      body#styled h1 {
        text-align: center;
        color: #CC183E;
      }
    </style>
  </head>
  <body>
    <main>
      <h1 id="primary_heading">I should have a class of heading</h1>
      <ul id="list">
        <li>This list</li>
        <li>Needs a class</li>
        <li>Of bulleted</li>
      </ul>
      <p>This <a href="#" id="toggle">link</a> needs a click handler on it. The handler will find the div with id of notice and check its class. If it has a class of hidden, change it to a class of visible. Otherwise, change it to hidden.</p>
      <div id="notice" class="hidden">
        <p>Oh no! I'm allergic to the light! Hide me, quick! Click the link above!</p>
      </div>
      <p id="multiplication">What's 13 times 9?</p>
    </main>
  </body>
</html>
```

1. In these practice problems, we'll manipulate the DOM from Chrome's JavaScript console. To begin, open this page and the Web Developer tools. At the top of the Tools window, click the Console tab; we'll write all our JavaScript in the console.

Use JavaScript to add a class of `heading` to the heading (the `h1` element).
```javascript
document.getElementById("primary_heading").setAttribute("class", "heading");
```

2. Use JavaScript to set the class of the `ul` element to `bulleted`.
```javascript
document.getElementById("list").setAttribute("class", "bulleted");
```

3. In this problem and the next, we'll use the `onclick` Element property. You don't need to know much about `onclick` right now, but take a minute to read this [link](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers/onclick). We'll learn more about `onclick` later when we talk about event listeners. For now, the `onclick` property lets you detect when the user clicks an element.
Our page has an element that you can't see initially; it's hidden. When the user clicks the link, the browser should display the hidden item; the next click on that like should hide the revealed item. Each click should toggle the hidden element between the visible and hidden states.
Use the Inspector to find the hidden element and determine its ID, then use the ID to set the `onclick` property to a function that makes the element visible when it's hidden and hides it when it's visible. You can use `getAttribute` access the class, and `setAttribute` to set it; the class names of interest are `visible` and `hidden`.
You will have to write a multi-line expression in the console. To do this, hold the Shift key down when you press Enter. Otherwise, the browser will try to execute your partial code and raise an error.
Your function should take a single argument, e. The first line of your function should invoke `e.preventDefault()`. We'll discuss this later when we talk more about events, but, for now, just be aware that `preventDefault()` tells your browser that it shouldn't try to follow the link.
```javascript
var toggle = ;
document.getElementById('toggle').onclick = function(e) {
  e.preventDefault();
  var notice = document.getElementById('notice');
  if (notice.getAttribute('class') === "hidden") {
    notice.setAttribute('class', "visible");
  } else {
    notice.setAttribute('class', "hidden");
  }
}
```

4. Add an `onclick` event to the element we show and hide above. This time, the function should set the class of the element to `hidden`. This event will let you hide the visible element by clicking on it. As with the previous function, the first thing the function should do is invoke `e.preventDefault()`.
Inside your function, `this` points to the current DOM element, which means that you can use `this.setAttribute` to change its class; you don't have to locate it first with `getElementById`.
```javascript
document.getElementById('notice').onclick = function(e) {
  e.preventDefault(); // for consistency: no needed here.
  this.setAttribute('class', 'hidden');
}
```

5. Locate the multiplication paragraph and change the text to the result of the arithmetic problem. Use the [innerText property](https://developer.mozilla.org/en-US/docs/Web/API/Node/innerText).
```javascript
document.getElementById('multiplication').innerText = String(13 * 9);
```

6. Set the ID of the `body` element to `styled` to apply the rest of the styles from the original file. The body tag in this file doesn't have an ID, so you must locate it by some other means.
```javascript
document.body.setAttribute("id", "styled");
// OR
document.body.id = "styled";
```

## Summary

> * The **Document Object Model**, or **DOM**, is an in-memory object representation of an HTML document. It provides a way to interact with a web page using JavaScript, which provides the functionality required to build modern interactive user experiences.
> * The DOM is a hierarchy of **nodes**. Each node can contain any number of child nodes.
> * There are different types of nodes. The types you should be familiar with are **elements** and **text nodes**.
> * The whitespace in an HTML document may result in empty text nodes in the DOM.
> * Useful properties of nodes include `nodeName`, `nodeType`, `nodeValue`, and `textContent`.
> * Nodes have properties that traverse the DOM tree: `firstChild`, `lastChild`, `childNodes`, `nextSibling`, `previousSibling`, and `parentNode`.
> * Element nodes have `getAttribute`, `setAttribute`, and `hasAttribute` methods to manipulate HTML attributes.
> * Elements have properties that let you read and alter the `id`, `name`, `title`, and `value`.
> * Elements let you read and change CSS classes and style properties via the `classList` and `style` properties.
> * `document.getElementById(id)` finds a single Element with the specified `id`.
> * `document.getElementsByTagName(name)` and `document.getElementsByClassName(name)` find any Elements with the specified `tagName` or `class`.
> * `document.querySelector(selector)` returns the first Element that matches a CSS selector. `document.querySelectorAll(selector)` is similar but returns all matching elements.
> * Elements have properties to traverse the DOM tree: `firstElementChild`, `lastElementChild`, `children`, `nextElementSibling`, and `previousElementSibling`.
> * You can create new DOM nodes with `document.createElement(tagName)` or `document.createTextNode(text)`.
> * You can create a copy of a node with `node.cloneNode(deepClone)`.
> * `parent.appendChild(node)`, `parent.insertBefore(node, targetNode)`, `parent.replaceChild(node, targetNode)`, `element.insertAdjacentElement(position, newElement)`, and `element.insertAdjacentText(position, text)` add nodes to the DOM.
> * `node.remove()` and `parent.removeChild(node)` remove nodes from the DOM.
