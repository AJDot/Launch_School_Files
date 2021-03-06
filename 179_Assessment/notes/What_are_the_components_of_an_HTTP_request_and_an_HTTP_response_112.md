# What are the components of an HTTP request and an HTTP response?

## HTTP Response
* Status
* Headers (optional)
* Body    (optional)

### Status Code
A three-digit number that signifies the status of the response.
Some common status codes
| Status Code | Status Text | Meaning |
| ----------- | ----------- | ------- |
| 200 | OK | The request was handled successfully |
| 302 | Found | The requested resource has changed temporarily. Usually results in a redirect to another URL. |
| 404 | Not Found | The requested resource cannot be found. |
| 500 | Internal Server Error | The server has encountered a generic error. |

### Response Headers
Offers information about the resource being sent back. Some useful headers:
| Header Name | Description | Example |
| ----------- | ----------- | ------- |
| Content-Encoding | Tye type of encoding used on the data. | Content-Encoding: gzip |
| Server | Name of the server. | Server:this 1.5.0 codename Knife |
| Location | Notify client of new resource location | Location: https://www.github.com/login |
| Content-Type | The type of data the response contains. | Content-Type:text/html;charset=UTF-8 |

### Response Body
The raw response data.


## HTTP Request
* Method
* Path
* Params  (optional)
* Headers (optional)
* Body    (optional)
### What are some useful request headers?

| Field Name | Description | Example |
| ---------- | ----------- | ------- |
| Host | The domain name of the server | Host: www.reddit.com |
| Accept-Language | List of acceptable languages. | Accept-Language: en-US,en;q=0.8 |
| User-Agent | A string that identifies the client. | User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5)...... etc |
| Connection | Type of connect the client would prefer. | Connection: keep-alive |