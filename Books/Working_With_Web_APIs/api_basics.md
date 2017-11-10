# API Basics

## What is an API?
**Application Programming Interface** provides functionality for use by another program.

* API provider: the system that provides an API for other parties to use.
* API consumer: the system that uses the API to accomplish some work.

Client and Server is this context will generally refer to the consumer and provider respectively.

### Summary

* *Web APIs* allow one system to interact with another over HTTP (just like the web).
* The system offering the API for use by others is the *provider*.
* The system interacting with the API to accomplish a goal is the *consumer*.
* It is best to prefer the terms *provider* and *consumer* over *client* and *server*.

## What APIs Can Do

* Sharing Data
* Enabling Automation
  * APIs allow users of a service to make use of it in new and useful ways.
* Leverage Existing Services
  * APIs enable application developers to build their applications on top of a variety of other specialized systems, allowing them to focus on their actual objectives and not worry about all the complexities of every part of the system.
  * Like accessing Instragram's APIs to find photos with geographic locations.

### Summary
* APIs break down the walls between systems, allowing them to share data.
* APIs provide an "escape hatch" enabling service users to customize the software's behavior or integrate it into other systems if required.
* Many modern web applications provide an API that allows developers to integrate their own code with these applications, taking advantage of the services' functionality in their own apps.

## Accessibility
### Public and Private
**Public APIs**: Intended for consumption outside the organization.
**Private APIs**: Used internally. Even though it may be possible to call private APIs, don't, for ethical, technical, and possible legal reasons.

### Terms and Conditions
Accesssing APIs carries ethical and legal responsibilities. Keep in mind the following:
* **What restrictions does the API place on your use of its data?** For example, data from the Amazon Product Advertising API [can not be used on mobile devices](https://affiliate-program.amazon.com/gp/advertising/api/detail/agreement.html) or TV set top boxes, nor can it be stored for more than 24 hours.
* **Is the API exposing any data that could be linked back to a person?** Many social applications allow access to a user's personal information, and by accessing it, you are taking on the responsibility of keeping this information safe and secure.
* **Does the API have rate limits, and if so, what are they?** Many APIs limit how many requests can be sent from a single user or application within a given time frame. Such restrictions can have an impact on the design of programs that interact with their APIs.

### Summary
* APIs come in two flavors, public and private. You will generally work with public APIs. Using private APIs is most common when they are your own.
* API usage is often conditional on the acceptance of a set of terms set by the API provider.

## HTTP Review
### Summary
* Web APIs are built on top of HTTP, the technology that makes the web work.
* HTTP Responses have 3 main parts: status code, headers, and body.
* The Content-Type header describes the format of the response body.

## URL Review

* A **protocol**, such as http
* ://, a colon and two slashes
* A **hostname**, usually a domain name such as blogs.com
* An optional colon and **port**, such as :81
* The **path** to the resource, such as /api/v1/pages/1
* An optional **query string**, such as ?query=term

### Summary
* Working with web APIs involves working with URLs.
* URLs represent where a resource is and how it can be accessed.
* URLs typically contain a protocol, hostname, path, and sometimes a query string.
* Paths (and URLs) can include placeholders when they are written generically.

## Media Types
Also called **content types** or **MIME types**.

Example: **HTML**. In the HTTP response there will be a `Content-Type` header like so:
```
Content-Type: text/html
```
Most have a `charset` included too:
```
Content-Type: text/html; charset=UTF-8
```
Other `Content-Types` includes `text/plain` for plain text, `text/css` for CSS stylesheets, `text/javascript` for JavaScript files.

### Data Serialization

A **data serialization format** describes a way for programs to convert data into a form which is more easily or efficiently stored or transferred

### XML
**extensible markup language**
Example of data represented with XML
```xml
<address>
    <street>1600 Pennsylvania Ave NW</street>
    <city>Washington</city>
    <state>DC</state>
    <zipcode>20500</zipcode>
    <country>Unites States</country>
</address>
```

### JSON
**JavaScript Object Notation**
Exmaple:
```json
{
  "street": "1600 Pennsylvania Ave NW",
  "city": "Washington",
  "state": "DC",
  "zipcode": "20500",
  "country": "United States"
}
```
Example:
```json
{
  "object": {
  	"city": "Boston"
  },
  "array": [1, 1, 2, 3, 5],
  "string": "Hello, World!",
  "number": 8675.309
}
```

### Summary
* Media types describe the format of a response's body.
* Media types are represented in an HTTP response's Content-Type header, and as a result, are sometimes referred to as content types.
* JSON is the most popular media type for web APIs and the one this book will focus on.

## REST and CRUD
### What is REST?
**representational state transfer**
A set of conventions for how to build APIs.
* *representational* refers to how a representation of a resource is being transferred, and not the resource itself.
* *state transfer* refers to how HTTP is a stateless protocol. This means that servers don't know anything at all about the clients, and that everything the server needs to process the request (the state) is included in the request itself.

A good way to think about REST is as a way to define everything you might want to do with two values, what and how:

* What: Which resource is being acted upon?
* How: What is happening to the resource?

## CRUD
* **C** reate
* **R** ead
* **U** pdate
* **D** elete

RESTful APIs will model most functionality by matching one of these operations to the appropriate resource.

Example:
| Objective | How | How | What |  What |
| --- | --- | --- | --- | --- |
| | Operation | HTTP Method | Resource | Path |
| Get the information about a profile | Read | GET | Profile | /profiles/:id |
| Add a profile to the system | Create | POST | Profiles Collection | /profiles |
| Make a change to a profile | Update | PUT | Profile | /profiles/:id |
| Remove a profile from the system | Delete | DELETE | Profile | /profiles/:id |

A Template for a RESTful API
| Objective | How | How | What | What |
| --- | --- | --- | --- | --- |
|| Operation | HTTP Method | Resource | Path |
| Get the information about a $RESOURCE | Read | GET | $RESOURCE | /$RESOURCEs/:id |
| Add a $RESOURCE to the system | Create | POST | $RESOURCEs Collection | /$RESOURCE |
| Make a change to a $RESOURCE | Update | PUT | $RESOURCE | /$RESOURCEs/:id |
| Remove a $RESOURCE from the system | Delete | DELETE | $RESOURCE | /$RESOURCEs/:id |


> A RESTful design is one in which any action a user needs to make can be accomplished using CRUD operations on one or many resources. It can take a while to get used to thinking in a resource-oriented way since translating verb-oriented functionality (deposit \$100 into this account) into noun- or resource-oriented actions (create a new transaction with an amount of $100 for this account) needs a change of perspective.
>
> Since the only actions that can be taken on a resource are create, read, update, and delete, the creative side of RESTful design lies in what resources are exposed to allow users to accomplish their goals. The limitation of only choosing the resources and their relationship can feel sort of similar to designing a database schema, in that the same basic CRUD actions apply to rows in a database table.

**Simple Yet Not So Simple Example**
| Objective | How | | What | | Attributes |
| --- | --- | --- | --- | --- | --- |
| | Operation | HTTP Method | Resource | Path | |
| Create an order | Create | POST | Orders | /orders | |
| Add an item to the order | Create | POST | LineItem | /line_items | order_id, product_id |
| Add a second item to the order | Create | POST | LineItem | /line_items | order_id, product_id |
| Create an address to use for shipping and billing | Create | POST | Address | /addresses | street, city, state, postal_code, country |
| Update the order with the shipping and billing addresses | Update | PUT | Address | /addresses/:id | shipping_address_id, billing_address_id |
| Add a credit card to the system for use as payment | Create | POST | CreditCard | /credit_cards | number, crc, name, expiration_date, billing_address_id |
| Set the order to use the credit card for payment | Create | POST | PaymentMethod | /payment_methods | order_id, credit_card_id, amount |
| Complete and submit the order | Create | POST | OrderPlacement | /orders/:id/placement | - |

### Summary
* REST is a set of conventions about how to build APIs.
* RESTful APIs consist of CRUD actions on a resource
* By limiting actions to CRUD, REST requires thinking in a resource-oriented way.
* It is worth being as RESTful as possible, but there are times when it is not the best solution.
