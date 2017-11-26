# Ajax

A basic Ajax call using jQuery:
```javascript
$.ajax({
  url: "/url/to/data/"
  type: "GET", // Or POST or any other HTTP method
  data: "parameters?=toAttachToURL",
  success: function(json) {
    // What to do when a response is successfully returned.
  },
  error: function(json) {
    // What to do when a response is not successfully returned.
  }
})
