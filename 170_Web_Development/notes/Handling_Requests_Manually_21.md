# Handling Requests Manually
## Introduction

Remember, HTTP is just an exchange of textual information between client and server.

## Some Background and Diagrams
### Client-Server
HTTP - a stateless protocol for how clients communicate with servers.

Client  --- (http request) ---> Server
Client <--- (http response) --- Server

Now zoom in on the Server part of this picture.

Server has three main components: _web server_, _application server_, _data store_. This is hugely oversimplified but enough for our purposes right now.


_application server_ - where application or business logic resides - where more complicated requests are handled. This is where your server-side code lives when deployed.

_data store_ - often consulted by the application server, like a relational database, to retrieve or create data. They can be simple file, key/value stores, document stores, etc, as long as it can save data in some format for later retrieval and processing.

### HTTP over TCP/IP

Now zoom in on the middle part, the request and response.

HTTP relies on a TCP/IP connection (most of the time). So how are HTTP and TCP/IP related?



### Coding Along with This Course


For us, our entire application is comprised of our TCP server and some Ruby code.

Server is composed of our TCP server and our Ruby code. Requests and Responses go to and from the TCP server.

## Practice Problems: URL Components
1. Given the URL:
    ```
    https://amazon.com/Double-Stainless-Commercial-Refrigerator/B60HON32?ie=UTF8&qid=142952676&sr=93&keywords=commercial+fridge
    ```
    a.  Identify the __host__
        `amazon.com`
    b.  Identify the __names__ of the __query parameters__
        `ie`, `qid`, `sr`, `keywords`
    c. Identify the __values__ fo the __query parameters__
        `UTF8`, `142952676`, `93`, `commercial+fridge`
    d. Identify the __protocol__
        `https`
    e. Identify the __path__
        `/Double-Stainless-Commercial-Refrigerator/B60HON32`
    f. Identify the __port__
        `443` is typically used for secure HTTP (`https`) but that information is not contained with the URL


2. Add the port `3000` to the following URL:
    ```
    http://amazon.com/products/B60HON32?qid=142952676&sr=93
    ```
    ```
    http://amazon.com:3000/products/B60HON32?qid=142952676&sr=93
    ```
    
    
3. Given the following URL:
    ```
    http://localhost:4567/todos/15
    ```
    a. Identify the __query parameters__
        There are no query parameters
    b. Identify the __protocol__
        `http`
    c. Identify the __path__
        `/todos/15`
    d. Identify the __host__
        `localhost`
    e. Identify the __port__
        `4567`



    The first way is to use `%20`.
    The second way is to use a `+` sign
    
    `?`
    
6. What character is used between the name and value of a query parameter?
    `=`

7. What character is used between multiple query parameters?
    `&`

## Summary
* Can interact with HTTP manually because it is a _text-based protocol_.
* HTTP is built on top of _TCP_, the transport networking layer that handles communicating between two computers.
* _URLs_ are made up of many components: a protocol, a host, a port, a path, and parameters.
* _Query parameters_ are parameteres that are included in a URL. `?` signifies their start and they are written in the `key=value` form.
* Use `&` to append more parameters.
* HTTP is stateless. By carefully craftings URLs and parameters, stateful interactions can be built on top of HTTP.
