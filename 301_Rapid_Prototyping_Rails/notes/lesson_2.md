# Lesson 2
## Lecture 3
### Forms
3 ways

#### Pure HTML
```html
<form action='/posts' method='POST'>
  Title: <input type='text'>
  <br/>
  <input type='submit'>
</form>
```

Rails has CSRF (cross site request forgery) to prevent forms submitting data the application by embedding a token into the form that is automatically generated.
This is found in the ApplicationController.
Using a pure HTML won't work with CSRF.

#### Rails Form Helpers
```ruby
<%= form_tag '/posts' do %>
  <%= label_tag :title %>
  <%= text_field_tag :title %>
  <br />
  <%= submit_tag "Create Post", class: 'btn btn-primary' %>
<% end %>
```
2 extra divs are created by the form helpers for an encoding and also for an authenticity token. This value is needed to pass through the CSRF.

#### Rails model-backed form helpers
```ruby
<%= form_for @post do |f| %>
  <%= f.label :title %>
  <%= f.text_field :title %>
  <br />
  <%= f.submit "Create Post", class: 'btn btn-primary' %>
<% end %>
```

The `@post` can be a new post object or an existing one. Rails will populate the form with the post data if using an existing one. Rails will also add an additional hidden input to the form with name `_method` with a value of `patch` with modifies the method from the normal `post` to `patch` so that the post will be updated instead of creating a new one.
So the `new` post form and the `edit` post form can be identical because `form_for` knows what to do.

`form_for` takes an object will determine where to submit to and what the method should be.
Needs to be setup in the `new` action.

When the form is submitted it will be in a nested structure. In the `params` there will be `post` and that will be a hash that has `title` as a key.

Then we can easily do Post.create(params[:post]) which will pass all post parameters to the create method.

### Strong Parameters

They are used to allow only certain params. Wrap the params in a method specifying the only params you want to allow to be mass-assigned.

```ruby
private

def post_params
  params.require(:post).permit(:title, :url)

  # more control here
  if user.admin?
    params.require(:post).permit!
  else
    params.require(:post).permit(:title, :url)
  end
end
```

### Common Pattern
```ruby
@post = Post.new(post_params)

if @post.save
  flash[:notice] = "Your post was created."
  redirect_to posts_path
else
  render 'new'
end
```
Essentially, if the save works then redirect, if not then render the page again with some kind of explanation for failure.

### Validations
Always added to the model layer.
```ruby
validates :title, presence: true
```
Means that a title is required.

Use `post.errors` to view the errors.
Use `post.errors.full_messages` to get an array of all the error messages.

### Before action
Run some code before a list of actions. A way to keep code even more dry.
Ex: `@post = Post.new` is redundant in several actions.

Use

Use them for two reasons:
1. Setup an instance variable
    ```ruby
    before_action :set_post, only: [:show, :edit, :update]

    private

    def set_post
      @post = Post.find(params[:id])
    end
    ```
2. Redirect based on some condition. The original action will no longer execute. Can be used for authentication.

### NOTES
#####Sharing of the `_form.html.erb` partial
You should understand now that the typical restful Rails controller has the following actions: `index`, `show`, `new`, `create`, `edit`, `update`, and `destroy`. Further, you should understand the intricate relationship between the `new/create` actions and the `edit/update` actions. The fact that these 4 action share 1 form partial also means that the form partial's dependencies (mostly, instance variables), must be set up in 4 different actions. This is extremely tricky, but works wonderfully if you follow Rails conventions. There will be many times where you will need to deviate from this convention, and you must keep in mind that view templates' dependencies must be set up correctly in all actions that render that template.

##### CRUD
CRUD is an acronym that stands for "create", "retrieve", "update" and "delete". You'll hear many developers say something like "we just need a CRUD web interface for tickets". This is what Rails gives us out of the box: an ability to perform basic CRUD actions on a resource as a web application. Below is how the default Rails actions map to CRUD:

* Create: `new`, `create`
* Retrieve: `index`, `show`
* Update: `edit`, `update`
* Delete: `destroy`

##### Render vs Redirect
You should also understand what a render is vs a redirect. Render compiles the template into HTML and sends the HTML back as part of the response. Redirect sends back a URL as part of the response; there's no HTML in a redirect. Most browsers follow the redirected URL automatically, and a new request is issued. All redirects will eventually lead to rendering of some template, otherwise your browser will display a "too many redirects" error.

Why does the URL stay at `/posts` when there's a validation error? Shouldn't it be `/posts/new`?
The request URL is what's showing up in the address bar, not the response. The response is processed by your browser. The request URL is shown in the address bar.

In the case of a new post form submission, the request URL is `/posts`. This has nothing to do with the response sent back. The URL only changes on successful post creation because in that case the response is a redirect, and your browser issues a new request, which changes the address bar.

### Nested Resources
Something like this.
```ruby
resources :posts, except: [:destroy] do
  resources :comments, only: [:create]
end
```
The route for creating a new comment will be nested inside the post route.
```
/posts/:post_id/comments
```

When building a form using `form_for`, need an array of objects.
```ruby
<%= form_for [@post, @comment] do |f| %>
  <div class="control-group">
    <%= f.label :body, 'Leave a Comment' %>
    <%= f.text_area :body, class: 'span4', rows: 3 %>
  </div>
  <%= f.submit 'Create Comment', class: 'btn btn-primary' %>
<% end %>
```

### Helpers
Keep presentation logic out of views. Place them in helpers. Use for presentation logic that is redundant. The model deals with application logic, not presentation logic. Helps to prevent scattering code throughout view templates.

### Where Does Code Go?
![Where Does Code Go?](where_does_code_go.png)
