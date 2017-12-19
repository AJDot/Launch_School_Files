## Quiz: Lesson 2
1. Name all the 7 (or 8) routes exposed by the `resources` keyword in the `routes.rb` file. Also name the 4 named routes, and how the request is routed to the controller/action.

| name | HTTP Verb | Route | Controller#Action |
| --- | --- | --- | --- |
| posts | GET | /posts | posts#index |
| | POST | /posts | posts#create |
| new_post | GET | /posts/new | posts#new |
| edit_post | GET | /posts/:id/edit | posts#edit |
| post | GET | /posts/:id | posts#show |
| | PUT/PATCH | /posts/:id | posts#update |
| | DELETE | /posts/:id | posts#destroy |

---

2. What is REST and how does it relate to the `resources` routes?

REST stands for Representational State Transfer. There are 4 main actions that can occur for any resource - `create`, `read`, `update`, `delete`. The routes follow this convention where 4 routes perform one of those actions. The other routes help prepare for those actions.

---

3. What's the major difference between model backed and non-model backed form helpers?

Model-backed forms can only include inputs for that model's attributes or virtual attributes. Non-model-backed forms can contain anything.

---

4. How does `form_for` know how to build the `<form>` element?

Inside `form_for`, it will determine if the object passed into it is a new object or an existing one. This determines if the form will be pre-popoulated. `form_for` also have numerous helper methods used to create each element inside the form.

---

5. What's the general pattern we use in the actions that handle submission of model-backed forms (ie, the `create` and `update` actions)?

```ruby
if @obj.save
  redirect_to obj_path
else
  render :new
end
```

---

6. How exactly do Rails validations get triggered? Where are the errors saved? How do we show the validation messages on the user interface?

No idea exactly how the validations are triggered. The errors are saved on the object itself. We can iterate through the `object#errors.full_messages` array to display the messages to the user interface.

---

7. What are Rails helpers?

Rails helpers are used to extract our formatting logic. They are stored in the `app/helpers` folder.

---

8. What are Rails partials?

Rails partials are used to extract out common parts of views such as a form or a structure for a heading.

---

9. When do we use partials vs helpers?

Partials contain the HTML and the logic needed to determine what to display. Helpers don't decide *what* to display, just *how* to display it.

---

10. When do we use non-model backed forms?

When we are no longer following the Rails convention.

---

### LS Solution
1. Name all the 7 (or 8) routes exposed by the resources keyword in the routes.rb file. Also name the 4 named routes, and how the request is routed to the controller/action.

```
# Assuming you are getting resources :posts

$ rake routes

get '/posts', to: posts#index                => posts_path
get '/posts/object', to: posts#show          => post_path(object)
get '/posts/object/edit', to: posts#edit     => edit_post_path(object)
get '/posts/new', to: posts#new              => new_post_path
post '/posts', to: posts#create
patch '/posts/object', :to: posts#update
put '/posts/object', to: posts#update
delete '/posts/object', to: posts#destroy
```

---

2. What is REST and how does it relate to the resources routes?

REST stands for "REpresentational State Transfer" and it relies on using a stateless, client-server, cacheable communications protocol. In our case majority of the time, the HTTP protocol is used. RESTful applications use HTTP requests to create, retrieve, update, and delete data (aka CRUD operation). Thus, REST uses HTTP for all four of these actions. When we use resources routes, we are mapping the browser requests (HTTP verbs and URLs) to the controller actions of our app, allowing it to work seamlessly on the web.

---

3. What's the major difference between model backed and non-model backed form helpers?

The major difference is that model backed form helpers are tied to an object. There has to be a setter method, a virtual attribute or a column in the database, available for that object when using the model backed form helpers. We use model backed form helpers usually when we need to create, edit, or update an object.

---

4. How does `form_for` know how to build the `<form>` element?

By convention, `form_for` creates a form based on a specific model object. We are able to create, edit, and update that object's attributes. A form can be created by passing `form_for` a string or symbol relating to the object we want to deal with.

```ruby
<%= form_for @posts do |f| %>
    <%= f.label :title %>
    <%= f.text_field :title %>
<% end %>
```

---

5. What's the general pattern we use in the actions that handle submission of model-backed forms (ie, the `create` and `update` actions)?

```ruby
def create
    @post = Post.new(params.require(:post).permit(:url, :title, :description))

    if @post.save
        flash[:notice] = "Your post was saved."
        redirect_to posts_path
    else
        render :new
    end
end

def update
	@post = Post.find(params[:id])

	if @post.update(params.require(:post).permit(:url, :title, :description))
	    flash[:notice] = "Your post was updated."
	    redirect_to post_path(@post)
	else
		render :edit
	end
end
```

---

6. How exactly do Rails validations get triggered? Where are the errors saved? How do we show the validation messages on the user interface?

Rails validations are triggered when the data submissions try to hit the database. The errors are saved on the model object. When there are validation errors, they are saved to the object.errors. We display the validation messages by referencing the object.errors.full_messages method like below. By using the full_messages method, the errors are displayed in a nice, readable sentence format.

```ruby
<% if obj.errors.any? %>
  <div class="row">
    <div class="alert alert-error span8">
      <h5>Please fix the following errors:</h5>
      <ul>
        <% obj.errors.full_messages.each do |msg| %>
          <li><%= msg %></li>
        <% end %>
      </ul>
    </div>
  </div>
<% end %>
```

---

7. What are Rails helpers?

Rails helpers allow us to consolidate our application's logic and formatting so we can properly display information in the views. By declaring helper methods within the "application_helper.rb" file, we are able to use the methods in the views without convolving the views with logic code.

---

8. What are Rails partials?

Rails partials are a type of view that enable us to store and share common HTML files amongst all of the views. Partial files are named with an underscore at the beginning, for example: _errors.html.erb

---

9. When do we use partials vs helpers?

A partial is a view fragment with HTML code that is usually shared and used multiple times in view files. It should consists of code that is for presentation purposes only. On the other hand, while helpers also reduce code duplications, they are meant to be used when there is some logic to be processed within a view. This will eliminate the views to be consumed by logic, and instead, the views can remain "pure" for presentation usages.

10. When do we use non-model backed forms?

You can use a non-model backed form when you want to create a form that is not tied to a model. We can think of a non-model backed form as generating pure HTML rather than binding the form with a model object.

---
