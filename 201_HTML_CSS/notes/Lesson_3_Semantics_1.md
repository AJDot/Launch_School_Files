# Lesson 3 - Semantics

[Semantic code: What? Why? How?](https://boagworld.com/dev/semantic-code-what-why-how/)

### Why Semantic Code?
* Aids accessibility
* Search engines
Other Benefits
* Usually shorter code
* updates a site is usually easier when tags are consistent across pages
* easier to understand
* ability to change the look of a site without recoding the HTML
* anyone can add or edit content which only needs to be described; css will style it

## Classes, IDs, and Names
### Classes
* Use the `class` attribute to assign a class or classes to an element.
* Any number of elements may belong to teh same class.
* Any element can belong to one or more classes. List all teh anmes separated by spaces in the `class` attribute.
* Use semantic class names; they should provide meaning. For instance, use `teaching-assistant` instead of `yellow-background`.
* Use CSS selectors of the form `.classname` to select elements by class, e.g., `.teaching-assistant`.
* Class selectors have lower CSS specificity than ID selectors, but higher than tag name selectors.

### IDs
* Use the `id` attribute to assign an ID to an element.
* Each ID on a page must be unique.
* Each element can have one ID or none.
* Use semantic ID names; they should provide meaning. For instance, use an ID name of `headline` rather than `big-font`.
* Use CSS selectors of the form `#idname` to select elements by ID, e.g., `#headline`.
* ID selectors have higher CSS specificity than class selectors.

### Names
The `name` attribute applies to forms, not styling. Use the CSS selector `[name="..."]` to select elements by name but using a class or ID is preferred. The name/value pairs get sent to the server when the form is submitted. NOTE: The ID is not sent.
* Use the name attribute to assign a name to a form data element.
* Not all tags accept the name attribute; it applies to input controls in forms. Some other elements have a name attribute, too, but with a different meaning.
* Always use a name attribute on form elements that accept it.
* Each name in a form should be unique except for radio buttons that belong to a single group.
* Use descriptive name values, not semantic. For instance, use name="last-name" instead of name="input-field".
* Avoid trying to select elements in CSS by using the name attribute.

## When Should I Use Tables?
### Do NOT Use Tables for layout purposes:
* Using table for layout is semantically inappropriate.
* Tables mix content, markup, and sometimes even styling information together.
* Tables are difficult to update and restyle.
* Tables are difficult for browsers to render, which can slow down page loads noticeably.

Use tables when the data inside them actually pertain to the column heading and row heading they are in.
