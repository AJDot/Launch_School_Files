# What does it mean for HTTP to be "stateless"? What are the benefits and downfalls of this type of protocol?

State is the concept of data persisting over time and, in the case of HTTP, persisting over requests.

`Stateless` means that each request/reponse is not affected by any previous requests/responses. When a request/response is sent/received, its effects are never influenced by previous requests/responses.

## Benefits
1. The server never has to keep any data from a request/response. 
2. There will never be any data buildup or logs or need for cleanup of broken requests.

## Downfalls
1. Maintaining a sense of "state" is more difficult. Ex: from request to request, a server will not have knowledge that you signed in.
2. Tricks must be utilize to create the effect of a stateful application. Sessions, cookies, and AJAX are all ways to make HTTP seem stateful.