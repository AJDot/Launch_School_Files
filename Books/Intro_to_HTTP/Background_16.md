# Background
## Background
### A Brief Overview & History
HTTP, Hypertext Transfer Protocol, was invented by Tim Berners-Lee in the 1980s. It is a _system of rules_ to transfer hypertext documents. It is a __request transfer protocal__ - a __client__ (your browser) makes a request to a __server__ and waits for a __response__. The response is the data you requested (hopefully).
HTTP has gone through changes since its beginning:
* 1991 - HTTP/0.9
* 1992 - HTTP/1.0 - able to transmit more than HTML (CSS, videos, scripts, images)
* 1995 - HTTP/1.1 - ability to reuse established connections for further requests, and other features
* 1999 - still HTTP/1.1 - further changes made it into what we have today
* future - HTTP/2 - in early stages of development

### How the Internet Works
* Composed of millions of interconnected networks.
* All devices in a network are provided a unique label - Internet Protocol Address (__IP Address__)
```
192.168.0.1       # Without port
192.168.0.1:1234  # With port
```
A device or server can have thousands of ports all for different communication purposes.


#### DNS
Domain Naming System - a mapping from URL to IP address. Translates computer names like http://www.google.com to an IP address and maps the request to a remote server. Essentially it keeps an address book of URLs and their corresponding IP addresses. To store this information __DNS servers__ are used.

The typical interaction with the internet:
1. Enter URL into web browser (e.g. http://www.google.com)
3. Request goes over Internet to search for IP address associated with the URL.
4. The remote server accepts the request and sends a response over the Internet to your network interface which hands it to your browser.
5. Your browser displays the response in the form of a webpage.

The only thing ever being sent or received is plain text. The reason everything works is because both the server and client agree to use the same protocol (HTTP in this case).

** For clarity, it is the ISP that sends the request over the internet to the IP address. The DNS server simply retrieves the IP address associated with the URL inputted into the client. 

### Clients and Servers
__Web Browser__ - most common client. They issue HTTP requests and process the HTTP response to the screen.

Server - where the content you are requesting is located. They are capable of handling inbound requests and issuing a response back

### Resources 
Basically everything - images, videos, web pages, software, games, etc.

### Statelessness
__stateless__ - a protocol is such when it is designed so that a request/response is completely independent of the previous one.

## What is a URL?
### Introduction
A __URL__ is like an address or phone number you need to communicate with someone. It is the most frequently used part of the general concept of a Uniform Resource Identifier (__URI__).

### URL Components
Take this URL for example: "http://www.example.com:88/home?item=book". There are 5 parts to this:
* `http`: The __scheme__. Tells the web client how to access the resource. Here, it says to use Hypertext Transfer Protocol. Other popular URL schemes are `ftp`, `mailto`, or `git`.


* `www.example.com`: The __host__. Tells client where the resource is hosted/located.


* `:88`: The __port__ or port number. Only require is you want to use a port other than the default.


* `/home/`: The __path__. Shwo what local resource is being requested. Optional


* `?item=book`: The __query string__, made up of __query parameters__. It is used to send data to the server.

The path can point to a very specific resource `/home/index.html` points directly to the HTML file.

The default port is `80`. Unless specified, port `80` will be used in normal HTTP requests.

### Query Strings/Parameters
Here is a simple URL query string:
```
http://www.example.com?search=ruby&results=10
```
| Query String Component | Description |
| ---------------------- | ----------- |
| ? | Reserved character that marks the start of the query string. |
| search=ruby | Parameter name/value pair |
| & | Reserved character - to add more parameters to the query string |
| results=10 | Parameter name/value pair |

Another Example
```
http://www.phoneshop.com?product=iphone&size=32gb&color=white
```
Here there are 3 name/value pairs. How the server uses this data is up to the server application.

__Because query string are passed in through the URL, htey are only used in HTTP GET requests__. More on this later.

There are some limitations to query strings:
* Space and special characters like `&` cannot be used and must be URL encoded.

### URL Encoding
By default only certain characters are accepted in URLs. Others, like unsafe or reserved characters must be encoded. This is accomplished by replacing the non-conforming characters with a `%` followed by two hexadecimal digits that represent the ASCII code of the character.

Some common encodings:
| Character | ASCII code |
| --- | --- |
| Space | 20 |
| ! | 21 |
| + | 2B |
| # | 23 |

Characters must be encoded if:
* it is a reserved character in the URL scheme. e.g. `/`, `?`, `:`, `@`, and `&` must be encoded.
