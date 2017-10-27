# Explain the difference between GET and POST, and know when to choose each.

A GET request is asking the client to go retrieve a resource at the URL or IP address entered. This is the default behavior of all links. the response of a GET request can be anything. If it is HTML and that HTML references other resources, then the browser will automatically retrieve them (a pure HTML tool will not).
Information is sent in the **URL**.

A POST request is used to send or receive data to/from a server. Larger chunks of information can be sent this way using a form submission. This is how sensitive information should be sent. Information sent by a POST request are sent in the HTTP **body**. Information is a POST request usually alters something on the server side (ex: creating/updating/deleting a file).