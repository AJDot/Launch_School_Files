# How can a stateless protocol seem "stateful"?

The are at least 3 methods for making a web app feel stateful:

## Sesssions
The server sends the client a **session identifier** that the client then attaches onto every request. This then tells the server who the client is.

This means every request must be checked for its session id. If found, the server must perform another check to make sure the session id is still valid. Then the server needs to retrieve the session data and recreate the state to send back to the client.

## Cookies
Cookies are data sent from the server and stored on the client. These are files used to store session information. When you visit a website a **set-cookie** response header is sent back to the client. This stores the session on the client. Upon further requests, this session data is sent back to the server and the server uses it to verify the session and the correct client. When you login to a website, unique session information is stored in this cookie that gets sent back to the server.

## AJAX
Asynchronous JavaScript and XML.

It allows for page data to be updated without having to reload the entire page. When actions are taken using AJAX, the page does not refresh.