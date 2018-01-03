# Lesson 4

## AJAX in Ruby on Rails

1. Need to have some event.
  This will be the links for voting (in the PostIt! app)
  Add `remote: true` to the link.

```erb
<%= link_to vote_post_path(post, vote: true), method: 'post', remote: true do %>
```

  That is all that is needed to create an ajax request for the link.

2. For an ajax request we now do not want to `redirect_to` to reload the page. We want to handle the response ourselves. Replace the redirect with something like this:

```ruby
respond_to do |format|
  format.html { redirect_to :back, notice: "Your vote was counted" }
  format.js { render json: @post }
end
```

We now need to make a JavaScript template at `vote.js.erb`.
We need a way to identify the elements, add an id to the elements we want to update. Like `id='post_<%= @post.id %>_votes`.
```javascript
$('#post_<%= @post.id %>_votes').html(<%= @post.total_votes %>);
```

Review:
1. Specify `remote: true` in the link (or whatever you want to be an ajax call).
2. Tell the Rails action how to handle the request.
3. Specify the format then handle the request depending on the format.

## Slugging
Use a unique identifies for resources in application that is not the id. So that in the url we don't have ids, but a slug identification instead.

Benefits:
1. You get a nice SEO.
2. Security
3. Data integrity

The paths methods in Rails essentially calls `to_param` on an object to get the path. All we need to do is create our own `to_param` on the controller to override the general on.

1. Create a column in the database table called `slugs`.
2. Create a method called `generate_slug` on the model.
    ```ruby
    self.slug = self.title.gsub(' ', '-').downcase # trivial example
    self.save # make sure the slug is saved to the database
    ```
2. OR instead, add this code to ActiveRecord callbacks. We want to generate the slug
    ```ruby
    after_create :generate_slug
    # OR
    after_save :generate_slug
    # OR
    # Want it after validations and before save
    after_validation :generate_slug
    ```

If the callback is executed before the save then don't put `self.save` in the `generate_slug` method.

If you are just creating this with data already in the database, then go to the rails console and just save every object.
    ```
    Post.all.each { |post| post.save }
    ```

3. Then we have to change how we find objects.
  Instead of
    ```
    @post = Post.find(params[:id])
    ```
  We need
    ```
    @post = Post.find_by(slug: params[:id])
    ```

## Simple Admin Role (Permissions)
1. Have a role column for users that takes a string and specify whatever roles you want.
2. Then before actions, check if the user has the right role do perform that action.

1. Create a string column called `role` (with a migration)
2. Create methods to return booleans to check if a user has a role.
    ```ruby
    # The object's controller
    def admin?
      self.role == 'admin'
    end

    def moderator?
      self.role == 'moderator'
    end

    # ApplicationController
    def require_admin
      access_denied unless logged_in? and current_user.admin?
    end

    def access_denied
      flash[:error] = "You can't do that"
      redirect_to root_path
    end
    ```
3.
  ```ruby
  before_action :require_user
  before_action :require_admin
  ```

## Timezones
Add `%Z` to date format helper.

1. Set the default timezone in the `application.rb`
2. Find the `rake time:zones:all` to find the valid ones for rails
3. `rake time:zones:all | grep US`
4. Then set it in the `application.rb`
5. Set a user's specific timezone
6. Create a timezone column for users. (migration) (it's also just a string)
7. In the user's form, when they register, they can select their timezone.
```erb
<%= f.label :time_zone %>
<%= f.time_zone_select :time_zone, ActiveSupport::TimeZone.us_zones %>
```
8. Let timezone through in the strong parameters.
9. Then manipulate the `display_datatime(dt)` method to display the user's timezone if it exists
```ruby
if logged_in? && !current_user.time_zone.blank?
  dt = dt.in_time_zone(current_user.time_zone)
end  
# rest of method...
```

## Voteable Validations (ajax and regular flow)
In the `Vote` model:
```ruby
validates_uniqueness_of :creator, scope: :voteable
```

Important part is that this kind of business logic always belongs at the model layer because votes may be created or view from multiple places. Having this logic at the model makes makes sure that no matter where it is used or accessed, this logic will be utilized.

In the controller#vote method, we need to handle the validation.

For the non-ajax path.
```ruby
respond_to to |format|
  format.html do
    if @vote.valid?
      flash[:notice] "Your vote was counted."
    else
      flash[:error] = "You can only vote on a post once."
    end
    redirect_to :back
  end

  format.js
end
```

For the ajax path, in `vote.js.erb`, make an `if else` to add an alert when there is an error.

## Exposing APIs
Need a route to access an action. Need the HTTP verb + path + params. Rails has a convention that if you append a `.js` to the end of the url.

Just use `respond_to` and the correct format:
```ruby
respond_to do |format|
  format.html
  format.js
  format.json do
    # parses the data and builds a json object out of it
    render json: @post
  end
  format.xml do
    # parses the data and builds a xml object out of it
    render xml: @post
  end
end
```

API versioning is a huge topic. Can't just change the format/data whenever because users of your API expect a certain format.

## Extracting Common Logic
**Voting** - a polymorphic table
Both posts and comments have it. How do we extract common instance methods out of a class.

Create a module. The module will be inserted in the method lookup chain right after the class it is inserted in.

In the `application.rb` file. Add in:
```ruby
config.autoload_paths += %W(#{config.root}/lib)
```

Append this array of strings to the autoload paths. `config.root` is the root folder of the application.

Now in the `lib` folder, create a `voteable.rb` file and create the `Voteable` module.

```ruby
module Voteable
  extend ActiveSupport::Concern

  def total_votes
  end

  # Do this to add class methods
  module ClassMethods
    def my_class_method
    end
  end
end
```

Now add `include Voteable` to the `Post` and `Comment` models.

`ActiveSupport::Concern` also gives us `included` support so that when the module is being included, execute the code in this block:
We can put code in here that will be executed once when the module is included.
```ruby
  module Voteable
    extend ActiveSupport::Concern

    included do
      has_many :votes, as: :voteable
    end
  end
```
Now this can be removed in the `Post` and `Comment` models as well. Another way to DRY up the code.


## Creating and Publishing a Gem
What if we wanted to take this one step farther and add this functionality to other projects?

Need a gem called `gemcutter (0.7.1)`

Create a new project `voteable-gem`. This is not a Rails projects.

1. Need a gem specification file, `voteable.gemspec`
```ruby
Gem::Specification.new do |s|
  s.name = "voteable_alex"
  s.version = "0.0.0"
  s.date = '2017-12-24'
  s.summary = "A voting gem"
  s.description = "The best voting gem ever."
  s.author = ['Alex Henegar']
  s.email = 'alex.henegar19@gmail.com'
  s.files = ['lib/voteable_alex']
  s.homepage = "http://github.com"
end
```
2. Create folder `lib` and file `voteable_alex.rb`
3. Module name must match file name.
```ruby
module VoteableAlex
  # copy and post the code from above into here.
end
```
4. Use `gemcutter` gem.
```
gem build voteable.gemspec
gem push voteable_alex-0.0.0.gem
```
5. If it is the first time, it will ask for a username and password to Rubygems.
6. Now it is published on Rubygems.
7. Include the gem in the project `Gemfile` using `voteable_alex`
8. `bundle install --without production`
9. Now `require 'voteable_alex'` in `application.rb` (or just anywhere before it is used)
10. In model, include module name `include VoteableAlex`.
11. Every time you make a change, up the version number, then build and publish again. (And maybe specify a version number in the `Gemfile`)
12. If testing locally, then specify the full path of the gem (up to the parent directory) in the `Gemfile`
```ruby
gem 'voteable_alex', path: '/Users/alex/full/path/to/gem/voteable-gem'
```
13. Use `gem yank voteable_alex` to make it inaccessible to other users but will not remove it from your rubygems.org profile.

## Two Factor Authentication with Twilio
1. "phone" (user supplies) and "pin" columns (strings)
2. Change login logic
    1. after successful login, is phone number present?
        1. not => normal login process
    2. yes
        1. generate a pin number
        2. send it off to Twilio to sms to phone
        3. show a form to enter pin (myapp.com/pin)
            1. restrict access of /pin to only see it after successful login
