# Blog Series on Rack
## Part 1
### What is Rack?
Rack is a web server interface that provides a fluid API for creating web applications. In some ways you can think of Rack as a protocol or specification since some frameworks adhere to the Rack interface, (like Sinatra and Rails). So Rack provides a consistent interface when working with Rack compatible servers.

### What Makes a Rack Application
It allows us to utilize a standardized methodology for communicating HTTP requests and responses between the client and the server. There are some very specific conventions that need to be followed in a Rack application:

  1. Create a `rackup` file: this is a configuration file that specifies what to run and how to run it. A rackup file uses the file extension `.ru`.
  2. The rack application we use in the rackup file must be a Ruby object that responds to the method `call(env)`. The `call(env)` method takes one argument, the environment variables for this application.
  
The `call` method always returns an array containing these 3 elements:

  1. Status Code: represented by a string or some other data type that responds to `to_i`.
  2. Headers: in the form of key-value pairs inside a hash. Key is header name. Value will the the value for the header.
  3. Response Body: can be anything, as long as the object can respond to an `each` method. An `Enumerable` object would work, as would a `StringIO` object, or even a custom object with an `each` method. The response is never just a `String` itself but it _must_ `yield` a String value.

### A Simple Rack Application - Hello World!
We need a "rackup" file. The default name for one is `config.ru`. Create it with the following.
```ruby
# config.ru

run HelloWorld.new
```

We require `hello_world.rb`, will call the `run` method with a new `HelloWorld` object. The `HelloWorld` object will act as our web application and is where most of our application code will be.

Create this:
```ruby
# hello_world.rb

class HelloWorld
  def call(env)
  end
end
```

To test, run:
```
bundle exec rackup config.ru -p 9595
```
We chose to use a port `9595`. `rackup` will use a default port of `9292`

Ping the server:
```bash
$ curl -X GET localhost:9595 -m 30 -v
HTTP/1.1 200 OK
Content-Type: text/plain
Transfer-Encoding: chunked

Hello World!
```

Rack is using whatever server installed, in this case, Webrick.

### Conclusion

## Part 2
### Application Environment - env
What about that `env` argument? What is it? If we inspect it we might get something like this:
```
GATEWAY_INTERFACE : CGI/1.1
PATH_INFO : /
QUERY_STRING :
REMOTE_ADDR : 127.0.0.1
REMOTE_HOST : 127.0.0.1
REQUEST_METHOD : GET
REQUEST_URI : http://localhost:9595/
SCRIPT_NAME :
SERVER_NAME : localhost
SERVER_PORT : 9595
SERVER_PROTOCOL : HTTP/1.1
SERVER_SOFTWARE : WEBrick/1.3.1 (Ruby/2.3.1/2016-04-26)
HTTP_HOST : localhost:9595
HTTP_CONNECTION : keep-alive
HTTP_CACHE_CONTROL : max-age=0
HTTP_UPGRADE_INSECURE_REQUESTS : 1
HTTP_USER_AGENT : Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_0) AppleWebKit/537.36 (KHTML, like – Gecko) Chrome/53.0.2785.143 Safari/537.36
HTTP_ACCEPT : text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,/;q=0.8
HTTP_ACCEPT_ENCODING : gzip, deflate, sdch
HTTP_ACCEPT_LANGUAGE : en-US,en;q=0.8
HTTP_COOKIE : _netflux_session=VTZoU1ZvVXlZV1MrQ3pTMHhlNXBSRGdpMFdXQXhrRFJnUGNMMEhhQmNLanp1aU9rb3pyQ3o2dGRE eVp0ZW5YTVJaSXBqZldIdWV1ZEtDRFdJWVo5b0FkMHRyZWVLVXVjR0lRdnV5dnl4VU01UWs0ZnBTbmlQc1Urb1g2ME1yU0pESkg0bGR2 bmwzR0h2bUt6a2xlQjlNNEpJNGtiOG1BQ2VkS0p5TWEvc1U0THdkNGtzbEtETmUrb1lDVHY5VWtKLS1oMnQ1cUlXcVJWcXZqTHpqWUNO L0JRPT0%3D—17bf5208879c831997c5c78c69895ded29aad26b
rack.version : [1, 3]
rack.input : #
rack.errors : #
rack.multithread : true
rack.multiprocess : false
rack.run_once : false
rack.url_scheme : http
rack.hijack? : true
rack.hijack : #
rack.hijack_io :
HTTP_VERSION : HTTP/1.1
REQUEST_PATH : /
```

This contains all environments variables and information related to our HTTP request. It contains HTTP headers and info about Rack.


### Routing: Adding in other pages to our application
```bash
../my_framework/
├── advice.rb
├── config.ru
├── Gemfile
├── Gemfile.lock
└── hello_world.rb
```

```ruby
# advice.rb

class Advice
  def initialize
    @advice_list = [
      "Look deep into nature, and then you will understand everything better.",
      "I have found the paradox, that if you love until it hurts, there can be no more hurt, only more love.",
      "What we think, we become.",
      "Love all, trust a few, do wrong to none.",
      "Lost time is never found again.",
      "Nothing will work unless you do."
    ]
  end

  def generate
    @advice_list.sample
  end
end
```


```ruby
# hello_world.rb


class HelloWorld
  def call(env)
      piece_of_advice = Advice.new.generate   # random piece of advice
    else
      [
      ]
    end
  end
end
```

Now when we add on `/advice` as our path on the URL, we will see a random piece of advice. Additionally, with we type and invalid path, "404 Not Found" will display.

### Adding HTML to the Response Body
```ruby
# hello_world.rb


class HelloWorld
  def call(env)
      piece_of_advice = Advice.new.generate   # random piece of advice
    else
      [
      ]
    end
  end
end
```

## Part 3
### View Templates
We need a place to store and maintain code related to what we want to display. This type of code is called a _view template_. They allow us to do some pre-processing on the server side and any programming language (Ruby, Python, JavaScript, etc) and then translate it into a string to return to the client (usually HTML).


### ERB
ERB - "Embedded" Ruby - A templating engine that allows us to embed Ruby directly into HTML. It takes a special syntax that mixes Ruby into HTML and produces the final HTML string.

These files end in `.erb`.

To use it we must:
* Create an ERB template object and pass in a string using the special syntax that mixes Ruby with HTML.
* Invoke the ERB instance method `result`, which will give us a 100% HTML string.

Use the special syntax `<%= %>` to let ERB know how to process Ruby code. There is also `<% %>`...

* `<%= %>` - will evaluate the embedded Ruby code, and include its return value in the HTML output. A method invocation, for example would be a good candidate for this tag.

ERB can also process entire files.
```ruby

erb = ERB.new(template_file)
erb.result
```

### Adding in View Templates
`views/index.erb`
```html
<html>
  <body>
    <h2>Hello World!</h2>
  </body>
</html>
```


```ruby
# hello_world.rb


class HelloWorld
  def call(env)
      template = File.read("views/index.erb")
      content = ERB.new(template)
      piece_of_advice = Advice.new.generate   # random piece of advice
    else
      [
      ]
    end
  end
end
```

## Part 4
#### Cleaning up the #call method

```ruby
# hello_world.rb


class HelloWorld
  def call(env)
      template = File.read("views/index.erb")
      content = ERB.new(template)
      piece_of_advice = Advice.new.generate   # random piece of advice
    else
      [
      ]
    end
  end

  private

  def erb(filename)
    path = File.expand_path("../views/#{filename}.erb", __FILE__)
    content = File.read(path)
    ERB.new(content).result
  end
end
```

The `File::expand_path` obtains the full path to the view template in question. `__FILE__` return the relative path to the current file; here it is to the file `hello_world.rb`. The `__FILE__` is used as the starting point to find the full path.

Now the `call` method is very intentional and clear, serving a single purpose.

#### Adding More View Templates
Now we need a view template for both "advice" and "not found" pages.

`views/advice.erb`
```erb
<html>
  <body>
    <p><em><%= message %></em></p>
  </body>
</html>
```

`views/not_found.erb`
```erb
<html>
  <body>
    <h2>404 Not Found</h2>
  </body>
</html>
```

But right now we have no way to access the `message` for `views/advice.erb`. Update the `erb` method:
```ruby
# hello_world.rb
# updated erb method

def erb(filename, local = {})
  b = binding
  message = local[:message]
  path = File.expand_path("../views/#{filename}.erb", __FILE__)
  content = File.read(path)
  ERB.new(content).result(b)
end
```
 Some new things here. `b = binding` essentially creates a binding of the variables and methods at the location of the method call. This binding then makes `message` available when the binding `b` is passed to the ERB template object.
```ruby
def call(env)
    piece_of_advice = Advice.new.generate
    [
      [erb(:advice, message: piece_of_advice)]
    ]
  else
    [
      [erb(:not_found)]
    ]
  end
end
```

### Refactoring and Streamlining our Application

```ruby
# app.rb


class App
  def call(env)
      response(status, headers) do
        erb :index
      end
      piece_of_advice = Advice.new.generate
      response(status, headers) do
        erb :advice, message: piece_of_advice
      end
    else
      response(status, headers) do
        erb :not_found
      end
    end
  end

  private

  def erb(filename, local = {})
    b = binding
    message = local[:message]
    path = File.expand_path("../views/#{filename}.erb", __FILE__)
    content = File.read(path)
    ERB.new(content).result(b)
  end

    body = yield if block_given?
    [status, headers, [body]]
  end
end
```

### Start of a Framework
What if we wanted to make another web application or integrate two or more applications with a larger one? Frameworks are useful for just this, generalizing a process to work for a wide variety of situations. Our framework will hold the common methods that we may want to use between different web applications.


Create a `monroe.rb` file with a `Monroe` class. Then update `app.rb` to use it.
```ruby
# monroe.rb

class Monroe
  def erb(filename, local = {})
    b = binding
    message = local[:message]
    path = File.expand_path("../views/#{filename}.erb", __FILE__)
    content = File.read(path)
    ERB.new(content).result(b)
  end

    body = yield if block_given?
    [status, headers, [body]]
  end
end
```
```ruby
# app.rb


class App < Monroe
  def call(env)
      response(status, headers) do
        erb :index
      end
      piece_of_advice = Advice.new.generate
      response(status, headers) do
        erb :advice, message: piece_of_advice
      end
    else
      response(status, headers) do
        erb :not_found
      end
    end
  end
end
```

> Now our Rack application focuses solely on handling the request and creating and returning a response. Anything more general purpose has been moved to our framework, `monroe.rb`. This separation of responsibilities really goes a long way in keeping things easier to manage. It also helps future-proof our application as well.

### Final Showcase - Our Application So Far
```bash
my_framework/
 ├── Gemfile
 ├── Gemfile.lock
 ├── config.ru
 ├── app.rb
 ├── advice.rb
 ├── monroe.rb
 └── views/
        ├── index.erb
        ├── advice.erb
        └── not_found.erb
```

## Conclusion
Rack is a web server interface, whichprovides a stable communication protocol between app code and web servers. Rack alleviates the need/time to write code for connecting a client to various web servers or worrying about what type of connection to use.

We can create modular parts such as view templates, classes to use as object models (like `advice.rb`), and code to control how to handle requests and the types of responses to send back (main router file). Common code was then extracted to form the beginning of a app development framework.