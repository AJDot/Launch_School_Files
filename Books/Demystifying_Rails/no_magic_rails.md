# No Magic Rails
## Sending Requests and Responses
### Defining a Route
The entrance to the web app is a route. If a request is made to a path, the web app must be able to process it, or return an error.
```bash
Routing Error
No route matches [GET] "/hello_world"
```

We need 3 bits of info to point the route to the correct action:
1. HTTP verb (GET, POST, etc.)
2. URL pattern (path)
3. A mapping to a controller and an action.

```ruby
# config/routes.rb
Rails.application.routes.draw do
  get '/hello_world' => 'application#hello_world'
end
```

Now the error return from the request will say we don't have the action.
```bash
Unknown action
The action 'hello_world' could not be found for ApplicationController
```
#### Ruby Tips
The following are equivalent:
```ruby
get '/hello_world' => 'application#hello_world'
```
```ruby
get({'/hello_world' => 'application#hello_world'})
```

### Defining An Action
```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  def hello_world
    render plain: 'Hello, World!'
  end
end
```

The purpose of a controller action is to respond to an HTTP request and build an HTTP response.
Drop a `binding.pry` after the render look at the following:
```bash
response.body         # => "Hello, World!"
response.content_type # => "text/plain"
response.status       # => 200
```
**`render`'s job is to accomplish one of the core responsibilities of a controller action: building the HTTP response.**

NOTE: `render` is made available thanks to inheritance from `ActionController::Base`.

#### Ruby Tips
The following are equivalent:
```ruby
render({:plain => 'Hello, World!'})
```
```ruby
render({plain: 'Hello, World!'})
```

## Rendering HTML with Views
### Rendering HTML
Handling directly in the controller action by passing in HTML to `render`.
```ruby
class ApplicationController < ActionController::Base
  def hello_world
    render inline: '<em>Hello, World!</em>'
  end
end
```

```ruby
# assuming we're inside the hello_world action above...

render inline: '<em>Hello, World!</em>'
binding.pry
### inside Pry ###
response.body         # => "<em>Hello, World!</em>"
response.content_type # => "text/html"
response.status       # => 200
```

We could pass any status we like just by adding `status: 404` to render as well.

### Content Using Views
The controller is supposed to do just one thing, *control* things. Right now there is content inside it. We will move this to a view.

A good controller won't actually *do* much but instead delegate tasks and put results together.

#### Creating a Simple View
HTML content belongs in a **View**.
```html
<!-- app/views/applicatoin/hello_world.html -->
<html>
  <body>
    <p>Hello, World!</p>
  </body>
</html>
```

The directory corresponds to the controller and action that uses them.
Now let's use this view in the controller by rendering it.

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base
  def hello_world
    render 'application/hello_world'
  end
end
```

The string passed to `render` matches the path of the view.
Behind the scene, effectively, `render` is doing something like this:
```ruby
render inline: File.read('app/views/application/hello_world.html')
```

## Making Our App Dynamic
### Dynamic Server Responses

The dynamic nature of web apps come mainly from the following two sources:
* The client embeds a piece of data inside the URL (parameters)
* The server responds with data based on some internal state of the data in the database. Example: when visiting a blog the server would retrieve the posts for just that blog and dynamically build the page for that blog.

### Dynamic Documents with Embedded Ruby
ERB

Small example:
```html
<html>
  <body>
    <% name = "John" %>
    <p>Hello, <%= name %>!</p>
  </body>
</html>
```

### Responses with Query Parameters
```html
<!-- app/views/application/hello_world.html.erb -->

<html>
  <body>
    <p>Hello, <%= name %>!</p>
  </body>
</html>
```

We can pass `name` using **query parameters** in the URL (`http://localhost:3000/hello_world?name=John`)

and then access them in our controller and pass them to the view.

```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  def hello_world
    name = params['name'] || "World"
    render 'application/hello_world', locals: { name: name }
  end
end
```
When the ERB engine sees the :locals key in the hash, it will use the value of that key to render the template.

### Responses with URL Capture Pattern
```ruby
# config/routes.rb

Rails.application.routes.draw do
  get '/hello_world/' => 'application#hello_world'
  get '/hello/:name'  => 'application#hello_world'
end
```
`:name` is a capture pattern and will route anything like `/hello_world/ANYTHING` and assign that param to the `name` key in the `params` hash.

## Persisting Data in Our App
### Database Backed Applications
This is the most common way to supply dynamic content, the server queries the backend database and uses the result to assemble a response.
The dynamic nature comes from the "state" of the backend database, not the data in the request.

### Prepare the Database
We will use SQLite3, a lightweight database that Rails has built-in support for.
Need to think about:
1. the structure of the database (a table and its columns)
2. the data itself (the rows representing individual posts)

Structure:
`posts` table needs to hold these details:
* `id` (integer)
* `title` (string)
* `body` (text)
* `author` (string)
* `create_at` (datetime)

To create this table, create the following SQL file:
`db/posts.sql`
```sql
CREATE TABLE "posts" (
  "id"         INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "title"      varchar,
  "body"       text,
  "author"     varchar,
  "created_at" datetime NOT NULL);
```

Populate it with some fake data:

`db/posts.csv`
```
1,Blog 1,Lorem ipsum dolor sit amet.,Brad,2014-12-07
2,Blog 2,Lorem ipsum dolor sit amet.,Chris,2014-12-08
3,Blog 3,Lorem ipsum dolor sit amet.,Kevin,2014-12-09
```

To create the database, execute our SQL against it to create the `posts` table. Do this from the "Rails root directory"
```bash
$ sqlite3 db/development.sqlite3 < db/posts.sql
```

Import the CSV file:
```sql
$ sqlite3 db/development.sqlite3

sqlite> .tables
posts

sqlite> SELECT * FROM posts;
sqlite>

sqlite> .mode csv
sqlite> .import db/posts.csv posts
```

Now we have 3 rows:
```sql
sqlite> SELECT * FROM posts;
1,"Blog 1","Lorem ipsum dolor sit amet.",Brad,2014-12-07
2,"Blog 2","Lorem ipsum dolor sit amet.",Chris,2014-12-08
3,"Blog 3","Lorem ipsum dolor sit amet.",Kevin,2014-12-09

sqlite> SELECT title FROM posts;
"Blog 1"
"Blog 2"
"Blog 3"

sqlite> SELECT created_at FROM posts WHERE id=1;
2014-12-07
```

Use `.quit` to exit the sqlite REPL.

### Interacting with the Database
The `sqlite3` gem allows us to do this easily.
```bash
$ irb

> require 'sqlite3'
=> true

# setup db connection
> connection = SQLite3::Database.new 'db/development.sqlite3'
=> #<SQLite3::Database:0x000000039ff288 ... >
```

Now we can make queries:
```bash
> post_arrays = connection.execute 'SELECT * FROM posts'
=> [
     [1, "Blog 1", "Lorem ipsum dolor sit amet.", "Brad", "2014-12-07"],
     [2, "Blog 2", "Lorem ipsum dolor sit amet.", "Chris", "2014-12-08"],
     [3, "Blog 3", "Lorem ipsum dolor sit amet.", "Kevin", "2014-12-09"]
   ]
```

Having the data come at us as an array of arrays is messy and tough to work with. We can easily have the results come back as a hash.
```bash
> connection.results_as_hash = true
=> true

> connection.execute('SELECT * FROM posts').first
=> {
     "id"         => 1,
     "title"      => "Blog 1",
     "body"       => "Lorem ipsum dolor sit amet.",
     "author"     => "Brad",
     "created_at" => "2014-12-07",
     0 => 1,
     1 => "Blog 1",
     2 => "Lorem ipsum dolor sit amet.",
     3 => "Brad",
     4 => "2014-12-07"
   }
```

These keys allow the hashes to act exactly like the arrays from before (in regard to value access using [] at least), even though they're not arrays anymore.

## List and Show Records
### Listing Our Posts

We need a route, an action, and a view.

```ruby
# config/routes.rb

Rails.application.routes.draw do
  get '/list_posts' => 'application#list_posts'
end
```

The `application#list_posts` action points to:

```ruby
class ApplicationController < ActionController::Base
  def list_posts
    connection = SQLite3::Database.new 'db/development.sqlite3'
    connection.results_as_hash = true

    posts = connection.execute("SELECT * FROM posts")

    render 'application/list_posts', locals: { posts: posts }
  end
end
```

The action contains the db logic, grabs the posts and passes them to the locals for the view.

Here's the view:
```html
<!-- app/views/application/list_posts.html.erb -->
<html>
  <body>

    <div class="posts">
      <% posts.each do |post| %>
        <div class="post">

          <h2 class="title">
            <%= post['title'] %>
          </h2>

          <small class="meta">
            <span class="author">by <%= post['author'] %> -</span>
            <em class="created_at"><%= post['created_at'] %></em>
          </small>

        </div>
        <hr />
      <% end %>
    </div>

  </body>
</html>
```

### Show a Post to the User
The route we want is `/show_post/:id` to read a post.

```ruby
Rails.application.routes.draw do
  get '/list_posts' => 'application#list_posts'
  get '/show_post/:id' => 'application#show_post'
end
```
Need a `show_post` action

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def show_post
    connection = SQLite3::Database.new 'db/development.sqlite3'
    connection.results_as_hash = true

    post = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", params['id']).first

    render 'application/show_post', locals: { post: post }
  end
end
```

The way we use execute is important and protects against SQL Injection Attacks. DO NOT CODE IT THIS WAY:
```ruby
post = connection.execute("SELECT * FROM posts WHERE post.id = #{params['id']} LIMIT 1")
```

#### Links
Between the two pages.
```html
<!-- app/views/application/show_post.html.erb -->

<html>
  <body>

    <!-- link to list of posts -->
    <a href="/list_posts">Back to Posts</a>

    <div class="post">
      <!-- ... -->
    </div>

    <br />

  </body>
</html>
```
```html
<!-- app/views/application/list_posts.html.erb -->

<html>
  <body>

    <div class="posts">
      <% posts.each do |post| %>
        <div class="post">

          <h2 class="title">
            <!-- link to post -->
            <a href="/show_post/<%= post['id'] %>"><%= post['title'] %></a>
          </h2>

          <!-- ... -->

        </div>
        <hr />
      <% end %>
    </div>

  </body>
</html>
```

### Extract Shared Logic for DB Connection

```ruby
class ApplicationController < ActionController::Base
  def list_posts
    posts = connection.execute("SELECT * FROM posts")

    render 'application/list_posts', locals: { posts: posts }
  end

  def show_post
    post = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", params['id']).first

    render 'application/show_post', locals: { post: post }
  end

  private

  def connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end
end
```

## Create a New Record Using a Form
### Displaying a Form
1. provide the user with a form to collect the details of the new post
2. receive that submitted form data and add it as a new post to our collection of posts.

Expose a route
```ruby
### config/routes.rb ###

Rails.application.routes.draw do
  # ...
  get '/new_post' => 'application#new_post'
end
```
```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base
  # ...

  def new_post
    render 'application/new_post'
  end
end
```
```html
<!-- app/views/application/new_post.html.erb -->

<html>
  <body>

    <form method="post" action="/create_post">

      <label>Title</label>
      <input name="title" type="text" />
      <br /> <br />

      <label>Body</label>
      <textarea name="body"></textarea>
      <br /> <br />

      <label>Author</label>
      <input name="author" type="text" />
      <br /> <br />

      <input type="submit" value="Create Post" />

    </form>

  </body>
</html>
```

We add another route to send GET requests for the /new_post path to the application#new_post action.

Then we define that new_post action, which then renders the new_post view.

And finally we define a new_post view, which has a few new pieces.

The form `method` determines the HTTP request method and the `action` determines the request path.

In this case we can now make a post route `/create_post`

```ruby
post '/create_post' => 'application#create_post'
```

Rails will place the values on the form fields in the `params` hash where the keys are the `name` attribute of the elements.

### Creating a Post
```ruby
### config/routes.rb ###

Rails.application.routes.draw do
  # ...
  post '/create_post' => 'application#create_post'
end
```
```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def create_post
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
      params['title'],
      params['body'],
      params['author'],
      Date.current.to_s

    redirect_to '/list_posts'
  end
end
```

The `redirect_to` method is available for the same reason as `render`: `ApplicationController` inherits from `ActionController::Base`.

Take a look at the response object. Place a binding pry after the redirect in the create method.
```bash
# assuming we're inside the create_post action above...

redirect_to '/list_posts'
require 'pry'; binding.pry;

response.body
# => "<html><body>You are being <a href=\"http://localhost:3000/list_posts\">redirected</a>.</body></html>"

response.content_type # => nil

response.status #  => 302

response.headers
# => {
#      # ...
#      "Location"=>"http://localhost:3000/list_posts"
#    }

response.headers['Location']
# => "http://localhost:3000/list_posts"
```

Content type is `nil` since this is a redirect.
The `302` status code means `Found` as in "we found the thing you requested, but it's somewhere else".
The `Location` header is used to explain where.

#### Linking to Our New Post Page
```html
<!-- app/views/application/list_posts.html.erb -->

<html>
  <body>

    <div class="posts">
      <!-- ... -->
    </div>

    <!-- link to new post -->
    <a href="/new_post">New Post</a>

  </body>
</html>
```
And back to /list_posts from /new_post :

```html
<!-- app/views/application/new_post.html.erb -->

<html>
  <body>

    <form method="post" action="/create_post">
      <!-- ... -->
    </form>

    <br />
    <!-- link back to the list of post -->
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

#### Finishing Our Form
```html
<html>
  <body>

    <form method="post" action="/create_post">

      <label for="title"> Title</label>
      <input id="title" name="title" type="text" />
      <br /> <br />

      <label for="body"> Body</label>
      <textarea id="body" name="body"></textarea>
      <br /> <br />

      <label for="author"> Author</label>
      <input id="author" name="author" type="text" />
      <br /> <br />

      <input type="submit" value="Create Post" />

    </form>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

Associate the labels with the form fields to:
1. allow user to click on label to give focus to form field
2. visually impaired users that depend on screen reading software will be able to use your form, since screen readers depend on these attributes to associate form inputs with their labels.

## Edit a Record
### Editing and Updating a Post
1. provide the user with a form to allow editing of the existing post
2. receive that submitted form data and update the appropriate post in the database

The route
```ruby
### config/routes.rb ###

Rails.application.routes.draw do
  # ...
  get  '/edit_post/:id' => 'application#edit_post'
end
```
An action to render our edit form:

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def edit_post
    post = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", params['id']).first

    render 'application/edit_post', locals: { post: post }
  end

  # ...
end
```
And a view for our edit form:

```html
<!-- app/views/application/edit_post.html.erb -->

<html>
  <body>

    <form method="post" action="/update_post/<%= post['id'] %>">

      <label for="title"> Title</label>
      <input id="title" name="title" type="text" value="<%= post['title'] %>"/>
      <br /> <br />

      <label for="body"> Body</label>
      <textarea id="body" name="body"><%= post['body'] %></textarea>
      <br /> <br />

      <label for="author"> Author</label>
      <input id="author" name="author" type="text" value="<%= post['author'] %>"/>
      <br /> <br />

      <input type="submit" value="Update Post" />

    </form>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

This edit_post view is identical to the new_post with three exceptions:

1. our submit button reads `Update Post`
2. all of the `<form>` fields are populated with the values of the post
3. the `<form>` `action` attribute points to our new route (using the proper post ID)

#### Updating a Post

```ruby
### config/routes.rb ###

Rails.application.routes.draw do
  # ...
  post '/update_post/:id' => 'application#update_post'
end
```
And then we'll define this update_post action:

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def update_post
    update_query = <<-SQL
      UPDATE posts
      SET title      = ?,
          body       = ?,
          author     = ?
      WHERE posts.id = ?
    SQL
    connection.execute update_query, params['title'], params['body'], params['author'], params['id']

    redirect_to '/list_posts'
  end
end
```

Link to Edit Post from List Posts
```html
<!-- app/views/application/list_posts.html.erb -->

<html>
  <body>

    <div class="posts">
      <% posts.each do |post| %>
        <div class="post">

          <h2 class="title"> <!-- ... --> </h2>

          <small class="meta">

            <!-- ... -->

          </small>
          <!-- link to edit post -->
          <a href="/edit_post/<%= post['id'] %>">Edit</a>
        </div>
        <hr />
      <% end %>
    </div>

    <!-- ... -->

  </body>
</html>
```

### Redirect vs. Render

You probably have seen a bit of a pattern here: whenever we do HTTP POST, we redirect instead of render. This is because of HTTP semantics. That is, the meaning of a POST request is different from that of a GET request.

When we POST, we're requesting for the server to do something e.g. change something in the database. With a GET request, we're asking the server to give us something. So the point of a POST request is not to get something, but to have the server do something. But, even though the POST request itself is not a request for a document (e.g. HTML), we're still making these POST requests from a browser, so we have to show the user something. And so, once our action is done successfully processing a POST request, it delegates responsibility for displaying something to the user on to another action, by redirecting. Another reason for redirecting instead of rendering is that if we render after a POST request, we may run into errors when trying to refresh the page as the URL from the POST request will not be changed even though a new has rendered.

## Find and Delete a Record
### Extract Finding a Post
This logic is the same in `show_post` and `edit_post`. Refactor.

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def show_post
    post = find_post_by_id(params['id'])

    render 'application/show_post', locals: { post: post }
  end

  # ...

  def edit_post
    post = find_post_by_id(params['id'])

    render 'application/edit_post', locals: { post: post }
  end

  # ...

  def find_post_by_id(id)
    connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", id).first
  end
end
```

Again, refactoring our logic into one place like this makes it:

1. easy to change later, because now we'll only need to make a change in one place
2. easy to use elsewhere if needed

### Delete a Post

To do this, we'll just need something a user can click to send a request that deletes a post. But since deleting a post is destructive, we won't want to use a GET request for this. Instead, we'll use a POST request, and to perform this POST, we'll need to create a `<form>` to submit.

This `<form>` will be incredibly simple though, because it will have no `<input>`s, except for a submit button. All it needs to do is POST to the path for destroying the post.

Here's what it looks like:

```html
<!-- app/views/application/list_posts.html.erb -->

<html>
  <body>

    <div class="posts">
      <% posts.each do |post| %>
        <div class="post">
          <h2 class="title"> <!-- ... --> </h2>

          <small class="meta">

            <!-- ... -->

          </small>
          <!-- ... -->
          <form method="post" action="/delete_post/<%= post['id'] %>" style='display: inline'>
            <input type="submit" value="Delete" />
          </form>
        </div>
        <hr />
      <% end %>
    </div>

    <!-- ... -->

  </body>
</html>
```
Then the route our new `<form>` points to:

```ruby
### config/routes.rb ###

Rails.application.routes.draw do
  # ...
  post '/delete_post/:id' => 'application#delete_post'
end
```

And the action that routes to:

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def delete_post
    connection.execute("DELETE FROM posts WHERE posts.id = ?", params['id'])

    redirect_to '/list_posts'
  end
end
```
We start off in application/list_posts by giving each of our posts a `<form>`:

```html
<form method="post" action="/delete_post/<%= post['id'] %>" style='display: inline'>
  <input type="submit" value="Delete" />
</form>
```

## Controller Patterns and CRUD
### Controller Patterns in a Datacentric App
So far controllers are doing:
1. Interacting with the database
2. Retrieve data to render a view template, or redirect to a different page.

The controller stands between the data (in the database) and the presentation (the view templates) to coordinate the flow. This is a fundamental pattern of controllers that we'll see repeatedly in Rails applications.

## Data Encapsulation with Models
### Creating a New Post
As the app becomes bigger, SQL will get scattered throughout, making it hard to update or change. The answer is to encapsulate it all into a single place to they can be easily updated when necessary.

We do this by creating models.

`app/models/post.rb`

```ruby
class Post
  attr_reader :id, :title, :body, :author, :created_at

  def initialize(attributes={})
    @id = attributes['id']
    @title = attributes['title']
    @body = attributes['body']
    @author = attributes['author']
    @created_at = attributes['created_at']
  end
end
```

At this point `Post` is just a ruby class, not using Rails' `ActiveRecord`.

Move the SQL from `create_post` in the controller to the `Post` class.

`app/models/post.rb`

```ruby
class Post
  attr_reader :id, :title, :body, :author, :created_at
  # ...

  def save
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
      title,
      body,
      author,
      Date.current.to_s
  end

  # ...

  private

  # ...

  def connection
    db_connection = SQLite3::Database.new('db/development.sqlite3')
    db_connection.results_as_hash = true
    db_connection
  end
end
```

`app/controllers/application_controller.rb`

```ruby
class ApplicationController < ActionController::Base

  # ...

  def create_post
    post = Post.new('title' => params['title'],
                    'body' => params['body'],
                    'author' => params['author'])
    post.save
    redirect_to '/list_posts'
  end
end
```

### Find and Show a Post

Next, let's move our logic for looking up a post to a Post.find method. This is not an operation that we do on an instance of a Post (we don't have one yet, we are finding one!) so we'll put it as a class method.

`app/models/post.rb`

```ruby
class Post
  attr_reader :id, :title, :body, :author, :created_at

  # ...

  def self.find(id)
    post_hash = connection.execute("SELECT * FROM posts WHERE posts.id = ? LIMIT 1", id).first
    Post.new(post_hash)
  end

  # ...

end
```

Also because the connection method needs to be accessed from a class method find, we'll move it to be a class method as well.

```ruby
class Post
  attr_reader :id, :title, :body, :author, :created_at


  # ...

  def self.connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end

  # ...
```

We have refactored the code to the model and changed the controller actions, but if we visit /show_post/1 now, we'll find ourselves staring at an error page. The reason for this is that we changed the type of objects that are passed into the view as posts. Before they were Hash objects, and now they're Post objects.

Let's change our show_post view to use the Post object instead. Since we have defined attr_reader for the Post class, accessing its attributes is now easier:

```html
<!-- app/views/application/show_post.html.erb -->

<html>
  <body>

    <div class="post">
      <h2 class="title">
        <%= post.title %>
      </h2>

      <small class="meta">
        <span class="author">by <%= post.author %> -</span>
        <em class="created_at"><%= post.created_at %></em>
      </small>

      <p class="body"><%= post.body %></p>
    </div>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

### Edit a Post
```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base

  # ...

  def edit_post
    post = Post.find(params['id'])

    render 'application/edit_post', locals: { post: post }
  end

  # ...
end
```

```html
<!-- app/views/application/edit_post.html.erb -->

<html>
  <body>

    <form method="post" action="/update_post/<%= post.id %>">

      <label for="title"> Title</label>
      <input id="title" name="title" type="text" value="<%= post.title %>"/>
      <br /> <br />

      <label for="body"> Body</label>
      <textarea id="body" name="body"><%= post.body %></textarea>
      <br /> <br />

      <label for="author"> Author</label>
      <input id="author" name="author" type="text" value="<%= post.author %>"/>
      <br /> <br />

      <input type="submit" value="Update Post" />

    </form>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

## Expanded Encapsulation Through Our Models
### Update a Record

```ruby
# ...
def update_post
  post = Post.find(params['id'])
  post.set_attributes('title' => params['title'], 'body' => params['body'], 'author' => params['author'])
  post.save

  redirect_to '/list_posts'
end

# ...
```

The way to tell if a record is a new record or not is to check its id column - if it's nil then it's a new record that has never been saved into the database; if it's not nil then it's an existing record since the id column is automatically generated by the database.

We'll adjust our model code to either INSERT or UPDATE records based on whether the post is a new or existing one.

```ruby
### app/models/post.rb ###

class Post
  attr_reader :id, :title, :body, :author, :created_at

  # ...

  def new_record?
    id.nil?
  end

  def save
    if new_record?
      insert
    else
      update
    end
  end

  def insert
    insert_query = <<-SQL
      INSERT INTO posts (title, body, author, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_query,
      title,
      body,
      author,
      Date.current.to_s
  end

  def update
    update_query = <<-SQL
      UPDATE posts
      SET title      = ?,
          body       = ?,
          author     = ?
      WHERE posts.id = ?
    SQL

    connection.execute update_query,
      title,
      body,
      author,
      id
  end

  # ...

end
```

We also need to implement the set_attributes method for the Post class, and it's pretty straightforward. We can even refactor the the initialize method to call set_attributes method to remove some duplication.

```ruby
# app/models/post.rb

class Post
  attr_reader :id, :title, :body, :author, :created_at

  def initialize(attributes={})
    set_attributes(attributes)
  end

  def set_attributes(attributes)
    @id = attributes['id'] if new_record?
    @title = attributes['title']
    @body = attributes['body']
    @author = attributes['author']
    @created_at ||= attributes['created_at']
  end

  # ...

end
```

### Delete a Post Model
```ruby
# app/models/post.rb

class Post
  attr_reader :id, :title, :body, :author, :created_at

  # ...

  # used in application#delete_post
  def destroy
    connection.execute "DELETE FROM posts WHERE posts.id = ?", id
  end
end
```

```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base

  # ...

  def delete_post
    post = Post.find(params['id'])
    post.destroy

    redirect_to '/list_posts'
  end

  # ...

end
```

### List Posts

```ruby
# app/models/post.rb

class Post
  attr_reader :id, :title, :body, :author, :created_at

  # ...

  def self.all
    post_hashes = connection.execute("SELECT * FROM posts")
    post_hashes.map do |post_hash|
      Post.new(post_hash)
    end
  end

  # ...
end
```

```ruby
# app/controllers/application_controller.rb

class ApplicationController < ActionController::Base
  def list_posts
    posts = Post.all

    render 'application/list_posts', locals: { posts: posts }
  end
end
```

Remember, we'll now want to use our Post model methods this view. That includes the getters for the various states of a Post model.

```html
<!-- app/views/application/list_posts.html.erb -->

<html>
  <body>

    <div class="posts">
      <% posts.each do |post| %>
        <div class="post">
          <h2 class="title">
            <a href="/show_post/<%= post.id %>">
              <%= post.title %>
            </a>
          </h2>

          <small class="meta">
            <span class="author">by <%= post.author %> -</span>
            <em class="created_at"><%= post.created_at %></em>

            <a href="/edit_post/<%= post.id %>">Edit</a>

            <form method="post" action="/delete_post/<%= post.id %>" style='display: inline'>
              <input type="submit" value="Delete" />
            </form>
          </small>
        </div>
        <hr />
      <% end %>
    </div>

    <a href="/new_post">New Post</a>

  </body>
</html>
```

## Model Validations
### How to Write a Model Validation

As a general guideline, whenever an application allows user's input, we want to validate the data as early as possible. Let's look at how we can do that with our Post model before the records are saved into the database.
```ruby
### app/models/post.rb ###

class Post

  # ...

  def valid?
    title.present? && body.present? && author.present?
  end

  # ...

end
```

We are adopting the validation rule that a post is only valid when title, body and author fields are all present.

And notice when we check for the presence of each of the attributes, we're using the present? method, which is a method that Rails provides:

```bash
> ''.present?
=> false

> nil.present?
=> false

> 'something'.present?
=> true
```

As you can see above, this present? method returns false if it's called on nil or an empty string. Just what we're looking for to test if a title, body, or author is present.

```ruby
### app/models/post.rb ###

class Post

  # ...

  def save
    return false unless valid?

    if new_record?
      insert
    else
      update
    end

    true
  end

  # ...

end
```

### Integrate Validations with Forms

When the user provides invalid inputs, we want to:

1. instead of taking the user to the listing posts page, we would "bounce back" to the page with the input form.
2. preserve the user's input so they don't have to fill the form from scratch
3. show the user what input field(s) are not valid

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...


  def create_post
    post = Post.new('title' => params['title'], 'body' => params['body'],
      'author' => params['author'])
    if post.save
      redirect_to '/list_posts'
    else
      render 'application/new_post', locals: { post: post }
    end
  end

  # ...

end
```

We also have to change the new_post view so that it would render with a post object passed into it.

```html
<!-- app/views/application/new_post.html.erb -->

<html>
  <body>
    <form method="post" action="/create_post">

      <label for="title"> Title</label>
      <input id="title" name="title" type="text" value="<%= post.title %>"/>
      <br /> <br />

      <label for="body"> Body</label>
      <textarea id="body" name="body"><%= post.body %></textarea>
      <br /> <br />

      <label for="author"> Author</label>
      <input id="author" name="author" type="text" value="<%= post.author %>"/>
      <br /> <br />

      <input type="submit" value="Create Post" />

    </form>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

With our view ready, we'll just need to adjust the new controller action to pass in an instantiated "empty" post object.

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def new_post
    post = Post.new

    render 'application/new_post', locals: { post: post }
  end

  # ...

end
```

While we're at it, let's also alter our code for updating a post, as we'll want to include validations for that workflow as well.

```ruby
class ApplicationController < ActionController::Base

  # ...

  def update_post
    post = Post.find(params['id'])
    post.set_attributes('title' => params['title'], 'body' => params['body'],
      'author' => params['author'])
    if post.save
      redirect_to '/list_posts'
    else
      render 'application/edit_post', locals: { post: post }
    end
  end

  # ...
end
```

```html
<!-- app/views/application/edit_post.html.erb -->

<html>
  <body>
    <form method="post" action="/update_post/<%= post.id %>">

      <label for="title"> Title</label>
      <input id="title" name="title" type="text" value="<%= post.title %>"/>
      <br /> <br />

      <label for="body"> Body</label>
      <textarea id="body" name="body"><%= post.body %></textarea>
      <br /> <br />

      <label for="author"> Author</label>
      <input id="author" name="author" type="text" value="<%= post.author %>"/>
      <br /> <br />

      <input type="submit" value="Update Post" />

    </form>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

NOTE: When you reload a page with a browser, it asks the browser to replay the last HTTP request. In the case of a form submission with errors, the last request will be a POST request because the behavior on the server side is to render the form and not redirect to another path.

### Display Validations
The last piece we need to do to ensure a good user experience, is to show the validation errors so the user knows what went wrong with their inputs.

Those messages should be created while we validate the user inputs, which currently happens in the Post model. We could just store an array of error messages in the model. Since the model will be passed into the view template when it's rendered, the view template can then pull the error messages out of the model to display on the screen.

Here's what we'll do:

```ruby
### app/models/post.rb ###

class Post
  attr_reader :id, :title, :body, :author, :created_at, :errors
  # ...

  def initialize(attributes={})
    # ...

    @errors = {}
  end


  def valid?
    @errors['title']  = "can't be blank" if title.blank?
    @errors['body']   = "can't be blank" if body.blank?
    @errors['author'] = "can't be blank" if author.blank?
    @errors.empty?
  end

  # ...

end
```
The `blank?` method is defined by Rails to work on nil and strings with the following behavior:

```
> ''.blank?
=> true

> nil.blank?
=> true

> 'something'.blank?
=> false
```
As you probably have guessed, `blank?` is the opposite of `present?`.

Now that we know an invalid post created from user input would always have errors set in the object, we can adjust our view to show the error messages:

`app/views/application/new_post.html.erb`

```html
<html>
  <body>

    <div class="errors">
      <% post.errors.each do |attribute, error| %>
        <p class="error" style="color: orange">
          <%= attribute %>: <%= error %>
        </p>
      <% end%>
    </div>

    <form method="post" action="/create_post">

      <label for="title"> Title</label>
      <input id="title" name="title" type="text" value="<%= post.title %>"/>
      <br /> <br />

      <label for="body"> Body</label>
      <textarea id="body" name="body"><%= post.body %></textarea>
      <br /> <br />

      <label for="author"> Author</label>
      <input id="author" name="author" type="text" value="<%= post.author %>"/>
      <br /> <br />

      <input type="submit" value="Create Post" />

    </form>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

Make sure to include the changes we've made above in your `edit_post.html.erb` file as well. Now is a good time to run through our app and test the code that we have just added in. Try making a post with invalid inputs; the new post view should render and the application should display a list of errors.


## A Second Resource

### Adding Comments to Our App
Now that we have all the CRUD actions working for posts and we have a Post model, let's add on to our web app's functionality by adding post comments.

Each post will be able to have many comments, so let's start off by giving ourselves some comments in our DB to play with. This process will be the same as it was with posts, we'll:

1. create a new table (define a structure)
2. populate that table with rows (place data in that structure)

Our comments will also have `id`, `body`, `author`, and `created_at` columns, just like our posts. But there's another thing we'll have to keep track of for each comment: what post does the comment belong to?

In relational databases, we keep track of this using a **foreign key**.

For both tables, our `id` column holds the *primary key* for each row, that is, a value that uniquely identifies that row within that table. A foreign key is called "foreign" because it references a row in a different ("foreign") table.

Since our comments belong to a post, we'll follow Rails' convention and name this foreign key column post_id. The integer held in this column will be the ID of the post row that a given comment row belongs to.

But our process for creating the table and populating it with data remains the same as it was with posts. First we have some SQL to create the table:

```sql
-- db/comments.sql --

CREATE TABLE "comments" (
  "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  "body" text,
  "author" varchar,
  "post_id" integer,
  "created_at" datetime NOT NULL);
```
And some CSV we'll import to create some comments, three for each post:

`db/comments.csv`

```csv
1,Lorem ipsum dolor sit amet.,Matz,1,2014-12-09
2,Lorem ipsum dolor sit amet.,DHH,1,2014-12-09
3,Lorem ipsum dolor sit amet.,tenderlove,1,2014-12-09
4,Lorem ipsum dolor sit amet.,Matz,2,2014-12-09
5,Lorem ipsum dolor sit amet.,DHH,2,2014-12-09
6,Lorem ipsum dolor sit amet.,tenderlove,2,2014-12-09
7,Lorem ipsum dolor sit amet.,Matz,3,2014-12-09
8,Lorem ipsum dolor sit amet.,DHH,3,2014-12-09
9,Lorem ipsum dolor sit amet.,tenderlove,3,2014-12-09
```

Notice the `post_id` values for each comment. These are after the author name and before the date.

First we run the SQL against our `db/development.sqlite3` database:

```bash
$ sqlite3 db/development.sqlite3 < db/comments.sql
```

Then we can use the `sqlite3` console to see that we have a `comments` table now, but no rows within:

```bash
$ sqlite3 db/development.sqlite3

sqlite> .tables
comments posts

sqlite> SELECT * FROM comments;
sqlite>
```

And lastly, we'll import our comments CSV:

```bash
sqlite> .mode csv
sqlite> .import db/comments.csv comments

sqlite> SELECT * FROM comments;
8,"Lorem ipsum dolor sit amet.",DHH,3,2014-12-09
7,"Lorem ipsum dolor sit amet.",Matz,3,2014-12-09
6,"Lorem ipsum dolor sit amet.",tenderlove,2,2014-12-09
5,"Lorem ipsum dolor sit amet.",DHH,2,2014-12-09
4,"Lorem ipsum dolor sit amet.",Matz,2,2014-12-09
3,"Lorem ipsum dolor sit amet.",tenderlove,1,2014-12-09
2,"Lorem ipsum dolor sit amet.",DHH,1,2014-12-09
1,"Lorem ipsum dolor sit amet.",Matz,1,2014-12-09
```

And now we have comments in our database!

### Displaying Comments
Now that we have rows of comments in a `comments` table in our database, let's show the comments that belong to a post in our `show_post` view.

We'll do this in two steps:

1. collect the comments from the DB for a post inside the controller action and pass them to the view
2. display the comments in the view

Let's start with the `show_post` action changes:

`app/controllers/application_controller.rb`

```ruby
class ApplicationController < ActionController::Base

  # ...

  def show_post
    post     = Post.find(params['id'])
    comments = connection.execute('SELECT * FROM comments WHERE comments.post_id = ?', params['id'])

    render 'application/show_post', locals: { post: post, comments: comments }
  end

  # ...

end
```

Here we simply find our comments by specifying in our query:

```ruby
WHERE comments.post_id = ?
```

Where `params['id']` (the post's ID) is substituted for the `?`. This where clause is how we only pull comments that are "associated" to a post.

Then we pass the resulting hash along into our view using `locals`, so let's now make use of `comments` in our `show_post` view:

`app/views/application/show_post.html.erb`

```html
<html>
  <body>
    <div class="post">
      <!-- post title, meta data, and body displayed here -->
      <br /><br />
      <div class="comments">
        <h3>Comments:</h3>
        <hr />
        <% comments.each_with_index do |comment, index| %>
          <div class="comment">
            <small class="comment_meta">
              <span class="comment_author">#<%= index+1 %> by <%= comment['author'] %> -</span>
              <em class="comment_created_at"><%= comment['created_at'] %></em>
            </small>
            <p class="comment_body"><%= comment['body'] %></p>
          </div>
          <hr />
        <% end %>
      </div>
    </div>
    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```
Here we loop again, using `<% %>` instead of `<%= %>`, just like we did with our post titles in `list_posts`, but this time we use `each_with_index` so that we can number our comments. Just as a quick Ruby-only illustration of how this works, here's what each_with_index can do:

```ruby
['a','b','c'].each_with_index do |char, idx|
  puts "##{idx+1}: #{char}"  
end  

# prints:
#
# #1: a
# #2: b
# #3: c
```

So now if we visit `/show_post/1`, we'll see the comments for the post as well.

NOTE: As a reminder, if you ended up deleting any of the three original posts in a previous assignment, you will not be able to see the comments associated with the deleted post(s).

### A Comment Model
Just like the way we have a `Post` model for the posts, let's create a `Comment` model for the comments:

`app/models/comment.rb`

```ruby
class Comment
  attr_reader :id, :body, :author, :post_id, :created_at

  def initialize(attributes={})
    @id = attributes['id'] if new_record?
    @body = attributes['body']
    @author = attributes['author']
    @post_id = attributes['post_id']
    @created_at ||= attributes['created_at']
  end

  def new_record?
    @id.nil?
  end
end
```

Now we have the beginning of a Comment model. The file app/models/comment.rb contains an initialize and new_record? method similar to those found in Post.

## Working with Model Associations

### Association Between Models
Currently in the `ApplicationController`, we first find a post from the database, then we need to get a collection of comments that are associated with the post. We're getting that from directly executing SQL in the controller action, which is not the ideal solution.

`app/controllers/application_controller.rb`

```ruby
class ApplicationController < ActionController::Base

  # ...

  def show_post
    post     = Post.find(params['id'])
    comments = connection.execute('SELECT * FROM comments WHERE comments.post_id = ?', params['id'])

    render 'application/show_post', locals: { post: post, comments: comments }
  end

  # ...

end
```

Since the SQL command needs a post id to find the comments, we'll move the command to the Post model.

`app/models/post.rb`

```ruby
class Post

  # ...

  def comments
    comment_hashes = connection.execute 'SELECT * FROM comments WHERE comments.post_id = ?', id
    comment_hashes.map do |comment_hash|
      Comment.new(comment_hash)
    end
  end

  # ...

end
```

Now we can change the code in the controller:

`app/controllers/application_controller.rb`

```ruby
class ApplicationController < ActionController::Base

  # ...

  def show_post
    post = Post.find(params['id'])

    render 'application/show_post', locals: { post: post }
  end

  # ...

end
```

And make adjustments on the view:

`app/views/application/show_post.html.erb`

```html
<html>
  <body>

    <div class="post">

      <!-- display post -->
      <br /> <br />
      <div class="comments">
        <h3>Comments:</h3>
        <% post.comments.each_with_index do |comment, index| %>
          <p class="comment">
            <small class="comment_meta">
              <span class="comment_author">#<%= index %> by <%= comment.author %> -</span>
              <em class="comment_created_at"><%= comment.created_at %></em>
            </small>

            <p class="comment_body"><%= comment.body %></p>
          </p>
          <hr />
        <% end %>
      </div>
    </div>

    <!-- ... -->

  </body>
</html>
```

### Creation Through Association
Moving on, we'll provide users with a way of adding a comment to a post.

And because it's a CRUD action, creating a comment will very much resemble creating a post. Below you'll find a `<form>` to create a new comment placed in `show_post`, the route it submits to, and the `create_comment` action that route points to:

```html
<!-- app/views/application/show_post.html.erb -->

<html>
  <body>

    <div class="post">

      <div class="comments">
        <hr />
        <% comments.each do |comment| %>
          <!-- display each comment -->
        <% end %>

        <!-- new comment form -->
        <form method="post" action="/create_comment_for_post/<%= post.id %>">

          <label for="body">Comment</label>
          <textarea id="body" name="body"></textarea>
          <br /> <br />

          <label for="author">Name</label>
          <input id="author" name="author" type="text" />
          <br /> <br />

          <input type="submit" value="Add Comment" />
        </form>
        <hr />

      </div>
    </div>

    <br />
    <a href="/list_posts">Back to Posts</a>

  </body>
</html>
```

```ruby
### config/routes.rb ###

Rails.application.routes.draw do
  # ...
  post '/create_comment_for_post/:post_id' => 'application#create_comment'
end
```

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def create_comment

    insert_comment_query = <<-SQL
      INSERT INTO comments (body, author, post_id, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_comment_query,
      params['body'],
      params['author'],
      params['post_id'],
      Date.current.to_s

      redirect_to "/show_post/#{params['post_id']}"
  end
  # ...

end
```

The primary difference in creating a comment, as opposed to creating a post, is our concern for `post_id`. When creating a comment, we'll need to be sure to associate it with the right post. This is essentially done in three steps.

First, we point the <form> action to a path that includes post.id:

```html
<form method="post" action="/create_comment_for_post/<%= post.id %>">
```

Then we capture this `post_id` in the route:

```ruby
post '/create_comment_for_post/:post_id' => 'application#create_comment'
```

And finally, we make sure to set the `post_id` for the row in the comments table:

```ruby
connection.execute insert_comment_query,
  params['body'],
  params['author'],
  params['post_id'],
  Date.current.to_s
```

This way, when a comment is created through this process, it is always associated with the post identified by the ID in the URL. At the end of `create_comment`, we just redirect back to `show_post`, which will end up rendering the post again, now with a new comment.

Similar to how we moved the SQL command to retrieve comments associated to a post to the Post model, we'll do the same to the SQL command to create a comment associated to a post.

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def create_comment
    post = Post.find(params['post_id'])
    post.create_comment('body' => params['body'], 'author' => params['author'])
    redirect_to "/show_post/#{params['post_id']}"
  end
  # ...

end
```

Now the `Post` model will look like:

```ruby
class Post

  # ...

  def create_comment(attributes)
    comment = Comment.new(attributes.merge!('post_id' => id))
    comment.save
  end

  # ...

end
```

Then the `Comment` model:

`app/models/comment.rb`

```ruby
class Comment

  # ...

  def initialize(attributes={})
    @id = attributes['id'] if new_record?
    @body = attributes['body']
    @author = attributes['author']
    @post_id = attributes['post_id']
    @created_at ||= attributes['created_at']
  end

  def save
    if new_record?
      insert
    else
      # update # ...not yet defined
    end
  end

  def insert
    insert_comment_query = <<-SQL
      INSERT INTO comments (body, author, post_id, created_at)
      VALUES (?, ?, ?, ?)
    SQL

    connection.execute insert_comment_query,
      @body,
      @author,
      @post_id,
      Date.current.to_s
  end

  private

  def self.connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  def connection
    self.class.connection
  end
end
```

Notice that we have nearly identical database connections in Comment as we do in Post. We'll be extracting these commonalities later on.

## Cleaning Up Our App
### Validation for Creating a Comment

Following the way we created validation for posts, let's create validation for comments:

* The body and author field both have to be present.
* If validation fails, the user should be brought back to the create comment page with the fields of the comment form populated.

```ruby
### app/models/comment.rb ###

class Comment
  attr_reader :id, :body, :author, :post_id, :created_at, :errors
  # ...

  def initialize(attributes={})
    # ...

    @errors = {}
  end

  def valid?
    @errors['body']   = "can't be blank" if body.blank?
    @errors['author'] = "can't be blank" if author.blank?
    @errors.empty?
  end

  def new_record?
    @id.nil?
  end

  def save
    return false unless valid?

    if new_record?
      insert
    else
      # update # ...not defined
    end

    true
  end

  # ...

end
```

```ruby
### app/models/post.rb ###

class Post

  # ...

  def build_comment(attributes)
    Comment.new( attributes.merge!('post_id' => id) )
  end

  def create_comment(attributes)
    comment = build_comment(attributes)
    comment.save
  end

  # ...

end
```

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def create_comment
    post     = Post.find(params['post_id'])
    comments = post.comments
    # post.build_comment to set the post_id
    comment  = post.build_comment('body' => params['body'], 'author' => params['author'])
    if comment.save
      # redirect for success
      redirect_to "/show_post/#{params['post_id']}"
    else
      # render form again with errors for failure
      render 'application/show_post',
        locals: { post: post, comment: comment, comments: comments }
    end
  end

  # ...

end
```

```html
<!-- app/views/application/show_post.html.erb -->

<html>
  <body>
    <div class="post">
      <!-- ... -->

      <div class="comments">
        <!-- ... -->

        <!-- display errors -->
        <div class="errors">
          <% comment.errors.each do |attribute, error| %>
            <p class="error" style="color: orange">
              <%= attribute %>: <%= error %>
            </p>
          <% end%>
        </div>

        <!-- populate comment <form> with values -->
        <form method="post" action="/create_comment_for_post/<%= post.id %>">

          <label for="body">Comment</label>
          <textarea id="body" name="body"><%= comment.body %></textarea>
          <br /> <br />

          <label for="author">Name</label>
          <input id="author" name="author" type="text" value="<%= comment.author %>"/>
          <br /> <br />

          <input type="submit" value="Add Comment" />

        </form>
        <hr />
      </div>
    </div>

    <!-- ... -->

  </body>
</html>
```

But now we need to consider a normal request to `show_post`, one that isn't a result of failed comment validation. In this case, we need to provide the view with a `Comment` object, because we're now calling `comment.errors` each time we render it. To set things straight, we'll simply instantiate an empty `Comment` in `show_post` and pass it into the view:

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def show_post
    post    = Post.find(params['id'])
    comment = Comment.new
    comments = post.comments
    render "application/show_post",
      locals: { post: post, comment: comment, comments: comments }
  end

  # ...

end
```

And with that, comment validation is complete!

### Delete a Comment
Now that we have our `Comment` validation, lets move on to adding some more `Comment` related functionality. We're going to make it so we can delete a comment from a `Post` page.

First let's set up the route necessary to accomplish this.

```ruby
### config/routes.rb

# ...

post '/list_posts/:post_id/delete_comment/:comment_id' => 'application#delete_comment'
```

Next, we'll add in a form that lets us delete a comment from a `Post`.

```html
<!-- app/views/application/show_post.html.erb -->
<html>
  <body>
    <!-- display errors -->
    <div class="post">
      <!-- ... -->

      <div class="comments">
        <% comments.each do |comment| %>
          <!-- display each comment -->

          <form method="post" action="/list_posts/<%= post.id %>/delete_comment/<%=
          comment.id %>">
            <input type="submit" value="Delete Comment" />
          </form>
          <hr />
        <% end %>

        <!-- populate comment <form> with values -->

      </div>
    </div>

    <!-- ... -->

  </body>
</html>
```

For the time being, we'll use the `POST` action to do this. We'll show a way to simulate `PATCH/PUT` and `DELETE` actions later in this book.

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  # ...

  def delete_comment
    post = Post.find(params['post_id'])
    post.delete_comment(params['comment_id'])
    redirect_to "/show_post/#{params['post_id']}"
  end

  # ...

end
```

```ruby
### app/models/post.rb ###

class Post

  # ...

  def build_comment(attributes)
    Comment.new(attributes.merge!('post_id' => id)
  end

  def create_comment(attributes)
    comment = build_comment(attributes)
    comment.save
  end

  def delete_comment(comment_id)
    Comment.find(comment_id).destroy
  end

  # ...

end
```

```ruby
### app/models/comment.rb
  class Comment
    # ...
    def self.find(id)
      comment_hash = connection.execute("SELECT * FROM comments WHERE comments.id = ? LIMIT 1", id).first
      Comment.new(comment_hash)
    end

    def destroy
      connection.execute "DELETE FROM comments WHERE id = ?", id
    end

    # ...

    private_class_method def self.connection
      db_connection = SQLite3::Database.new 'db/development.sqlite3'
      db_connection.results_as_hash = true
      db_connection
    end

    private

    def connection
      self.class.connection
    end
  end
```

Notice the order in which we wrote our code. It was a very top down approach. We start with our route and move onto the view. From the view we went to the controller and wrote an action for deleting a comment. And based on what model related methods we needed, we then proceeded to the Comment model and set up those methods. We're writing the code we want to see and then implementing that code when it is needed. With the code listed above, we can now delete comments!

### List Comments
We would also like to have a page that shows all the comments that have been made in our Blog app. Lets do that now. Let's start with the view template.

```html
<!-- app/views/application/list_comments.html.erb -->

<html>
  <body>

    <div class="comments">
      <% comments.each do |comment| %>

        <div class="comment">
          <small class="comment_meta">
            <span class="comment_post_title">
              Comment on
              <strong><%= comment.post.title %></strong>
            </span>

            <span class="comment_author">by <%= comment.author %> -</span>
            <em class="comment_created_at"><%= comment.created_at %></em>
          </small>

          <p class="comment_body"><%= comment.body %></p>
        </div>

        <hr />
      <% end %>
    </div>

  </body>
</html>
```

```ruby
### config/routes.rb ###

Rails.application.routes.draw do
  # ...
  get  '/list_comments' => 'application#list_comments'
end
```

```ruby
### app/controllers/application_controller.rb ###

class ApplicationController < ActionController::Base

  def list_comments
    comments = Comment.all

    render 'application/list_comments', locals: { comments: comments }
  end

  # ...

end
```

Note, that in our view, `list_comments.html.erb` we are using the method `comment.post`. This is one of the methods we need to build in the Comment model.

```ruby
### app/models/comment.rb ###

class Comment

  # ...

  def self.all
    comment_row_hashes = connection.execute("SELECT * FROM comments")
    comment_row_hashes.map do |comment_row_hash|
      Comment.new(comment_row_hash)
    end
  end

  def post
    Post.find(post_id) # This can be accomplished using an existing method
  end
end
```

Now we also have a nice view for seeing all comments made in our app. In the next chapter, we'll be cleaning up and consolidating the code we currently have in our application.

NOTE: if you previously deleted any posts that had comments, you may run into errors since we are not yet handling the deletion comments when a post is deleted.

## A Base Model
### Inheriting From a Base Model

Now that we've completed work on our Comment model, we've seen tons of duplication between it and our Post model. In particular, there are several methods that are identical between the two models, such as:

* `#new_record?`
* `#save`
* `.connection` and `#connection`

So let's pull these methods out of these two models and place them inside a new model:

```ruby
### app/models/base_model.rb ###

class BaseModel
  attr_reader :errors

  def new_record?
    @id.blank?
  end

  def save
    return false unless valid?
    if new_record?
      insert
    else
      update
    end
    true
  end

  private_class_method def self.connection
    db_connection = SQLite3::Database.new 'db/development.sqlite3'
    db_connection.results_as_hash = true
    db_connection
  end

  private

  def connection
    self.class.connection
  end
end
```

This `BaseModel` model class holds the shared functionality of both of our prior models, so we can now completely remove those methods from `Post` and `Comment`, if we change both of them to inherit from `BaseModel`:)

```ruby
### app/models/post.rb ###

class Post < BaseModel
  # ...
end
```

```ruby
### app/models/comment.rb ###
class Comment < BaseModel
  # ...
end
```

`BaseModel` nicely consolidates a fair amount of common logic for us, but there a few methods that are almost the same in both classes: .all, .find and #destroy

They're not exactly the same. Let's take a look at `.all`:

```ruby
### app/models/post.rb ###

class Post

  # ...

  def self.all
    post_hashes = connection.execute("SELECT * FROM posts")
    post_hashes.map do |post_hash|
      Post.new(post_hash)
    end
  end

  # ...

end
```

```ruby
### app/models/comment.rb ###

class Comment

  # ...

  def self.all
    comment_hashes = connection.execute("SELECT * FROM comments")
    comment_hashes.map do |comment_hash|
      Comment.new(comment_hash)
    end
  end

  # ...

end
```

Notice that what these methods are doing is the same, but things are named differently. In particular, the naming differences are as follows:

1. variable names e.g. `post_hash`
2. class names e.g. `Post` in `Post.new`
3. table name strings e.g. `posts` in `SELECT * FROM posts`

We'll address each of these, as we work to move this method into `BaseModel` to be shared by `Post` and `Comment`.

The issue of the variable names is simple: we'll pick something appropriate, but more generic. Taking `post_hashes` as an example, we could instead call the variable `record_hashes`.

```ruby
### app/models/base_model.rb ###

class BaseModel

  # ...

  def self.all
    # rename all the variables...
    record_hashes = connection.execute("SELECT * FROM posts")
    record_hashes.map do |record_hash|
      Post.new(record_hash)
    end
  end

  # ...

end
```

Next, the use of class names with the `Post.new` and `Comment.new` calls are actually syntactically unnecessary. We can omit the classes and call new all by itself. The reason for this is that .all is a class method. So if we call new inside of this class method, it will be called on the class it lives in.

```ruby
### app/models/base_model.rb ###

class BaseModel

  # ...

  def self.all
    record_hashes = connection.execute("SELECT * FROM posts")
    record_hashes.map do |record_hash|
      new record_hash
    end
  end

  # ...

end
```

And lastly there's the matter of the table names. Inside `Comment`, a query should be made to the `comments` table, and in `Post`, `posts`.

Notice the transformation there?

`Post` goes to `posts` and `Comment` goes to `comments`. It would be nice if our `.all` method could look at the class it lives in and figure out what to do based on the name of that class. Fortunately for us, this is not only common, but also easy in Ruby.

Let's see how we can get from a class (a constant) to the string we want:

```ruby
Post
# => Post

Post.to_s
# => "Post"

Post.to_s.pluralize
# => "Posts"

Post.to_s.pluralize.downcase
# => "posts"
```

Let's give our classes a `.table_name` method to figure out the appropriate table name string and then make use of it inside of `.all`:

```ruby
### app/models/base_model.rb ###

class BaseModel

  # ...

  # a way get the right table name string
  def self.table_name
    to_s.pluralize.downcase
  end

  def self.all
    # use it in our SQL
    record_hashes = connection.execute("SELECT * FROM #{table_name}")
    record_hashes.map do |record_hash|
      new record_hash
    end
  end

  # ...

end
```

It's worth noting that our call got shortened to `to_s.pluralize.downcase` inside of `.table_name`. The reason for this is the same as our shortened call to new earlier: inside of a class method self is the class.

Based on what we've done with our `.all` class method, we can also extract `.find`, and `#destroy` to the base model as well.

```ruby
class BaseModel

  # ...

  def destroy
    query_string = "DELETE FROM #{self.class.table_name} WHERE #{self.class.table_name}.id = ?"
    connection.execute query_string, id
  end

  def self.find(id)		
    query_string = "SELECT * FROM #{table_name} WHERE #{table_name}.id = ? LIMIT 1"		
    record_hash = connection.execute(query_string, id).first		
    new(record_hash)		
  end

  # ...

end
```

And with that, we can remove `.all`, `#destroy`, `.find` from the `Comment` and `Post` models. Since both classes inherit from `BaseModel`, they will now each make use of this new implementation.

This process of having an object look at itself is called introspection. You will see it and its effects littered all throughout Rails.

We've come a long ways, soon it will be time to start implementing Rails conventions in our app. In the next section, we will slowly introduce Rails conventions (magic) that can help make the work we've been doing simpler, easier to read, and more efficient.
