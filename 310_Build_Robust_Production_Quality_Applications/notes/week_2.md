# Week 2

## Lesson: The Built in Rspec Matchers
[Relishapp.com](https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers)

## Lesson: Write Controller Test

Typically categorized under functional tests. Controller will pull/manipulate data from different models. Less of testing a single unit, but of multiple components in collaboration.

Our example code:
```ruby
class TodosController < ApplicationController
  def index
    @todos = Todo.all
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(params[:todo])
    if @todo.save
      redirect_to root_path
    else
      render :new
    end
  end
end
```

for newer Rails
```
NoMethodError:
       assigns has been extracted to a gem. To continue using it,
               add `gem 'rails-controller-testing'` to your Gemfile.
```
The `assigns` has been extracted to a gem.

Also include these in the `.rspec` file:
```
--require spec_helper
--require rails_helper
```

Rspec for this controller. Create in `spec/controllers`, file called `todos_controller_spec.rb`. Some of these methods are deprecated and won't be supported very soon. Look up new syntax.

```ruby

require 'spec_helper'

describe TodosController  do
  describe 'GET index' do
    it "sets the @todos variable" do
      cook = Todo.create(name: "cook")
      sleep = Todo.create(name: "sleep")

      get :index
      assigns(:todos).should == [cook, sleep]
    end

    it "renders the index template" do
      get :index
      response.should render_template :index
    end
  end

  describe 'GET new' do
    it "sets the @todo variable" do
      get :new
      assigns(:todo).should be_new_record
      assigns(:todo).should be_instance_of(Todo)

    end

    it "renders the new template" do
      get :new
      response.should render_template :new
    end
  end

  describe 'POST create' do
    it "creates the todo record when the input is valid" do
      post :create, params: {todo: {name: "cook", description: "I like cooking!"}}
      Todo.first.name.should == "cook"
      Todo.first.description.should == "I like cooking!"
    end

    it "redirects to the root path when the input is valid" do
      post :create, params: { todo: {name: "cook", description: "I like cooking!"} }
      response.should redirect_to root_path
    end

    it "does not create a todo when the input is invalid" do
      post :create, params: { todo: {description: "I like cooking!"} }
      Todo.count.should == 0
    end

    it "renders the new template when the input is invalid" do
      post :create, params: { todo: {description: "I like cooking!"} }
      response.should render_template :new
    end
  end
end
```

## Lesson: Dealing with Cardinality and Boundary Conditions in TDD

Want to display tags in line if there are tags on the todo.

When testing with number of items you want to follow the 0, 1, many, and boundary condition rule. Test each one.

```ruby
class Todo < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :name

  def name_only?
    description.blank?
  end

  def display_text
    if tags.any?
      "#{name} (#{tags.one? ? 'tag' : 'tags'}: #{tags.first(4).map(&:name).join(', ')}#{', more...' if tags.count > 4})"
    else
      name
    end
  end
end
```

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

  describe '#display_text' do
    it "displays the name when there's no tags" do
      todo = Todo.create(name: "cook dinner")
      todo.display_text.should == "cook dinner"
    end

    it "displays the only tag with word 'tag' when there's one tag" do
      todo = Todo.create(name: "cook dinner")
      todo.tags.create(name: "home")
      todo.display_text.should == "cook dinner (tag: home)"
    end

    it "display name with multiple tags" do
      todo = Todo.create(name: "cook dinner")
      todo.tags.create(name: "home")
      todo.tags.create(name: "urgent")
      todo.display_text.should == "cook dinner (tags: home, urgent)"
    end

    it "displays up to four tags" do
      todo = Todo.create(name: "cook dinner")
      todo.tags.create(name: "home")
      todo.tags.create(name: "urgent")
      todo.tags.create(name: "help")
      todo.tags.create(name: "book")
      todo.tags.create(name: "patience")
      todo.display_text.should == "cook dinner (tags: home, urgent, help, book, more...)"
    end
  end
end
```

## Lesson: Refactor in TDD

> "Add feature in the red, refactor in the green."

The main purpose of refactoring is the make the public interface clean and easy to understand/follow. There are diminishing returns for refactoring the private method but can still be done.

```ruby
class Todo < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :name

  def name_only?
    description.blank?
  end

  def display_text
    name + tag_text
  end

  private

  def tag_text
    if tags.any?
      " (#{tags.one? ? 'tag' : 'tags'}: #{tags.first(4).map(&:name).join(', ')}#{', more...' if tags.count > 4})"
    else
      ""
    end
  end
end
```

## Lesson: An Alternative Style of RSpec
using `let`, `before`, `subject`, etc.

Using `let` is preferred for the following reasons: [reasons](http://stackoverflow.com/questions/5359558/when-to-use-rspec-let/5359979#5359979).

* As a guideline, we prefer using let over using instance variables in specs. You can read this answer to understand it a bit more.
* To understand how let allows lazy evaluation, see the code below:

```ruby
# this:
let(:foo) { Foo.new }

# is very nearly equivalent to this:
def foo
  @foo ||= Foo.new
end
```

with a let, you are essentially defining a method that can be executed. the code inside of the method won't be executed when the method is defined, but when it's called. Also, the memoization pattern ensures that whatever inside of a let block is only computed / executed once - when it's called again it just simply return the value stored in the `@foo` instance var, in the example above.

---

Looking at the `display_text` tests...

We have lots of repeated code in the tests.

Give each test case a context. When there is context we can add `before` within the context.

Pros:
* Takes common setups from each test case, and subject, and consolidates

Cons:
* If you have a lot of tests, then the setup may be very far from the actually test in the file. May be hard to read.

Suggestion:
* Start with the simple `describe` style, then refactor once all tests are done if you feel it's necessary

When RSpec sees `let ...` it doesn't evaluate it immediately. Same goes for `subject`. When it evaulates the test cases and sees `it` then it evaluates the subject and sees it's a `todo` and then references the `let(:todo)` and evaluates that code.
This is lazy evaluation.

You can use `let!(:todo)` if you don't want the lazy evaluation. It will create the `todo` immediately.

## Lesson: The Single Assertion Principle

The Single Assertion Principle and how it should be applied.

> For every test case you should only have one assertion.

Want to make sure these assertions are in different test cases so they can fail separately.
A sign you are trying to test too much in a single test is if you use the word "and" in the description

There are always exceptions though:
```ruby
it "sets the @todo variable" do
  get :new
  assigns(:todo).should be_new_record
  assigns(:todo).should be_instance_of(Todo)
end
```
These 2 assertions are both necessary to test this single idea.

## Lesson: Object Generation with Fabrication

How to use Fabrication to generate test objects.

[fabricationgem.org](http://www.fabricationgem.org/)

Create `spec/fabricators/todo_fabricator.rb`.
```ruby
Fabricator(:todo) do
  name { "cooking" }
end
```

Then inside the tests when can do:
```ruby
let(:todo) { Fabricate(:todo) }
```

Works for associations too.
```ruby
Fabricator(:todo) do
  name { "cooking" }
  user { Fabricate(:user) }
end

# OR simply

Fabricator(:todo) do
  name { "cooking" }
  user
end
```

If you don't want the fabrication to hit the database, use `Fabricate.build(:todo)`. It is similar to `ActiveRecord.new` instead of `.create`.

## Lesson: Generate Fake Data

Could use Fabrication sequences to makes sure objects are unique.
OR
Use [Faker](https://github.com/stympy/faker) to generate fake data

include `gem faker` in the `Gemfile`

```ruby
Fabricator(:user) do
  email { Faker::Internet.email }
end
```

---

```ruby
Fabricator(:todo) do
  name { Faker::Lorem.words(5).join(" ") }
end
```

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

  describe '#display_text' do
    let(:todo) { Fabricate(:todo) }
    let(:subject) { todo.display_text }

    context "no tags" do
      it { should == "#{todo.name}" }
    end

    context "one tag" do
      before { todo.tags.create(name: "home") }
      it { should == "#{todo.name} (tag: home)" }
    end

    context "multiple tags" do
      before do
        todo.tags.create(name: "home")
        todo.tags.create(name: "urgent")
      end
      it { should == "#{todo.name} (tags: home, urgent)" }
    end

    context "more than four tags" do
      before do
        todo.tags.create(name: "home")
        todo.tags.create(name: "urgent")
        todo.tags.create(name: "help")
        todo.tags.create(name: "book")
        todo.tags.create(name: "patience")
      end
      it { should == "#{todo.name} (tags: home, urgent, help, book, more...)" }
    end
  end
end
```
