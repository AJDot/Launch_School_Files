# How does an HTML form element interact with the server-side code that processes it.
An HTML form element has a `method` and a `action`. 

The `method` specifies what HTML method is to be used. In the applications we have built, `GET` and `POST` would be the options. Typically a form will be used for the `POST` method and not for the `GET` method. This specificies how data will be sent to the server, in the URL (a `GET` request) or in the request body (a `POST` request).

The `action` specifies the path of the request to be handled by the server.

Data is stored in the `params` hash where the keys are the `name`s of each HTML tag (ex `<input name="key" value="value"/>`) which can be accessed in routes using `params[:key]`.