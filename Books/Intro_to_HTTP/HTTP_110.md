# HTTP
## Making Requests

## Processing Responses

## Stateful Web Applications
### Introduction
HTTP protocol is stateless, meaning the server does not keep any information between request/response cycles. Different requests are not aware of each other. So how do we stay logged into Facebook when clicking to a new page which sends a new request?

There are three approaches to making this work:
* Sessions
* cookies
* Asynchronous JavaScript calls, or AJAX

### A Stateful App
Go to reddit.com. Then login. Now your page says you are logged in. Refresh the page - which sends a new request - and yet somehow you are still signed in. This is the same concept that allows items in your shopping cart to stay there while you browse around, even over days sometimes.

### Sessions
With help from the client (the browser), HTTP can act as if it were maintaining a stateful connection with the server. One way is for the server to send a unique token to the client. Whenever the client makes a request it appends the token which allows the server to identify the client. In web development, this token is call the __session identifier__.

1. Every request must be inspected to see if it contains a session identifier.
2. If it does, the server must check to ensure that this session id is still valid. So the server must have rules to control session expiration and how to store its session data.
3. Server must retrieve session data based on the session id.
4. Server needs to recreate the application state (e.g., the HTMl for a web request) from the session data and send it back to the client as a response.

This is a lot of work for the server.

### Cookies
A piece of data sent from the server and stored in the client during a request/response cycle. __Cookies__ or __HTTP Cookies__, are small files stored in the browser and contain session information. Note the actually data is stored on the server. Now when you visit the website again, your session is recognized because of the stored cookie.

* The server sends session info in a cookie on your first visit to a site.
* Requests to that site now will append the cookie info to let the server know who the client is.
* On each request the server will see the session id and lookup the associated session data and return what was requested. This is how the server "remembers" the user.

Where is the data stored? Somewhere on the server.

The session id is unique and expires in a relatively short time. When it does, we will have to login again. If we log out, the session id information is gone. If we manually remove the cookie from the inspector, we have essentially logged out.

### AJAX

## Security
If someone got a hold of my sesson id, can they login as me? Can other people peek into my cookies and steal my session id? Etc. Etc.
### Secure HTTP (HTTPS)

Secure HTTP, __HTTPS__, is indicated by the `https://`. Notice the additional `s`. There is usually a lock symbol up there too. Every request/response is encrypted before being transported on the network. The cryptographic protocal used by HTTPS is called TLS (Transport Layer Security). Earlier versions of HTTPS used `SSL` (Secure Sockets Layer).

### Same-origin policy
This is a concept that permits resources originating from the same site to access each other with no restrictions, but prevents accss to documents/resources on different sites. It prevents scripts from one site from manipulating documents from another site. Documents in the same __origin__ must have the same protocol, hostname, and port number.


Web developers often need to have cross domain content access, so Cross-origin resource sharing (__CORS__) was developed. In short, it allows servers to serve resources to permitted origin domains by adding new HTTP headers.

Same-origin policy is important to guard against session hijacking attacks and is a cornerstone of web appliation security.

### Session Hijacking
In short, this is when a hacker gets a hold of your session id.

#### Countermeasures for Session Hijacking


* Set a session expiration time. Expiring sessions after 30 min or so means the attacker has far less time to exploit you.


* use HTTPS across the entire app to minimize the chance your session id will be stolen in the first place.

### Cross-Site Scripting (XSS)
Occurs when you allow users to input HTML of JavaScript that ends up being displayed by the site directly.

For example, a form that is a simple `<textarea>` to do something like allow the user to leave a comment can also allow the user to input raw HTML and JavaScript and submit it to the server.


#### Potential solutions for cross-site scripting
* always sanitize user input. Eliminate problematic input, such as \\<script> tags, or disallowing HTML and JavaScript input altogether in favor of a safer format, like Markdown.



