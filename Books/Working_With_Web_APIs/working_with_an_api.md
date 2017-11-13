# Working with an API
## Fetching Resources
### Fetching a Resource
My server name is `ls-web-store`
```bash
$ http GET http://book-example.herokuapp.com/v1/products/1
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 53
Content-Type: application/json
Date: Mon, 22 Sep 2014 19:55:17 GMT
Server: Cowboy
Status: 200 OK
Via: 1.1 vegur

{
    "id": 1,
    "name": "Red Pen",
    "price": 100,
    "sku": "redp100"
}
```
* The *media type* is *application/json*.
* The *status* is *200 OK*.
* The *body* is in *JSON* format.

The body respresents a single **resource** which is a single product here.

### What is a Resource?
A representation of some grouping of data. For a blog API: a post, section, tag, comment, etc. For a bank API: account, transaction, etc.

### Fetching a Collection
```bash
$ http GET http://book-example.herokuapp.com/v1/products
HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 166
Content-Type: application/json
Date: Tue, 23 Sep 2014 01:30:07 GMT
Server: Cowboy
Status: 200 OK
Via: 1.1 vegur

[
    {
        "id": 1,
        "name": "Red Pen",
        "price": 100,
        "sku": "redp100"
    },
    {
        "id": 2,
        "name": "Blue Pen",
        "price": 100,
        "sku": "blup100"
    },
    {
        "id": 3,
        "name": "Black Pen",
        "price": 100,
        "sku": "blap100"
    }
]
```

* The *media type* is *application/json*.
* The *status* is *200 OK*.
* The *body* is in *JSON* format.

This represents a **collection** resource.

### Elements and Collections
**Elements**: represent a single resource. Operations will use that resource's path.
**Collections**: represent a grouping of element of the same type. Usually a parent-child relationships.
```
/api/blog/posts
/api/blog/post/1
```
The first represents a resource and the second is a collection.

#### How to know if a URL is for a collection or a resource?
Look at its path (and of course the API's official documentation).
Signs for a collection:
1. The path ends in a plural word, *example.com/products*
2. The response body contains multiple elements

Signs for an element:
1. The path ends in a plural word, a slash, and then what could be an identifier (numeric or alphabetic)
2. The response body contains a single element

### Summary
* APIs provide access to single resources (**elements**) or groups of resources (**collections**).
* The path for an element is usually the path for its collection, plus an identifier for that resource.

## Requests in Depth
### GET and POST
All request start with an **HTTP method** (called a **verb**). GET and POST are the most common.

### Parts of a Request
Analyze the request header by using `--print H` in the HTTPie line.
```bash
http --print H GET http://ls-web-store.herokuapp.com/v1/products/1
GET /v1/products/1 HTTP/1.1
Accept: */*
Accept-Encoding: gzip, deflate
Connection: keep-alive
Host: ls-web-store.herokuapp.com
User-Agent: HTTPie/0.9.2
```
```bash
GET /v1/products/1 HTTP/1.1
```
This tells *which resource* and *what action* the client wants.

```bash
Accept: */*
```
**Very important**. Specifies what media types the client will accept in response to this request. This example means *anything*. Since this web server return JSON by default, a more specific request should be used.

```bash
http --print=H GET http://ls-web-store.herokuapp.com/v1/products/1 Accept:application/json
GET /v1/products/1 HTTP/1.1
Accept: application/json
Accept-Encoding: gzip, deflate
Connection: keep-alive
Host: ls-web-store.herokuapp.com
User-Agent: HTTPie/0.9.2
```

### Summary
* HTTP requests include a path, method, headers, and body.
* The **Accept** header tells the provider what media types can be used to respond to the request.

## Creating Resources
### Creating a Resource
Involves making changes to the resources on the server. POST is the most common HTTP method to do this.

To add a new product to the web store system.
```bash
http -a admin:password POST ls-web-store.herokuapp.com/v1/products name="Purple Pen" sku="purp100" price=100
HTTP/1.1 201 Created
Connection: keep-alive
Content-Length: 56
Content-Type: application/json
Date: Mon, 13 Nov 2017 14:11:39 GMT
Server: Cowboy
Status: 201 Created
Via: 1.1 vegur

{
    "id": 4,
    "name": "Purple Pen",
    "price": 100,
    "sku": "purp100"
}
```

* The **media type** is *application/json*.
* The **status** is *201 Created*. In the 200s so we know it's successful. This one means a resource was created successfully.
* The **body** is in *JSON* format.

### Handling errors
There may be a useful message when an error occurs, maybe not.

#### Missing or Invalid Parameters
**Validations** to ensure all data in system is valid and complete. Programs are dependent on the structure, format, and type of data in order to operate correctly.
Example of request without all required info.
```bash
$ http -a admin:password POST book-example.herokuapp.com/v1/products
HTTP/1.1 422 Unprocessable Entity
Connection: Keep-Alive
Content-Length: 97
Content-Type: application/json
Date: Mon, 29 Sep 2014 03:05:22 GMT
Server: WEBrick/1.3.1 (Ruby/2.1.2/2014-05-08)

{
    "message": "name is missing, sku is missing, sku is invalid, price is missing",
    "status_code": 422
}
```
* The **status** is *422 Unprocessable Entity*. Since the code is in the *4xx* format, we know the request was not successful. *Unprocessable Entity* is a cryptic way of saying the request was invalid in a way that prevented the server from working with it. This is often caused by a validation error.
* The **body** is in JSON format, but instead of being the representation of a product, it is an error message. The `message` string contains an explicit list of problems with the request: `name is missing, sku is missing, sku is invalid, price is missing`.

#### Missing Resources
Trying to access a resource that doesn't exist. The HTTP status code for this is *404 Not Found*.
```bash
$ http book-example.herokuapp.com/v1/products/42
HTTP/1.1 404 Not Found
Connection: Keep-Alive
Content-Length: 75
Content-Type: application/json
Date: Mon, 29 Sep 2014 07:14:44 GMT

{
    "message": "Couldn't find WebStore::Product with 'id'=42",
    "status_code": 404
}
```
There are a few common causes for this type of error when working with APIs:

* The resource might not actually exist. It could have been deleted or perhaps it was never there in the first place. Verify that any parameters in the request are correct, especially identifiers.
* The URL could be incorrect. APIs can have a variety of different URL schemes, from the simple and short to the long and complex. Be sure to look in the documentation for the API you are working with to see what hosts and paths to use. Keep in mind that services with different environments for testing and production will often have a unique URL for each environment.
* Accessing the requested resource may require authentication. In an ideal world, these errors would use a more accurate HTTP status code of *401* or *403*, but for security reasons, it is sometimes better to only expose the existence of a resource to those who are authorized to access it.

#### Authentication
Many systems require it on some or all APIs. `401` `403` `404` errors are usually here and can be resolved by sending valid credentails.

#### Incorrect Media Type
JSON is the most common format. HTTPie automatically converts a request to JSON. Use `--print HBhb` to view it.
```bash
$ http --print HBhb -a admin:password POST book-example.herokuapp.com/v1/products name="Purple Pen 2.0" sku="purp101" price=100
POST /v1/products HTTP/1.1
Accept: application/json
Accept-Encoding: gzip, deflate
Authorization: Basic YWRtaW46cGFzc3dvcmQ=
Content-Length: 60
Content-Type: application/json; charset=utf-8
Host: book-example.herokuapp.com
User-Agent: HTTPie/0.8.0

{
    "name": "Purple Pen 2.0",
    "price": "100",
    "sku": "purp101"
}

HTTP/1.1 201 Created
Connection: close
Content-Length: 60
Content-Type: application/json
Date: Tue, 23 Sep 2014 18:15:42 GMT
Status: 201 Created

{
    "id": 5,
    "name": "Purple Pen 2.0",
    "price": 100,
    "sku": "purp101"
}
```

The request:
* **Content-Type** is `application/json; charset=utf-8`.
* **body** is indeed in JSON format.

#### Rate Limiting
APIs may support many users that use automated systems to access them. This can lead to thousands or millions of requests in a short time span. Most APIs address this by enforcing **rate limiting**. Each consumer is allotted a certain number of requests in a given time. Once reached, usually a *403 Forbidden* status code is returned.
Usually, you can just perform the request less often to mitigate this. Store a response locally to reduce the number of requests being made.

#### Server Errors
Status codes in the *5xx* range.
* A bug or oversight in the server implementation. Sometimes these can result from the correct and intended usage of an API.
* A hardware or other infrastructure problem with the remote system.
* Any other error that was not foreseen by the remote server implementors.
* Some APIs even return 5xx errors when a specific client error would be more accurate and useful.

Usually not useful to the consumer.

### Summary
* Resources can be created with POST requests.
* Requests should include all required parameters and use the proper media type.
* Responses to failed requests will often contain information about the cause of the failure.

## More HTTP Methods
### Updating a Resource
**PUT** should be used to **update** the value of a resource. It says *put this resource in this place*. A PUT request must take a complete representation of the resource being updated. It a parameter is required to create a resource, it is required to be sent in any PUT requests modifying that resource. Anything left out will be nil or null. Most APIs don't follow this and provide simpler behavior by updating only parameters that were sent. (This is technically a PATCH method.)
```bash
$ http -a admin:password PUT book-example.herokuap.com/v1/products/5 price=150
HTTP/1.1 200 OK
Connection: close
Content-Length: 60
Content-Type: application/json
Date: Thu, 02 Oct 2014 05:41:07 GMT
Status: 200 OK

{
    "id": 5,
    "name": "Purple Pen 2.0",
    "price": 150,
    "sku": "purp101"
}
```

Price of product with `id` of `5` has been changed to `150`.

### Deleting a Resource
Use the **DELETE** HTTP method.
```bash
$ http -a admin:password DELETE book-example.herokuapp.com/v1/products/5
HTTP/1.1 204 No Content
Connection: close
Date: Thu, 02 Oct 2014 05:51:34 GMT
Status: 204 No Content
```
`204 No Content` means successful and is returned usually when there is no response body.

### Summary
* Use HTTP method PUT to update resources.
* Use HTTP method DELETE to delete resources.
