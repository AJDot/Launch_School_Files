# Week 4
## Testing Styles in Rails

What we have been doing:
**meet in the middle**.
1. Turning mockups into view templates.
    Replace placeholder data with data from controllers
2. Do controller tests (TDD) for actions we want to build.
3. May do model tests if controllers have complex logic that needs to be pushed down to model layer.
4. Feature specs / integration tests
    May occur after several loops of 1-3.

This is not as rigorious as BDD but it is easier to start. Typically write integration specs after multiple features are done which means you don't write as many.


There is also **"inside out"**.
Start from models, then move to controller level (setting correct data, etc), then integration tests. This is less of a hurdle to start with but the disadvantage is that it is not clear where you are coding to.
Typically this is done when adding small features to an already mature product.


**Behavior Driven Development (BDD)**
**Acceptance BDD (ABBD)**
There is also "outside in". Start at integration level, though this is not the same as horizontal integration testing that we have been doing. This is more of a vertical integration, exercise the controllers, models, and views. This is written in a very business-level description. First think about the business value you are delivering.
    1. Integration
    2. Controller
    3. Models

So the client/business person typically describes the acceptance part of the test then the developer uses BDD.

Requires being very proficient with Rails and testing in general because you have to write the high-level integration tests first. And here there is an integration test for every feature, so there are a lot of them.


## Lesson: Self Referential Associations
In Rails this is called a **Self Join**.

Example:
```ruby
class Employee < ActiveRecord:Base
  has_many :subordinates, :class_name => "Employee", :foreign_key => "manager_id"
  belongs_to :manager, :class_name => "Employee"
end
```

The `Employee` class is referencing itself. This allows an employee to have other employee be his/her subordinates and allows an employee to have a manager, which is another employee.

Watch this [Rails Cast](https://railscasts.com/episodes/163-self-referential-association) for another example.

## Lesson: Send Emails with ActionMailer

In the Todos app, want to send an email to the current signed in user whenever a todo is added.

Rails provides `ActionMailer` class. Extend that class. Mailers also have a similar thing to views with respect to controllers (some kind of template).

```ruby
# app/mailers/app_mailer.rb

class AppMailer < ActionMailer::Base
  def notify_on_new_todo(user, todo)
    @todo = todo
    mail from: 'info@mytodoapp.com', to: user.email, subject: 'You created a new todo!'
  end
end
```

The template. Some code has been copied from the application layout.
```html
<!-- app/views/app_mailer/notify_on_new_todo.html.erb -->
<!DOCTYPE html>
<html>
  <body>
    <p>You created a new todo!</p>
    <p>The todo is <%= @todo.name %>.</p>
  </body>
</html>
```

Now in the `TodosController` we need to call this method. Don't forget the `deliver` method.
```ruby
class TodosController < ApplicationController
  def index
    @todos = Todo.all
    @todo = Todo.new
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save_with_tags
      AppMailer.notify_on_new_todo(current_user, @todo).deliver
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :description)
  end
end
```

## Lesson: Email Configurations

Go to the Rails guides and look under Action Mailer Basics -> Action mailer Configuration

The configs that are used a lot are:
* smtp_settings
* delivery_method

There is even a configuration example for gmail.

We'll put some configurations into our todo app. This will be located in `config/environments/development.rb`. These files are use to configure the application. So you don't really want to send emails from development environment, only from production environment. So copy/paste the rails guides example for gmail at the bottom of the production config file.

Write this:
```ruby
# config/environments/production.rb
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'example.com',
  user_name:            '<username>',
  password:             '<password>',
  authentication:       'plain',
  enable_starttls_auto: true  }
```

Domain depends on if it is a gmail or google app account. Input username and password. In production it will send them for real.

In the development.rb config file, look at this line. (This line is not present in Rails 5.1.4.)
```ruby
config.action_mailer.delivery_method = :smtp
```

If this line is not present then the content of the email will be dumped into the server log.
Alternatively we can use a gem called letter opener
```ruby
config.action_mailer.delivery_method = :letter_opener
```
Add the gem
```ruby
# Gemfile
group :development do
  gem 'letter_opener'
end
```

This will cause the email to appear in the browser.

## Lesson: Handling Sensitive Account Info

Sensitive info in plain text in source code is a terrible thing. Anyone with the source code would have the info now.

Instead, put them as environment variables on the server. This is a limited access area.

Instead of the above code, write this instead.
```ruby
# config/environments/production.rb
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'example.com',
  user_name:            ENV['gmail_username'],
  password:             ENV['gmail_password'],
  authentication:       'plain',
  enable_starttls_auto: true  }
```

Read [this article](https://devcenter.heroku.com/articles/config-vars) on how to do this on heroku.

Read [this other article](http://railsapps.github.io/rails-environment-variables.html) on Rails environment variables.

## Lesson: Test Email Sending

```ruby
# spec/controllers/todos_controller_spec.rb

describe TodosController do
  context "email sending" do
    it "sends out the email" do
      post :create, todo: { name: "show AT the Apple Store" }
      ActionMailer::Base.deliveries.should_not be_empty
    end

    it "sends to the right recipient" do
      post :create, todo: { name: "show AT the Apple Store" }
      message = ActionMailer::Base.deliveries.last
      message.to.should == [alice.email]
    end

    it "has the right content" do
      post :create, todo: { name: "show AT the Apple Store" }
      message = ActionMailer::Base.deliveries.last
      message.from.should include("show AT the Apple Store")
    end
  end
end
```

Since ActionMailer does not hit the database like transactions do, they won't be rolled back. We need a way to reset the ActionMailer after each test.
Just like `before`, add an `after` method to the context.
```ruby
after { ActionMailer::Base.deliveries.clear }
```

## Lesson: Setting Random Tokens
to identify resources

In the Todos app, the URL contains the id of the todo, just a integer, very predictable. This may allow the user the type in other ids in hope of accessing other todos they should not be allow to access.
This also reveals information about the system itself. If you create a todo and the id is 20, then the user knows that there is probably only 20 todos in the app.

A way around this is to use random tokens

```ruby
# migration to add token column
class AddTokenToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :token, :string
  end
end
```

Run the migration.

Now need to add the method `to_param`. The `to_param` method is Rails' way to turn a record into a url path. We can override this to use our token.

```ruby
class Todo < ActiveRecord::Base
  def to_param
    token
  end
end
```

Now we need to random generate the token when a new todo is created.

```ruby
class Todo < ActiveRecord::Base
  before_create :generate_token # only done once when first created, not on every save

  private

  def generate_token
    # SecureRandom module is a Ruby way to generate random strings. Include method for urls.
    self.token = SecureRandom.urlsafe_base64
  end
end
```

We'll need to update all the records already created to include a token. We can do this right in the migration.

```ruby
# migration to add token column
class AddTokenToTodos < ActiveRecord::Migration[5.1]
  def change
    add_column :todos, :token, :string
    Todo.all.each do |todo|
      todo.token = SecureRandom.urlsafe_base64
      todo.save
    end
  end
end
```

This is ok for updating a small amount of record. SQL should be used if there are many.

## Create Reset Password Feature
Refer to the MyFlix project for implementation.

Be sure to set
```ruby
# config/development.rb
config.action_mailer.default_url_options = { host: 'localhost:3000' }
```
```ruby
# config/production.rb
config.action_mailer.default_url_options = { host: 'my_online_host' }
```

This allows the full url to be set in the user's email so they can click the link to reset their password.

Also don't forget smtp settings.
```ruby
# config/production.rb
config.action_mailer.delivery_method = :smtp
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  domain:               'gmail.com',
  user_name:            ENV['GMAIL_USERNAME'],
  password:             ENV['GMAIL_PASSWORD'],
  authentication:       'plain',
  enable_starttls_auto: true
}
```

For production just open the email in the browser with `letter_opener`.
```ruby
config.action_mailer.delivery_method = :letter_opener
```

Extra details:
The routes that were created:
```ruby
get 'forgot_password', to: 'forgot_passwords#new'
resources :forgot_passwords, only: [:create]
get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
resources :password_resets, only: [:show, :create]
get 'expired_token', to: 'password_resets#expired_token'
```

The migrations that were created:
```ruby
# add_token_to_users.rb
class AddTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :token, :string
  end
end
```
```ruby
# generate_tokens_for_existing_users.rb
class GenerateTokensForExistingUsers < ActiveRecord::Migration
  def change
    User.all.each do |user|
      user.update_column(:token, SecureRandom.urlsafe_base64)
    end
  end
end
```

## How DHH Organized His Rails Code
Read [this article](http://jeromedalbert.com/how-dhh-organizes-his-rails-controllers/) to get a better perspective on why we created a few controllers for "follow friends", "forgot password", and "reset password" features in the MyFlix app.
