# HTTP Response Headers

The following is a list of some of the most common HTTP response headers encountered when working with web APIs. There is a [more complete list on Wikipedia](https://en.wikipedia.org/wiki/List_of_HTTP_header_fields#Response_fields).

## Access-Control-Allow-Origin

Lists what domains can access this resource using [CORS](https://en.wikipedia.org/wiki/Cross-origin_resource_sharing). This header would allow all sites:
```
Access-Control-Allow-Origin: *
```

## Allow

Used with a `405 Method Not Allowed` response to a request with an invalid HTTP method. The value of this header lists what methods are allowed.
```
$ http --print=h POST www.google.com
HTTP/1.1 405 Method Not Allowed
Allow: GET, HEAD
...
```

This header is not always returned with `405 Method Not Allowed` responses.

## Content-Length

The length of the response body in bytes.
```
Content-Length: 1984
```

## Content-Type

Describes the *media type* or format of the body. Common values include `application/json` and `application/xml`. For a fairly complete list of media types, see [Wikipedia](https://en.wikipedia.org/wiki/Internet_media_type#List_of_common_media_types).

This field will often include a `charset` attribute as well:
```
Content-Type: application/json; charset=utf-8
```

## ETag
```
ETag: "6df23dc03f9b54cc"
```
Used to identify a specific version of a resource. Any changes to the resource will result in a new value for `ETag`.

The value returned in this header can be sent with future requests to the same URL in the `If-None-Match` header. If the resource has not changed, the provider will respond with `304 Not Modified`. If the resource has changed, the response should include the entire resource in its updated state, along with a new `ETag`.

This scheme is used to avoid fetching and processing data that has not been updated since the last time it was accessed.

## Last-Modified
```
Last-Modified: Thu, 05 Jul 2012 15:31:30 GMT
```
The last time the requested resource was modified.

The date and time returned in this header can be sent with future requests to the same URL in the `If-Modified-Since` header. If the resource has not changed, the provider will respond with `304 Not Modified`. If the resource has changed, the response should include the entire resource in its updated state, along with a new value for `Last-Modified`.

This scheme is used to avoid fetching and processing data that has not been updated since the last time it was accessed.

## WWW-Authenticate

Indicates what type of authentication is required to access a resource. A resource that required HTTP basic authentication would include a header like this:

WWW-Authenticate: Basic
X-* Headers

Naming headers with names beginning with X- is a convention for headers that aren't standardized. These headers are often API or application-specific. [GitHub uses some of these headers to provide the status of rate limiting](https://developer.github.com/v3/#rate-limiting) with each request:
```
➜  api_book_content git:(master) ✗ http https://api.github.com/user
HTTP/1.1 401 Unauthorized
...
X-RateLimit-Limit: 60
X-RateLimit-Remaining: 57
X-RateLimit-Reset: 1413592144
...
```
