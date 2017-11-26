# Maki
<!-- toc orderedList:0 depthFrom:1 depthTo:6 -->

* [Maki](#maki)
  * [Making a Request with XMLHttpRequest](#making-a-request-with-xmlhttprequest)
    * [Overview of XMLHttpRequest Methods](#overview-of-xmlhttprequest-methods)
    * [Debugging XMLHttpRequests in Chrome](#debugging-xmlhttprequests-in-chrome)
    * [Problems](#problems)
  * [XMLHttpRequest Events](#xmlhttprequest-events)
  * [Data Serialization](#data-serialization)
    * [Request Serialization Formats](#request-serialization-formats)
      * [Query String / URL Encoding](#query-string-url-encoding)
    * [Multipart Forms](#multipart-forms)
    * [JSON Serialization](#json-serialization)
  * [Example: Loading HTML via XHR](#example-loading-html-via-xhr)
  * [Example: Submitting a Form via XHR](#example-submitting-a-form-via-xhr)
    * [URL-encoding POST parameters](#url-encoding-post-parameters)
    * [Submitting a Form](#submitting-a-form)
    * [Submitting a Form with FormData](#submitting-a-form-with-formdata)
  * [Example: Loading JSON via XHR](#example-loading-json-via-xhr)
    * [Problems](#problems-1)
  * [Example: Sending JSON via XHR](#example-sending-json-via-xhr)
    * [Serializing Data with JSON](#serializing-data-with-json)
    * [Setting the Content-Type Header](#setting-the-content-type-header)
  * [Cross-Domain XMLHttpRequests with CORS](#cross-domain-xmlhttprequests-with-cors)
    * [Cross-Origin Requests](#cross-origin-requests)
    * [Cross-Origin requests with XHR](#cross-origin-requests-with-xhr)
    * [CORS](#cors)
  * [Summary](#summary)

<!-- tocstop -->
ng HTTP Requests from JavaScript

## Making a Request with XMLHttpRequest

`XMLHttpRequest` object is used for this. It is part of the browser API (not JS).

Same parameters must be provided as for any other HTTP request.
```javascript
var request = new XMLHttpRequest(); // Instantiate new XMLHttpRequest object
request.open('GET', '/path');       // Set HTTP method and URL on request
request.send();                     // Send request
```

This is an **asynchronous** request, meaning code after it will continue to run while the request is out.
```javascript
request.responseText;     // => null
request.status;           // => null
request.statusText;       // => null
```

Use an event listener 'load' to fire callback after response loads.
```javascript
request.addEventListener('load', function(event) {
  var request = event.target;                 // the XMLHttpRequest object

  request.responseText;                       // body of response
  request.status;                             // status code
  request.statusText;                         // status text from response

  request.getResponseHeader('Content-Type');  // response header

  request.readyState;                         // explained later...
});
```

### Overview of XMLHttpRequest Methods
| Method | Description |
| --- | --- |
| `open(method, url)` | Open a connection to `url` using `method`. |
| `send(data)` | Send the request, optionally sending along `data`. |
| `setRequestHeader(header, value)` | Set HTTP `header` to `value`. |
| `abort()` | Cancel an active request. |
| `getResponseHeader(header)` | Return the response's value for `header`. |

| Property | Writable | Default Value | Description |
| --- | --- | --- | --- |
| `timeout` | Yes | | Maximum time a request can take to complete (in milliseconds) |
| `readyState` | No | | What state the request is in (see below) |
| `responseText` | No | `null` | Raw text of the response's body. |
| `response` | No | `null` | Parsed content of response, *not meaningful in all situations* |

### Debugging XMLHttpRequests in Chrome
Enable to option to log `XMLHttpRequests` to the console in the Chrome settings.

### Problems
1. Write JavaScript code that makes a GET request to this URL: `https://api.github.com/repos/rails/rails`.

```javascript
var request = new XMLHttpRequest();
request.open('GET', 'https://api.github.com/repos/rails/rails');
request.send();
```

2. What property will contain the response body after the request from the previous problem completes?

`responseText` or `response`

## XMLHttpRequest Events

In the `load` event listener, `event.target` will be the request.

| Event | Fires When... |
| --- | --- |
| `loadstart` | Request sent to server |
| `loadend` | Response loading done and all other events have fired. Last event to fire. |
Before loadend triggers, another event will fire based on whether the request succeeded:

| Events | Fires when... |
| --- | --- |
| `load` | A complete response loaded |
| `abort` | The request was interrupted before it could complete |
| `error` | An error occurred |
| `timeout` | A response wasn't received before the timeout period ended |

| Event | Fires when... |
| --- | --- |
| `readystatechange` | The value of `readyState` changes |
| `progress` | Response data is received *in some situations*. |


## Data Serialization
### Request Serialization Formats
Example Data:
```javascript
{
  "title": "Do Androids Dream of Electric Sheep?",
  "year": 1968
}
```

#### Query String / URL Encoding
`name=value` pairs separated by `&`. Non-alphanumeric characters make reading it difficult. Ex: spaces are `20%` or `+`.

JavaScript has a built-in `encodeURIcomponent()` to encode info. Then this info can be appended to the path send in the GET request.

For POST requests, must include `Content-Type` header with value of `application/x-www-form-urlencoded`. Then the encoded `name=value` pairs string is places in the request body.

### Multipart Forms
```
Content-Type: multipart/form-data; boundary=----WebKitFormBoundarywDbHM6i57QWyAWro
```
Below is an entire POST request that uses multipart form data. Notice how each parameter is in a separate part of the request body, with the boundary delimiter before each section, and after the last section. The Content-Type header also sets multipart/form-data and specifies the boundary delimiter:

```
POST /path HTTP/1.1
Host: example.test
Content-Length: 267
Content-Type: multipart/form-data; boundary=----WebKitFormBoundarywDbHM6i57QWyAWro
Accept: */*

------WebKitFormBoundarywDbHM6i57QWyAWro
Content-Disposition: form-data; name="title"

Do Androids Dream of Electric Sheep?
------WebKitFormBoundarywDbHM6i57QWyAWro
Content-Disposition: form-data; name="year"

1968
------WebKitFormBoundarywDbHM6i57QWyAWro--
```

### JSON Serialization
A `GET` request can return JSON but you must use `POST` to send JSON data to the server.
```
POST /path HTTP/1.1
Host: example.test
Content-Length: 62
Content-Type: application/json; charset=utf-8
Accept: */*

{"title":"Do Androids Dream of Electric Sheep?","year":"1968"}
```

## Example: Loading HTML via XHR
Example Page:
```html
<h1>Existing Page</h1>

<div id="store"></div>
```
Example JavaScript:
```javascript
document.addEventListener('DOMContentLoaded', function() {
  var request = new XMLHttpRequest();
  request.open('GET', 'https://ls-230-web-store-demo.herokuapp.com/products');
  request.send();

  // Gets the products and embeds the HTML in the div
  request.addEventListener('load', function(event) {
    var store = document.getElementById('store');
    store.innerHTML = request.response;
  });

  // Listens for clicks on the products
  store.addEventListener('click', function(event) {
    var target = event.target;
    if (target.tagName !== 'A') {
      return;
    }

    event.preventDefault();

    var request = new XMLHttpRequest();
    request.open('GET', 'https://ls-230-web-store-demo.herokuapp.com' + target.getAttribute('href'));
    request.send();

    request.addEventListener('load', function(event) {
      store.innerHTML = request.response;
    });
  });
});
```

**Summary**
1. We can use an `XMLHttpRequest` object to fetch content and insert it in an existing web page without a full page reload.
2. We can attach event listeners to content embedded in the page to circumvent the browser's default behavior and create custom interactions.

## Example: Submitting a Form via XHR
1. Serialize the form data
2. Send the request using `XMLHttpRequest`.
3. Handle the Response

Steps 2 and 3 are similar to what we did for `GET` requests.
```javascript
var request = new XMLHttpRequest();
request.open('POST', 'http://example.text/path');

var data = 'this is a test';

request.send(data);

// Or if there was no data to send
// request.send();
```

Results in this request
```
POST /path HTTP/1.1
Host: example.test
Content-Length: 14
Content-Type: text/plain;charset=UTF-8
Accept: */*

this is a test
```

### URL-encoding POST parameters
As said, must include `application/x-www-form-urlencoded` as the `Content-Type` header. Then the name/value string is placed in the body

```javascript
var request = new XMLHttpRequest();
request.open('POST', 'http://ls-230-book-catalog.herokuapp.com/books');

request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

var data = 'title=Effective%20JavaScript&author=David%20Herman';

request.addEventListener('load', function() {
  if (request.status === 201) {
    console.log('This book was added to the catalog: ' + request.responseText);
  }
});

request.send(data);
```
```
POST /books HTTP/1.1
Host: ls-230-book-catalog.herokuapp.com
Content-Length: 18
Content-type: application/x-www-form-urlencoded
Accept: */*

title=Effective%20JavaScript&author=David%20Herman
```
Request status of 201 means the resource was added successfully.

### Submitting a Form
Example Form
```html
<form id="form">
  <p><label>Title: <input type="text" name="title"></label></p>
  <p><label>Author: <input type="text" name="author"></label></p>
  <p><button type="submit">Submit</button></p>
</form>
```
Access values from form and make event listener when form is submitted.
```javascript
var form = document.getElementById('form');

// Bind to the form's submit event to handle the submit button
// being clicked, enter being pressed within an input, etc.
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
  request.open('POST', 'http://ls-230-book-catalog.herokuapp.com/books');
  request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

  request.addEventListener('load', function() {
    if (request.status === 201) {
      console.log('This book was added to the catalog: ' + request.responseText);
    }
  });

  request.send(data);
});
```
```
POST /books HTTP/1.1
Host: ls-230-book-catalog.herokuapp.com
Content-Length: 13
Content-type: application/x-www-form-urlencoded
Accept: */*

title=Effective%20JavaScript&author=David%20Herman
```

### Submitting a Form with FormData
The above process is error prone. Modern browsers provide a built-in API to assist this, `FormData`.
```javascript
var form = document.getElementById('form');

form.addEventListener('submit', function(event) {
  // prevent the browser from submitting the form
  event.preventDefault();

  var data = new FormData(form);

  var request = new XMLHttpRequest();
  request.open('POST', 'http://ls-230-book-catalog.herokuapp.com/path');

  request.addEventListener('load', function() {
    if (request.status === 201) {
      console.log('This book was added to the catalog: ' + request.responseText);
    }
  });

  request.send(data);
});
```

NOTE: `FormData` uses a different serialization format called `multipart`
```
POST /books HTTP/1.1
Host: ls-230-book-catalog.herokuapp.com
Content-Length: 234
Content-Type: multipart/form-data; boundary=----WebKitFormBoundaryf0PCniJK0bw0lb4e
Accept: */*

------WebKitFormBoundaryf0PCniJK0bw0lb4e
Content-Disposition: form-data; name="title"

Effective JavaScript
------WebKitFormBoundaryf0PCniJK0bw0lb4e
Content-Disposition: form-data; name="author"

David Herman
------WebKitFormBoundaryf0PCniJK0bw0lb4e--
```

## Example: Loading JSON via XHR
Valid `responseType` property values are: `text`, `json`, `arraybuffer`, `blob`, and `document`.
Set `responseType` to `json`
```javascript
var request = new XMLHttpRequest();
request.open('GET', 'https://api.github.com/repos/rails/rails');
request.responseType = 'json';
request.addEventListener('load', function(event) {
  // request.response will be the result of parsing the JSON response body
  // or null if the body couldn't be parsed or another error occurred.

  var data = request.response;
});
request.send();
```

### Problems
1. Make a request, parse it, display some data. Handle an error.
```javascript
var request = new XMLHttpRequest();
request.open('GET', 'https://api.github.com/repos/rails/rails');
request.addEventListener('load', function(event) {
    var data = JSON.parse(request.response);
    console.log(request.status);
    console.log(data.open_issues);
});

request.addEventListener('error', function(event) {
  console.log('The request could not be completed!');
});
request.send();
```

## Example: Sending JSON via XHR
Similar to submitting a form:
1. Serialize the data **into valid JSON**.
2. Send the request using `XMLHttpRequest` **with a `Content-Type: aplication/json` header**.
3. Handle the response.

### Serializing Data with JSON
Review: How to send a basic POST request.
```javascript
var request = new XMLHttpRequest();
request.open('POST', 'http://ls-230-book-catalog.herokuapp.com/books');

var data = 'title=Programming%20Ruby&author=Dave%20Thomas';

request.send(data);
```

In JSON format
```javascript
var request = new XMLHttpRequest();
request.open('POST', 'http://ls-230-book-catalog.herokuapp.com/books');

var data = { title: 'Programming Ruby', author: 'Dave Thomas' };
var json = JSON.stringify(data);
// {"title": "Programming Ruby", "author": "Dave Thomas"}

request.send(json);
```

### Setting the Content-Type Header
```javascript
var request = new XMLHttpRequest();
request.open('POST', 'http://ls-230-book-catalog.herokuapp.com/books');

request.setRequestHeader('Content-Type', 'application/json');

var data = { title: 'Programming Ruby', author: 'Dave Thomas' };
var json = JSON.stringify(data);
// {"title": "Programming Ruby", "author": "Dave Thomas"}

request.send(json);
```

## Cross-Domain XMLHttpRequests with CORS
### Cross-Origin Requests
The scheme, hostname, and port of a web page's URL define its origin.

A cross-origin request could be for an image, a JS file, XHR, or anything else. The most important kind of cross-origin request for our purposes is a cross-domain request: a request from one domain (hostname) to another domain.

They have security vulnerabilities. Be careful...

### Cross-Origin requests with XHR
By default an `XHR` object can't send **cross-origin** requests because of those security concerns. It can be possible though, by using Cross-Origin Resource Sharing (CORS).

### CORS
According to W3C, every `XMLHttpRequest` sent must have an `Origin` header that contains the origin of the requesting page.

The server determines whether the request came from an origin that is allowed to see the response. It yes, `Access-Control-Allow-Origin` header is sent back that contains the origin.

```
Access-Control-Allow-Origin: http://localhost:8000
```

To make a resource available to everyone, `*` will be sent:
```
Access-Control-Allow-Origin: *
```

## Summary
* AJAX is a technique used to exchange data between a browser and a server without causing a page reload.
* Modern browsers provide an API called the `XMLHttpRequest` to send AJAX requests.
* Some modern applications rely exclusively on javaScript and `XMLHttpRequest` to communicate with the server and build up the DOM. Such applications are called *single page applications*.
* Sending requests through `XMLHttpRequest` mainly involves the following steps:
  * Create a new `XMLHttpRequest` object.
  * Use the `open` method on the XHR object to specify the method and URL for the request.
  * Use the `setRequestHeader` method on the XHR object to set headers you'd like to send with the request. Most of the headers will be added by the browser automatically.
  * Attach an event handler for the `load` event to the XHR object to handle the response.
  * Attach an event handler for the `error` event to the XHR object to handle any connect errors. This is not required but it's a good practice.

* XHR objects send asynchronous requests by default, meaning that the rest of the code continues to execute without waiting for the request to complete.
* Important properties on an XHR object are: `responseText`, `response`, `status`, and `statusText`.
* The data sent along with requeusts, if any, must be serialized into a widely supported format.
* The three request serialization formats in widespread use are: 1) *query string/url encoding*, 2) *multi-part form data*, 3) and *JSON*.
* It's a good practice to send a `Content-Type` header with XHR. This helps the server parse the request data.
* Three popular response formats are: 1) HTML, 2) JSON, 3) XML.
* The single most popular serialization format currently in use is JSON.
* To submit a form via XHR, an instance of `FormData` can be used to conveniently serialize the form into multi-part data format.
* One useful property on an XHR object is `responseType`. It's particularly useful when the response is expected to be JSON. When its value is set to `"json"`, the XHR object's response property gives us parsed JSON.
* One major constraint on XHR is the browsers' same-origin policy that limits communication to the same domain, the same port, and the same protocol. Any attempt to comunicate outside these limits result in a security error.
* The standard solution for cross-origin restrictions is a W3C specification called Cross-Origin Resource sharing (CORS). CORS recommends using an `Origin` header on the request and an `Access-Control-Allow-Origin` header on the response for cross-origin communications.
