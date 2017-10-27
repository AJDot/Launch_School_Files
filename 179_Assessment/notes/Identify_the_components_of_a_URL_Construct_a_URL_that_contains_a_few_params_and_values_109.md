# Identify the components of a URL. Construct a URL that contains a few params and values.

A URL contains several components detailing the location of the server as well as data needing to be transfered and other information:

* **scheme**: This describes how the content needs to be accessed. In this course, `http` is the protocol, or scheme, used to make a request.
* **host**: This is the location where the resource/website is hosted.
* **port**: The particular channel to use as communication with the intended server. Optional (80 is used by default)
* **path**: specifies what local resource is being requested. Also optional.
* **query string**: data sent to the server. Optional. Used by server to make decisions/affect the HTTP response.

Example URL:
```http
http://www.example.com:3000/index?request=info
```

In the example above:
* scheme: `http`
* host: `www.example.com`
* port: `3000`
* path: `/index`
* query string: `?request=info`

In the query string, the query parameter `request` has the value `info`. `&` will be used to separate multiple query paramters.

** Query parameters are only used in HTTP GET requests**. 

My Example:
```http
https://www.runtracker.com:5000/runs?data=2017-07-18
```
* scheme: `https`
* host: `www.runtracker.com`
* port: `5000`
* path: `/runs`
* params=value: `data=2017-07-18`

