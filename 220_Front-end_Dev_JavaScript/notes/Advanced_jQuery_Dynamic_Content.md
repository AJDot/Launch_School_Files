# Advanced jQuery and Dynamic Content Creation

## jQuery Event Delegation

Imagine 3000 event handlers on links that will each remove an item from a list. This may not be too much but it could cause slow downs. Instead, use event delegation and attach one event to their parent.

```html
<ul>
  <li>
    <p>Bananas</p>
    <a href="#">Remove</a>
  </li>
  <!-- 29 more list items, each with a remove anchor -->
</ul>
```
```javascript
$('ul').on('click', 'a', function(e) {
  e.preventDefault();

  $(e.target).closest('li').remove();
});
```
Event delegation allows newly created elements to also respond to event listeners. This would not happen if an element is created after an event listener is binded.

##### Namespace
```javascript
$("#namespaced").on("click.alert", function(e) {
  alert("Now removing only the alert event");
  $(this).off(".alert");
})
```
The `.alert` is the namespace and now controls just the event listeners attached to it. If only `.alert` was passed into `on` then all events within that namespace would be removed.
Can also pass in the event object to `off` to unbind the current event.

Can also just pass in `false` as the callback to remove the event handler.

##### Create a new event object
```javascript
$("#trigger_k").on("click", function(e) {
  e.preventDefault();
  e.stopPropagation();

  var keyup_event = $.Event({
    type: "keyup"
  });

  keyup_event.which = 75; // k

  $("#text").trigger(keyup_event);
});
```

## Ajax
[Source](https://learn.jquery.com/ajax/)
Asynchronous JavaScript and XML

Ajax requests are triggered by JavaScript. It sends a request to a URL and triggers a callback when a response is received. This process varies across all browsers, jQuery fixes that.

`$.ajax()`, `$.get()`, `$.getScript()`, `$.getJSON()`, `$.post()`, `$().load()` are all convenient methods are working with Ajax requests.

**Review**: Recall that a `GET` request is used for non-destructive operations and `POST` is for destructive operations.

### A is for Asynchronous
The response is only handle using a callback.
```javascript
// This will fail because console.log(response) will like execute before the
// response has arrived
var response;
$.get( "foo.php", function( r ) {
  response = r;
});

console.log( response ); // undefined
```
This will work.
```javascript
$.get( "foo.php", function( response ) {
  console.log( response );  // server response
});
```

### `$.ajax()`
Takes a configuration object that contains all the instructions jQuery requires to complete the request. Can have both a success and a failure callback.
Example:
```javascript
// Using the core $.ajax() method
$.ajax({

    // The URL for the request
    url: "post.php",

    // The data to send (will be converted to a query string)
    data: {
        id: 123
    },

    // Whether this is a POST or GET request
    type: "GET",

    // The type of data we expect back
    dataType : "json",
})
  // Code to run if the request succeeds (is done);
  // The response is passed to the function
  .done(function( json ) {
     $( "<h1>" ).text( json.title ).appendTo( "body" );
     $( "<div class=\"content\">").html( json.html ).appendTo( "body" );
  })
  // Code to run if the request fails; the raw request and
  // status codes are passed to the function
  .fail(function( xhr, status, errorThrown ) {
    alert( "Sorry, there was a problem!" );
    console.log( "Error: " + errorThrown );
    console.log( "Status: " + status );
    console.dir( xhr );
  })
  // Code to run regardless of success or failure;
  .always(function( xhr, status ) {
    alert( "The request is complete!" );
  });
```

### Ajax and Forms
#### Serialization
`.serialize()` and `.serializeArray()` can serialize a form.
`.serialize()` serializes into a query string. The form **must** have a `name` attribute to do this. (`checkbox` and `radio` inputs are only included with they are checked.)
`.serializeArray()` will produce an array of objects, usually with `name` and `value` properties for each input.

### Ajax Events
Can perform operations whenever an Ajax request starts or stops. To do this, Ajax events can be binded to elements just like other events.
Example:
```javascript
// Setting up a loading indicator using Ajax Events
$("#loading_indicator")
  .ajaxStart(function() {
    $(this).show();
  })
  .ajaxStop(function() {
    $(this).hide();
  });
```
