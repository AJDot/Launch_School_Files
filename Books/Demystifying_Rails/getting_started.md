# Getting Started
## HTTP and Web Development Review
### HTTP and Web Apps
**The fundamental paradigm of a web application is to react to an HTTP request and to create an appropriate HTTP response.**

#### The Client-Server Model
In Rails web apps, the client is a browser and the Rails app runs on the server.
After the client sends a HTTP request to the server, Rails will:
1. figure out where to direct the request to be processed.
2. process the request with pre-defined logic
3. construct a response
Then the app send an HTTP response back to the browser and the browser displays the it.

#### Every Client-Server Interaction Begins with an HTTP Request
A request has 3 parts:
1. request line
2. request headers
3. request message body

In this book we are focused on only two parts of the request line:
1. the **request verb** (a.k.a. **request method**)
2. the **request path** (that part of the url after the `/`)

#### Every Client-Server Interaction Ends with a HTTP Response
Each response has 3 parts:
1. status code - general result of process (good? bad?)
2. headers - how the client should handle the response (`Content-Type`, `Location`)
3. body - can be empty but usually is an HTML document

#### The Web Application in the Middle
It interprets the request, pulls database data if needed, follows pre-defined rules, generates the response that carries the HTML to display.

## Our First App
### Set Up Starter App
Use this starter app for the first two sections of this book.
```bash
# make sure to use ruby version 2.2

$ git clone https://github.com/launchschool/demystifying_rails_app_template
$ cd demystifying_rails_app_template
$ bundle exec bundle install
$ bundle exec rails server
```
App will be located at `http://localhost:3000/`.

### Outlining Our First App
Make the app respond to HTTP request. Want a request from `/hello_world` to result in the text `Hello, world!` being displayed.
Rails does this in two steps:
1. define where the request should go
  Accomplished by declaring a **route**.
2. define the code to handle the request of this kind.
  Accomplished by defining a method on a **controller**. This type of method on a controller containing logic for handling a request is called an **action**.
