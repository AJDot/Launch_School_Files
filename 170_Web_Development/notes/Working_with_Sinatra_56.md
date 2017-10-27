# Working with Sinatra
## Introduction
Sinatra is a web development framework meant to speed up development by automating common tasks. If you find you are having any trouble with some of the fundamentals, review the lesson in course 130 on [Packaging Code Into a Project](https://launchschool.com/lessons/2fdb1ef0/assignments) and the [Core Ruby Tools](https://launchschool.com/books/core_ruby_tools) book.

## Rack
Sinatra is Rack compatible so we should understack Rack a bit better.

### Rack Applications
We just created and worked with our own TCP server to process requests. However, there are more robust ones; Ruby comes with one call Webrick. Webrick can be cumbersome though - there is a library called Rack that will help with connecting to Webrick for us. Rack is a generic interface to help application developers connect to web servers and can work with more than just Webrick.

In our diagram of parts and how they fit together, we will essentially be replacing our TCP server that we used with Webrick and our Ruby code with a Rack application. So now these two components make up our entire application server.

### Blog Series on Rack
Notes in this blog series are in the note titled "Blog Series on Rack".

## Sinatra Documentation
[Sinatra Documentation](http://www.sinatrarb.com/intro.html) can be found here.

## Sinatra and Web Frameworks
Now our mental model of how everything fits together is as follows. The server is comprised of Webrick which communicates with the Sinatra framework that can be thought of as wrapping around Rack.

## How Routes Work
Sinatra provides a DSL for defining _routes_. Routes are how a developer maps a URL pattern to some Ruby code. In `book_viewer.rb`:
```ruby
require "sinatra"
require "sinatra/reloader"

get "/" do
  File.read "public/template.html"
end
```

`require "sinatra"` and `require "sinatra/reloader"` cause the application to reload its files every time we load a page. (Makes development a lot nicer)


Change the return value of the block, save the file and refresh the browser (do not restart the server). The browser does update to display the new return value.

## Rendering Templates

Dynamic values are anything you want to change on each page, like the `<title>`. The templating language we will use is `ERB` (_embedded Ruby_). This is also the default templating language in Ruby on Rails. 


```erb
<h1><%= @title %></h1>
```

When rendered,this template will look as follows, if `@title = "Book Viewer"`.

```html
<h1>Book Viewer</h1>
```

Any Ruby code can go between `<%` and `%>`. If you want to display a value you have to use the special start tag `<%=`.

## Summary
* _Sinatra_ is a small web framework.
* HTTP requests handled by Sinatra by creating `routes` for a path or set of paths.
* Routes are created using methods named after the HTTP method to be handled. So, a `GET` request is handled by a routed defined use the `get` Sinatra method.
* _View templates_ can be written in many _templating languages_, such as _ERB_. They provide a place to define the HTML display of a response outside of the route handling it. Templating languages are usually better suited to describing HTML than plain Ruby.
* Routes can specify _parameters_ by using colon followed by the parametter name: `/chapters/:number`. In this case, the value would be accessible within the route using `params[:number]`.
* Code placed in a `before` block is executed before the matching route for every request.
* _View helpers_ are Ruby methods that are used to minimize the amount of Ruby code included in a view template. These methods are defined within a `helpers` block in Sinatra.
* A user can be sent to a new location in a response to a request with _redirection_. This is done in Sinatra using the `redirect` method. The redirection is accomplished by setting the `Location` header in the response. The client looks at the URL in the location header and sends out a new HTTP GET request for the associated resource, which in turn navigates the client to that new location.
* The files in a project can be identified as either _server-side_ or _client-side_ code based on where they will be evaluated.