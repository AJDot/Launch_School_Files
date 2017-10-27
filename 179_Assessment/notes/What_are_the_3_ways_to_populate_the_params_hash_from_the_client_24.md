# What are the 3 ways to populate the `params` hash from the client?
1. Query parameters from a `GET` request which are sent in URL. `http:example.com?id=value`
3. Form data from a `POST` request. The name in the params hash is the name given to the HTML element. `<input name="id" value="value"/>`
