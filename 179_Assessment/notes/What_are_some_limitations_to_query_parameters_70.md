# What are some limitations to query parameters?

* Query string have a maximum length. So large amounts of data cant be passed using this method.
* All the name/value pairs used are visible in the URL. So sensitive information should never be passed in this way.
* Spaces and other special characters (like `&`) cannot be used an dmust be URL encoded.