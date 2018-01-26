# Week 1
## Lesson: The Rationale Behind Testing
Why Perform Automated Testing?

Alternatives
1. No testing (doesn't really exist), relies on customers to do testing
2. Rely on QA
  - QA team writes tests
  - creates organizational problems, distrust, communication between teams is typically not good.
  - Nobody likes the QA team: when things work, developers get credit, when they don't, QA is blamed for not catching bugs.
  - release cycle gets delayed

Impact of no automated tests on development
1. don't care about code quality
2. isolated knowledge
3. how do you know things work as all?
4. regression - how do you know things didn't break? (like when adding new features)

## Lesson: Technical Debt
On the TDD path, it is slow and steady - costing more initially but less in the end.
On the no test path, it's quick to get up and running but eventually the "technical debt" will build up, making adding new components difficult.

## Lesson: Unit, Functional, and Integration Tests

### Unit Test
Testing different components in isolation
Testing **models**, **views**, **helpers**, **routes**

### Functional Test
Testing multiple components in collaboration
Testing **controllers**

### Integration Test
Follow business process to achieve business objective.
Testing (emulating) the end user. Drive through the browser like a user would.

### Styles of Our Testing
Write a lot of tests for models, helper methods, controllers and emulate the user for **important** business flow.


Speed: U > F > I
Coverage: U > F > I
Realistic: I > F > U

### Summary
1. Maximize unit and functional tests
2. Integration Test for important business processes

## Lesson: First Test in Rspec
Install the rspec gem.
gem `rspec-rails` into both `:test` and `:development` groups in `Gemfile`

```ruby
group :test, :development do
  gem 'rspec-rails'
end
```
then
```bash
bundle install
```

Then run
```bash
rails g rspec:install
```
This will create `.rspec`, `spec` and `spec/spec_helper.rb` files.

`.rspec` will just have
```rspec
--color
```

`spec_helper.rb` is used to configure the rspec code itself.

---

In the `rspec` directory, create a folder called `models` to start testing the models.

Create a spec file for a model. For the case of a `Todo` model, create the file `spec/models/todo_spec.rb`. This will be used to test against the `Todo` model.

For all Rails testing with Rspec, require the spec helper.

```ruby
require 'spec_helper'
```
This will make Rspec load the Rails environment.

Make a test.

```ruby
describe Todo do
end
```

Run `rspec` in the root directory
```bash
rspec
```

The test should pass (green text somewhere).

### Rspec as behavior driven development.
Think about writing a specification of what the model should do.

3 phases of developing a test
1. set the environment
2. perform an action
3. verify the result is correct

```ruby
describe Todo do
  it "save itself"
end
```

`it` is a keyword in Rspec, followed by what it should do. Run `rspec` again and the test should be yellow (pending)

```ruby
describe Todo do
  it "save itself" do
    todo = Todo.new(name: "cook dinner", description: "I love cooking!")
    todo.save
    Todo.first.name.should == "cook dinner"
  end
end
```

The following syntax is also valid:
```ruby
describe Todo do
  it "save itself" do
    todo = Todo.new(name: "cook dinner", description: "I love cooking!")
    todo.save
    expect(Todo.first.name).to eq("cook dinner")
  end
```

`should` is another rspec keyword. The `==` is the matcher.

Run the test using `rspec`. Should give "1 example, 0 errors" and it should be green indicating that it passed.

### Some more examples
```ruby
require 'spec_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "monk", description: "a great video!", small_cover_url: "small_url.jpg", large_cover_url: "large_url.jpg")
    video.save
    expect(Video.first).to eq(video)
  end

  it "belongs to category" do
    dramas = Category.create(name: "TV Dramas")
    monk = Video.create(title: "monk", category: dramas)
    expect(monk.category).to eq(dramas)
  end

  it "does not save a video without a title" do
    video = Video.create(description: "a great video!")
    expect(Video.count).to eq(0)
  end

  it "does not save a video without a description" do
    video = Video.create(title: "monk")
    expect(Video.count).to eq(0)
  end
end
```

```ruby
require 'spec_helper'

describe Category do
  it 'saves itself' do
    category = Category.new(name: "TV Dramas")
    category.save
    expect(Category.first).to eq(category)
  end

  it 'has many videos' do
    comedies = Category.create(name: "TV Comedies")
    futurama = Video.create(title: "Futurama", description: "Space travel", category: comedies)
    family_guy = Video.create(title: "Family Guy", description: "family fun", category: comedies)

    expect(comedies.videos).to include(futurama, family_guy)
  end
end
```

### For `shoulda_matchers`
include `gem 'shoulda-matchers'` in the `Gemfile` the `bundle install`

## Lesson: Development and Test Databases

Look in the `APP_NAME/config/database.yml` for specification on the databases.

From my `myflix` app:
```yml
development:
  adapter: postgresql
  encoding: unicode
  database: myflix_development
  pool: 5
  username: ajdot
  password: Il2ep!!!

test:
  adapter: postgresql
  encoding: unicode
  database: myflix_test
  pool: 5
  username: ajdot
  password: Il2ep!!!
```

Can use SQLite3 as well
```yml
development:
  adapter: sqlite3
  database: db/development.sqlite3
  pool: 5
  timeout: 5000

test:
  adapter: sqlite3
  database: db/test.sqlite3
  pool: 5
  timeout: 5000
```

If we have test database we need to bring it up to speed with the development database:
```bash
rake db:migrate db:test:prepare
```

The migration will run and change the schema file. Then prepare will take the schema file and load the test database. The result will make the test database to have the same structure as the development database.

**NOTE**: Since Rails 4.1, you don't need to run `rake db:test:prepare` anymore. Rails will take care of this for you.

---

## Lesson: Github Flow and the Code Review Process
[Github Flow](http://scottchacon.com/2011/08/31/github-flow.html)
[Guide to Pull Requests](https://help.github.com/articles/about-pull-requests/)

## Lesson: From Test Later to Test Driven

Code first, test later => guards against regressions
Code a litter, test a little => feedback loop is smaller but essentially the same as code first, test later
Test First Development => Write tests before any implementation code, run tests and make sure they fail. Then implement until all tests pass.
  * Now you have a target to code towards

Test Driven Development (TDD) => Set an expected end result and use tests to drive out the logic/implementation code.
  * Usually used for something complex

Test Driven Design => Similar to TDD only that it works on more of a system level (instead of local level)

We will focus on code a little, test a little, test first development, and a little TDD.

## Lesson: TDD and Red-Green-Refactor
The basic TDD development process.
Start with failing tests, write minimal code until test passes. Then refactor while maintaining that test still passes.

```ruby
require 'spec_helper'

describe Todo do
  describe "#name_only?" do
    it "returns true if the description is nil" do
      todo = Todo.new(name: "cook dinner")
      todo.name_only?.should be true
    end

    it "returns true if the description is an empty string" do
    end

    it "returns false if the description is a non-empty string" do
    end
  end
end
```

Tests will fail. Go create the `#name_only?` method.

```ruby
class Todo < ActiveRecord::Base
  has_many :tags

  def name_only?
  end
end
```

Error again, expecting true but got nil. This is because the method is returning nil.

**For TDD you always write the easiest implementation that will allow the test to pass.**

```ruby
class Todo < ActiveRecord::Base
  has_many :tags

  def name_only?
    true
  end
end
```

The one test will pass but the other two will fail.

```ruby
require 'spec_helper'

describe Todo do
  describe "#name_only?" do
    it "returns true if the description is nil" do
      todo = Todo.new(name: "cook dinner")
      todo.name_only?.should be true
    end

    it "returns true if the description is an empty string" do
      todo = Todo.new(name: "cook dinner", description: "")
      todo.name_only?.should be true
    end

    it "returns false if the description is a non-empty string" do
    end
  end
end
```

Now 2 tests pass and one is still pending. Keep going.

```ruby
require 'spec_helper'

describe Todo do
  describe "#name_only?" do
    it "returns true if the description is nil" do
      todo = Todo.new(name: "cook dinner")
      todo.name_only?.should be true
    end

    it "returns true if the description is an empty string" do
      todo = Todo.new(name: "cook dinner", description: "")
      todo.name_only?.should be true
    end

    it "returns false if the description is a non-empty string" do
      todo = Todo.new(name: "cook dinner", description: "Potatoes")
      todo.name_only?.should be false
    end
  end
end
```

But this test will fail. Now we go back to the implementation; we are forced now to generalize and write the real implementation code.

```ruby
class Todo < ActiveRecord::Base
  has_many :tags

  def name_only?
    description.nil? || description == ""
  end
end
```

Now all tests should pass. We can refactor with some rails help.

```ruby
class Todo < ActiveRecord::Base
  has_many :tags

  def name_only?
    description.blank?
  end
end
```

## Lesson: Member Routes and Collection Routes

```ruby
TodoApp::Application.routes.draw do
  root to: 'todos#index'

  resources :todos, only: [:index] do
    collection do
      # 'todos/search'
      get 'search', to: 'todos#search'
    end

    member do
      # 'todos/:id/highlight'
      post 'highlight', to: 'todos#highlight'
    end
  end
end
```

## How to Design Test Cases?

* You should derive what you expect a piece of software to do (the happy path cases) from the product design and specification. In other words, those are not programming decisions, but product design decisions. If there's no clarity on this, it should be brought up to a high level (product owner / client / project manager, etc) to be discussed in detail, without a single line of code written. If you are working on your own product, go back to the white board and do more detailed feature planning.

* Most of your edge cases are going to be around supporting user's interaction and data inputs. Therefore it's helpful to think from the user's perspective and consider all the possible ways users can interact your app, and especially, how different types of user inputs could potentially break the app and how you handle them gracefully.

* Write your tests first. This way it forces you to think independent of your actual implementation. Otherwise after you implement it, you're likely to be boxed into one way of thinking and won't be able to consider more possibilities.

* Don't shoot for perfection. No matter how hard you try, you won't possibly imagine all the ways users will use your app. Set up run time monitoring (we'll cover this in week 5), and when users "break" your app, you can convert that edge case into a test case and build up your test coverage over time this way.

## Lesson Custom Form Builder

Here is a way to build a custom form that displays errors easily and automatically.

```haml
/ new.html.haml
%section.new_todo
  %h3 Add a new todo
  = my_form_for @todo do |f|
    = f.label :name, "Name"
    = f.text_field :name
    = f.label :description, "Description"
    = f.text_area :description, rows: 6
    %br
    = f.submit "Add This Todo"
```

```ruby
# APP_NAME/app/helpers/my_form_builder.rb

class MyFormBuilder < ActionView::Helpers::FormBuilder
  def label(method, text = nil, options = {}, &block)
    error = object.errors[method.to_sym]
    if errors
      text += " <span class=\"error\">#{errors.first}</span>"
    end
    super(method, text.html_safe, options, &block)
  end
end
```

```ruby
# APP_NAME/app/helpers/applicatoin_helper.rb

module ApplicationHelper
  def my_form_for(record, options = {}, &proc)
    form_form(record, options.merge!({builder: MyFormBuilder}), &proc)
  end
end
```

## Lesson: Custom Form Builders in the Wild
[formtastic](https://github.com/justinfrench/formtastic)
* Use `semantic_form_for` and its own DSL

[simpleform](https://github.com/plataformatec/simple_form)
* Use `simple_form_for`, support hints and inline labels
* Integrate will Twitter Bootstrap
* didn't like it because it doesn't work well with a lot of customization

[bootstrapform](https://github.com/potenza/bootstrap_form)
* Use `bootstrap_form_for`
* similar DSL to the normal Rails helper
* can add alert message
