# Event-Driven and Asynchronous Programming
## Asynchronous Execution with setTimeout
Most code I've written is **sequential** - one line must wait until the one before it is executed. When code is executed one line after another it is called **synchronous code**. It starts immediately and runs until the program ends.

Code can "pause" using a delay. This is called **asynchronous code**. Simulated example using `setTimeout`.
```javascript
setTimeout(function() {
  console.log('!');
}, 3000);

setTimeout(function() {
  console.log('World');
}, 1000)

console.log('Hello');
```
This logs `Hello` `World` `!` in that order. The delays (in milliseconds) cause the program to *do nothing* until the delay is finished. JavaScript keeps track of the timers created by `setTimeout`.

You can't tell if code is asynchronous just by looking at it. You must know if the functions called were invoked asynchronously.

In this sense we now must know *what* code does and also *when* it does it.

### Problems
1. Write a JavaScript function named `delayLog` that loops through the numbers from 1 to 10, and logs each number after that number of seconds. It should log `1` after 1 second, `2` after 2 seconds, etc.
```javascript
> delayLog();
1  // 1 second later
2  // 2 seconds later
3  // 3 seconds later
4  // etc...
5
6
7
8
9
10
```

```javascript
function makeLogger(i) {
  return function() {
    console.log(i);
  }
}

function delayLog() {
  for (var i = 1; i <= 10; i++) {
    var logger = makeLogger(i);
    setTimeout(logger, i * 1000);
  }
}
delayLog();
```

2. In what sequence will the JavaScript runtime run the following lines of code? Number them from 1-8 to show the order of execution.
```javascript
setTimeout(function() {   // 1
  console.log("Once");    // 5
}, 1000);

setTimeout(function() {   // 2
  console.log("upon");    // 7
}, 3000);

setTimeout(function() {   // 3
  console.log("a");       // 6
}, 2000);

setTimeout(function() {   // 4
  console.log("time");    // 8
}, 4000);
```

3. In what sequence does the JavaScript runtime run the functions `q()`, `d()`, `n()`, `z()`, `s()`, `f()`, and `g()` in the following code?
```javascript
setTimeout(function() {
  setTimeout(function() {
    q();
  }, 15);

  d();

  setTimeout(function() {
    n();
  }, 5);

  z();
}, 10);

setTimeout(function() {
  s();
}, 20);

setTimeout(function() {
  f();
});

g();
```
`g()`, `f()`, `d()`, `z()`, `n()`, `s()`, `q()`

4. Write a Function named `afterNSeconds` that takes two arguments: a callback and time in seconds. The function should wait for the indicated period, then invoke the callback function.
```javascript
function afterNSeconds(callback, seconds) {
  setTimeout(callback, seconds * 1000);
}
```

## Repeating Execution with setInterval
`setInterval` is similar to `setTimeout` but loops continuously until told to stop.
```javascript
var id = setInterval(function() { console.log("hello"); }, 2000);
// Loops continuously until...
clearInterval(id)
```

Example: auto-save work
```javascript
function save() {
  // Send the form values to the server for safe keeping
}

// Call save() every 10 seconds
var id = setInterval(save, 10000);

// Later, perhaps after the user submits the form.
clearInterval(id);
```

### Problems
1. Write a function name `startCounting` that logs a number to the console every second, starting with `1`. Each number should be one greater than the previous number.
```javascript
function startCounting() {
  var i = 0;
  setInterval(function() {
    i++;
    console.log(i);
  }, 1000)
}
```

2. Extend the code from the previous problem with a `stopCounting` function that stops the logger when called.
```javascript
var counterId;

function startCounting() {
  var i = 0;
  counterId = setInterval(function() {
    i++;
    console.log(i);
  }, 1000)
}

function stopCounting() {
  clearInterval(counterId);
}
```

## User Interfaces and Events
An **event** is an object that represents some occurrence and contains:
* what happened
* where it happened

Can be triggered when:
* page loads
* user interacts with the page
* browser performs some action required by program

Essentially a web application does two things:
1. Set up the user interface and display it.
2. Handle events resulting from user or browser actions.

The code the browser runs in response to an event is called an **event listener**.

## A Simple Example
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title>title</title>
    <meta charset="UTF-8">
    <script>
      document.addEventListener('DOMContentLoaded', function() {
        var addButton = document.getElementById('add');
        var output = document.getElementById('output');
        var count = 0;

        addButton.addEventListener('click', function(event) {
          count++;
          output.textContent = String(count);
        });
      });
    </script>
  </head>

  <body>
    <p>
      <span id="output">0</span>
      <button id="add">Add One</button>
    </p>
  </body>
</html>
```

1. Browser loads page and evaluates the JS. Registers a callback to handle `DOMContentLoaded` event when it **fires** on `document`.
2. Browser waits for event to fire.
3. Browser renders page and then fires the `DOMContentLoaded` event on `document`.
4. Browser invokes event handler for `DOMContentLoaded` and runs the code inside it. One part of this code registers an event listener for `click` events on `addButton`.
5. Browser waits for event to fire.
6. When button is clicked, the `click` event fires and the browser runs the handler - increments the variable and updates the text.
7. Browser waits for event to fire.

## Page Lifecyle Events
* HTML code received from server.
* HTML parsed and JavaScript evaluated.
* DOM constructed from parsed HTML.
* `DOMContentLoaded` event fires on `document`.
* Page displayed on screen.
* Embedded assets are loaded.
* `load` event fires on `window`.

## User Events
| Event Type | Example Events |
| --- | --- |
| Keyboard | `keydown`, `keyup`, `keypress` |
| Mouse | `mouseenter`, `mouseleave`, `mousedown`, `mouseup`, `click` |
| Touch | `touchdown`, `touchup`, `touchmove` |
| Window | `scroll`, `resize` |
| Form | `submit` |

Here is a [complete list](https://developer.mozilla.org/en-US/docs/Web/Events) of events.

## Adding Event Listeners (aka Event Handlers)
To setup an event handler:
1. **Identify the event you need to handle.** User actions, the page lifecycle, and more can fire events.
2. **Identify the element that will receive the event.** Depending on the event, the object could be a button, an input field, or any other element on the page.
3. **Define a Function to call when this event occurs.** The Function will receive a single argument, an Event object.
4. **Register the Function as an event listener.** This step brings the first three together into a working system.

Example:
```html
<html>
  <head>
    <title>Test Page</title>
  </head>
  <body>
    <textarea id="message"></textarea>
    <button id="alert">Alert</button>
  </body>
</html>
```

1. Want something to happen when user *clicks* on the "Alert" button.
2. The button.
3. Displays an alert using the contents of the `textarea`.
    ```javascript
    function displayAlert() {
      var message = document.getElementById('message').value;
      alert(message);
    }
    ```
4. Call `addEventListener` on a reference to the button:
    ```javascript
    document.addEventListener('DOMContentLoaded', function() {
      var button = document.getElementById('alert');
      button.addEventListener('click', displayAlert);
    })
    ```

[GlobalEventHandlers mixin](https://developer.mozilla.org/en-US/docs/Web/API/GlobalEventHandlers) provides an alternative way to register a Function as an event listener.
```javascript
document.addEventListener('DOMContentLoaded', function() {
  var button = document.getElementById('alert');
  button.onclick = displayAlert;
})
```

## The Event Object
Some useful info in the Event object:
| Property | Description |
| --- | --- |
| `type` | The name of the event (e.g., 'click') |
| `currentTarget` | The next object that will receive notification of the event, i.e., an element that has an event handler for this event |
| `target` | The initial object to receive notification of the event, i.e., the element clicked by the user |

### Mouse Events
Some mouse events:
| Property | Description |
| --- | --- |
| `button` | A reference to the clicked button (`null` for non-click events) |
| `clientX` | The horizontal position of the mouse when the event occurred |
| `clientY` | The vertical position of the mouse when the event occurred |

Both `clientX` and `clientY` return values **relative to the visible area of the page**: the number of pixels from the upper-left corner of the browser's viewport.

### Keyboard Events
Some keyboard events:

| Property | Description |
| --- | --- |
| `which` | The ASCII key code (a Number) that identifies the pressed key. |
| `key` | The String value of the pressed key. Older browsers do not support this property. |
| `shiftKey` | Boolean value that indicates whether the user pressed the shift key. |
| `altKey` | Boolean value that indicates whether the user pressed the alt (or option). |
| `ctrlKey` | Boolean value that indicates whether the user pressed the control key. |
| `metaKey` | Boolean value that indicates whether the user pressed the meta (or command) key. |

To view all available: [MDN page](https://developer.mozilla.org/en-US/docs/Web/Events)

### Problems
```html
<div class="x">
  <div class="horizontal"></div>
  <div class="vertical"></div>
</div>
```
```css
.x {
  position: absolute;
  transform: rotate(45deg);
  top: 20px;
  left: 20px;
}

.x .horizontal {
  width: 45px;
  height: 5px;
  position: absolute;
  left: -20px;
  background: red;
}

.x .vertical {
  height: 45px;
  width: 5px;
  background: red;
  position: absolute;
  left: 0px;
  top: -20px;
}
```

1. Move the red X to the last position in the document that the user clicked.
```javascript
document.addEventListener('click', function(event) {
  var x = document.querySelector('.x');
  x.style.left = event.clientX.toString() + 'px';
  x.style.top = event.clientY.toString() + 'px';
});
```

2. Update your solution to the previous problem to make the red X move as you move the mouse around the document instead of depending on clicks.
```javascript
document.addEventListener('mousemove', function(event) {
  var x = document.querySelector('.x');
  x.style.left = event.clientX.toString() + 'px';
  x.style.top = event.clientY.toString() + 'px';
});
```

3. Update your solution to the previous problem to change the color of the red X to blue when the user presses the `b` key, green in response to the `g` key, and red in response to `r`. The X should continue to follow the mouse around.
```javascript
document.addEventListener('mousemove', function(event) {
  var x = document.querySelector('.x');
  x.style.left = event.clientX.toString() + 'px';
  x.style.top = event.clientY.toString() + 'px';
});

document.addEventListener('keypress', function(event) {
  var x = document.querySelector('.x');
  var color;
  switch (event.key) {
    case 'g':
      color = 'green';
      break;
    case 'b':
      color = 'blue';
      break;
    case 'r':
      color = 'red';
      break;
  }

  if (color) {
    for (var i = 0; i < x.children.length; i++) {
      var child = x.children[i];
      child.style.background = color;
    }
  }
});
```
OR
```javascript
document.addEventListener('mousemove', function(event) {
  var x = document.querySelector('.x');
  x.style.left = event.clientX.toString() + 'px';
  x.style.top = event.clientY.toString() + 'px';
});

document.addEventListener('keypress', function(event) {
  var key = event.which;
  var color;

  if (key === 82) {
    color = 'red';
  } else if (key === 71) {
    color = 'green';
  } else if (key === 66) {
    color = 'blue';
  }

  if (color) {
    var x = document.querySelector('.x');
    for (var i = 0; i < x.children.length; i++) {
      var child = x.children[i];
      child.style.background = color;
    }
  }
});
```

4. Add a character counter that updates as the user types.
```html
<div class="composer">
  <textarea placeholder="Enter your message"></textarea>
  <p class="counter"></p>
  <button type="submit">Post Message</button>
</div>
```
```css
.composer {
  background: #f5f5f5;
  padding:  1em;
  width:  30em;
}

.composer textarea {
  width: 100%;
  height: 4em;
}

.composer textarea.invalid {
  color: red;
}
```

```javascript
document.addEventListener('DOMContentLoaded', function() {
  var composer = document.querySelector('.composer');
  var textarea = composer.querySelector('textarea');
  var counter = composer.querySelector('.counter');
  var button = composer.querySelector('button');

  function updateCounter() {
    var length = textarea.value.length;
    var remaining = 140 - length;
    var message = remaining.toString() + ' characters remaining';
    var invalid = remaining < 0;

    textarea.classList.toggle('invalid', invalid);
    button.disabled = invalid;

    counter.textContent = message;
  }

  textarea.addEventListener('keyup', updateCounter);

  updateCounter();
});
```

## Capturing and Bubbling
* You can't add an event listener to an element until the DOM is ready, which means that you must wait until the `DOMContentLoaded` event fires.
* You must add event handlers manually when you add new elements to the page after `DOMContentLoaded` fires.
* Adding handlers to many elements can be slow, and can lead to complicated, difficult to maintain code. Imagine a page with a larges spreadsheet-like grid with hundreds or thousands of cells; you must provide listeners for both keyboard and mouse events in every cell.

### Capturing and Bubbling
```html
<div>
  <input placeholder="type a letter here" />
</div>
```
An event is fired on every element and parent element, twice. Once for the **capturing** phase, it fired starting from the `window` object to the `document` object all the way to the inner-most element that fired the event. The **target** phase occurs when the event fires on the element that triggered the event. The process reverses and fires on each parent element in the **bubbling** phase going from the target to the `window` object.

### Specifying an Event Listener's Phase
Using `addEventListener` will listen during the target and bubbling phases. The optional 3rd argument, `useCapture`, is a Boolean that controls whether the listener should handle bubbling or capturing events.
To listen to the capturing phase, pass in `true`.
```javascript
document.addEventListener('click', function(event) {
  // executed during the target and capturing phases
}, true);
```

Capturing phase event handlers will fire before bubbling phase event handlers.

#### Capturing vs. Bubbling
Default to using bubbling; most code will work this way.

## Preventing Propagation and Default Behaviors
```javascript
event.stopPropagation(); // Tells the browser to stop bubbling the event up to parents
```

### Preventing Default Behaviors
`event.preventDefault()` takes care of this. This will stop actions like following a link when clicked.

**NOTE:** It is good practice to call `preventDefault()` or `stopPropagation()` as soon as possible in an event handler. It also ensures these methods run before any errors occur, making it a bit easier to debug.

## Event Delegation
To attached a common listener to 8 buttons we could use a `for` loop and attach a listener to each one. Drawbacks:
* Must wait for DOM to finish loading before adding event handlers.
* Event listeners are binded to elements that already exist, but if new ones are created they will not be included.
* The more listeners on a page, the worse the performance and memory.

**Event delegation** utilizes event bubbling to fix all this. Add a single handler to the parent of a group of elements.

### When To Use Event Delegation
Start by binding event handlers directly when a project is new and small. As it grows, delegation may make sense to reduce the number of event handlers required. Remember `document` does have to be used as the delegator.
jQuery is good at handling all of this.

## What is the Event Loop?
`setTimeout(callback, 0)` The 0 will ensure that the task won't get run until the call stack is clear.
The event loop simply looks at the task queue and the stack - if the stack is empty and there is something in the task queue, it will place the next item in the task queue onto the stack.

For something like `setTimeout` or many other asynchronous requests, tasks get placed on the task queue from whatever web api handled the asynchronous request.

## Douglas Crockford: An Inconvenient API - The Theory of the DOM
Here's the [video](https://www.youtube.com/watch?time_continue=3&v=Y2Y0U-2qJMs).

## Summary
Summary

1. `setTimeout(callback, delay)` invokes a Function after the specified number of milliseconds.
2. `setInterval(callback, delay)` invokes a Function repeatedly in intervals of some specified number of milliseconds. `clearInterval` clears the interval and prevents future invocations of the Function.
3. An **event** is an object that represents some occurrence and contains a variety of information about what and where it happened. The browser triggers some events as it loads a page and when it accomplishes some actions directed by an application. The user also triggers events when he interacts with the page.
4. Code that must access the DOM should be invoked after the `DOMContentLoaded` event fires on `document`.
5. User events drive most user interfaces and can result from a user interacting with the keyboard, mouse, touchscreen, window, and other devices. Examples of these user events are `click`, `mouseover`, `keydown`, and `scroll`.
6. **Event listeners** are callbacks that the browser will invoke when a matching event occurs.
7. `element.addEventListener` registers an event listener. You can also use specific `GlobalEventHandlers` like `element.onclick`, to register an event handler.
8. The Event object provides the useful properties `type`, `target`, and `currentTarget`.
9. Keyboard events have properties `which` and `key` (and others) that describe the keys the user pressed. Mouse events similarly provide `button`, `clientX`, and `clientY`.
10. There are three phases to firing events: capturing, target, and bubbling.
11. `event.preventDefault()` prevents default browser behavior in response to an event. `event.stopPropagation()` stops the current capturing or bubbling phase, which prevents the event from firing on containing or contained elements.
12. **Event delegation** is a technique used to handle events triggered by multiple elements using a single event handler.
