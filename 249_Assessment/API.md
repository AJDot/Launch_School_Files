# Working with APIs

## A RESTful API Template

| Objective | How | | What | |
| --- | --- | --- | --- | --- |
| | Operation | HTTP Method | Resource | Path |
| Get the information about a $RESOURCE | Read | GET | $RESOURCE | /$RESOURCEs/:id |
| Add a $RESOURCE to the system | Create | POST | $RESOURCEs Collection | /$RESOURCE
| Make a change to a $RESOURCE | Update | PUT | $RESOURCE | /$RESOURCEs/:id |
Remove a $RESOURCE from the system | DELETE | DELETE | $RESOURCE | /$RESOURCEs/:id

As an API designer, ask yourself:
1. What resources will be exposed?

As a consumer, ask yourself:
1. What resource will allow me to achieve my goal?

## Basics of sending a request to an API

```javascript
var request = new XMLHttpRequest(); // Instantiate new XMLHttpRequest object
request.open('GET', '/path');       // Set HTTP method and URL on request
request.send();                     // Send request
```

To access anything about the response, must wait for response to return. Use event listener `load`.
```javascript
request.addEventListener("load", function(event) {
  var request = event.target;                   // the XMLHttpRequest

  request.responseText;                         // body of response
  request.status;                               // status code
  request.statusText;                           // status text from response

  request.getResponseHeader('Content-Type');  // response header
});
```

### XMLHttpRequest Methods and Properties

| Method | Description |
| --- | --- |
| `open(method, url)` | Open a connection to `url` using `method`. |
| `send(data)` | Send the request, optionally sending along `data`. |
| `setReqeustHeader(header, value)` | Set HTTP `header` to `value`. |
| `abort()` | Cancel an active request |
| `getResponseHeader(header)` | Return the response's value for `header`. |

| Property | Writable | Default Value | Description |
| --- | --- | --- | --- |
| `timeout` | Yes | | Maximum time a request can take to complete (in milliseconds) |
| `readyState` | No | | What state the request is in |
| `responseText` | No | `null` | Raw text of the response's body. |
| `response` | No | `null` | Parsed content of response, *not meaningful in all situations*

```javascript
var request = new XMLHttpRequest();
request.open("GET", "https://api.github.com/repos/rails/rails");
request.send();

request.addEventListener("load", function(event) {
  var xhr = event.target;
})
```

### POST with URL-encoding Parameters
For sending form data.
```javascript
var request = new XMLHttpRequest();
request.open("POST", "/path");

request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

var data = "key=value*anotherKey=anotherValue"; // url-encoded parameters

request.addEventListener("load", function(event) {
  if (request.status === 201) { // resource added successfully on server
    console.log("This is a message: " + request.responseText);
  }
});

request.send(data);
```

### Submitting a Form
```javascript
var form = document.getElementById('form');

// Bind to the form's submit event to handle the submit button
// being clicked, enter being pressed with an input, etc
form.addEventListener('submit', function(event) {
  // prevent the browser from submitting the form
  event.preventDefault();

  // access the inputs using form.elements and serialize into a string
  var keysAndValues = [];

  for (var i = 0; i < form.elements.length; i++) {
    var element = form.elements[i];
    var key = encodeURIComponent(element.name);
    var value = encodeURIComponent(element.value);
    keysAndValues.push(key + '=' + value);
  }

  var data = keysAndValues.join('&');

  // submit the data
  var request = new XMLHttpRequest();
  request.open("POST", "/path");
  request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

  request.addEventListener("load", function() {
    if (request.status === 201) {
      // Do something with the response
      console.log('This this was added to this other thing: ' + request.responseText);
    }
  });

  request.send(data);
});
```

To make the serialization much simpler and less error prone, change the data to this:
```javascript
var data = new FormData(form);
```
Note that using `FormData` uses a different serialization format called `multipart`

This will be seen:
```
...
Content-Type: multipart/form-data; boundary=----osidjfosjfoj
...
```

instead of this:
```
...
Content-Type: application/x-www-form-urlencoded
...
```

### Loading JSON via XHR
```javascript
var request = new XMLHttpRequest();
request.open('GET', 'http://ls-230-book-catalog.herokuapp.com/invalid_book');
request.addEventListener('load', function(event) {
  try {
    var data = JSON.parse(request.response);
    // do something with the data
  } catch(e) {
    console.log('Cannot parse the received response as JSON.')
  }
});
request.send();
```

### Sending JSON via XHR
```javascript
var request = new XMLHttpRequest();
request.open('POST', 'http://ls-230-book-catalog.herokuapp.com/books');

// Important
request.setRequestHeader('Content-Type', 'application/json');

var data = { title: 'Programming Ruby', author: 'Dave Thomas' };
// Important
var json = JSON.stringify(data);

request.send(json);
```
