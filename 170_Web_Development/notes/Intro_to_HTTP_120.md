# Intro to HTTP
## The Request/Response Cycle

Client - Likely a web browser
Server - The actual software running on the server

__Example__: 

Client - your browser
Server - located at todos.com

1. Client makes a request - we typed a URL into browser and hit return - http://todos.com/tasks?due=today
2. Browser creates request and send across network to server.
  * Method: GET
  * Path: /tasks
  * Parameters: ?due=today
  * Host request header will include the host name (todos.com)
3. Server will do some work - here is a common workflow
  * Verify user session
  * Load tasks from database
  * Render HTML
4. Server sends response back to client - in this case the response is HTML code
  * Status: 200 OK
  * Headers: Content-Type: text/html, etc.
  * Body: \\<html>\\<body>...
5. Client looks at the Content-Type header and acts accordingly. For text/html, it will display the page.


### Practice Problems
1. What are the required components of an HTTP request? What are the additional optional components?

The required components are the method and path. The optional components are the parameters, headers, and body.

2. What are the required components of an HTTP response? What are the additional optional components?

The required components are the status. Headers and body are optional.

3. What determines whether a request should use GET or POST as its HTTP method?

GET should be used to retrieve/request/fetch data from the server. They are like "read only" operations. A subtle exception is a website that tracks the number of times visited. GET is used because this alteration to data on the server does not change the main content on the page.

POST should be used to send data to the server. They involve changing values on the server. One exception to this is search forms since they are not changing any data on the server.

## Summary
* HTTP is a text-based protocol - foundation of the web
* A _client_ and a _server_ are involved in HTTP
* The client sends a _request_ to the server, and a _response_ is sent from the server to the client.
* A request is sent to a _host_ and must include a _method_ and _path_. It may include _parameters_, _headers_, or a _body_.
* `GET` is the HTTP method to retrieve a resource from the server
* A reponse must include a _status_. It may include _headers_ or a _body_
* A `200 OK` status means the request was successful.
* Modern web browsers include debugging tools that allow you to inspect the HTTP activity of a page.