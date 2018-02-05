# Week 3

## Lesson: Growing Complexity Guided by Tests

Make small steps in testing. Even though you know the next small steps won't make the test pass, run it anyway to see where you are. The more you check up on your progress the quicker you will hone in on the missing code.

Example Code
```ruby
def create
  @todo = Todo.new(todo_params)
  if @todo.save
    location_string = @todo.name.split('at').last
    locations = location_string.split(/\,(?: and)?|and/).map(&:strip)
    locations.each do |loc|
      @todo.tags.create(name: "location:#{loc}")
    end
    redirect_to root_path
  else
    render :new
  end
end
```
```ruby
describe TodosController do
  # rest of code...
  context "with inline locations" do
    it "creates a tag with one location" do
      post :create, params: { todo: {name: "cook at home"} }
      Tag.all.map(&:name).should == ['location:home']
    end

    it "creates two tags with two locations" do
      post :create, params: { todo: {name: "cook at home and work"} }
      Tag.all.map(&:name).should == ['location:home', 'location:work']
    end

    it "creates multiple tags with four locations" do
      post :create, params: { todo: {name: "cook at home, work, school, and library"} }
      Tag.all.map(&:name).should == ['location:home', 'location:work', 'location:school', 'location:library']
    end
  end
end
```

## Lesson: Interactive Debugging for Solution Discovery
How to deal with bugs, wrap bugs with tests, and use debugger to find solutions.

The above code actually displays a location when no "at" is provided. e.g. inputting just "play" will return "play (tag: location:play)"

Need to trap the bug in a test. Create a test that will fail.

```ruby
  it 'does not create tags without inline locations' do
    post :create, params: { todo: { name: 'cook' } }
    Tag.count.should == 0
  end
```

This test will fail because a tag is being created even though no location is provided. So put a binding.pry in there somewhere and play around until you make the test pass.

```ruby
def create
  @todo = Todo.new(todo_params)
  if @todo.save
    location_string = @todo.name.slice(/.*at(.*)/, 1)
    if location_string
      locations = location_string.split(/\,(?: and)?|and/).map(&:strip)
      locations.each do |loc|
        @todo.tags.create(name: "location:#{loc}")
      end
    end
    redirect_to root_path
  else
    render :new
  end
end
```

inputting "eat an apple" will create a location tag because it will match "at" in "eat". This is definitely a bug, so create a test to capture it.

**Create a test to replicate the bug, then fix code until it passes.**


```ruby
it 'does not create tags at in a word without inline locations' do
  post :create, params: { todo: { name: 'eat an apple' } }
  Tag.count.should == 0
end
```

This particular one is a simple fix:
```ruby
# ...
  location_string = @todo.name.slice(/.*\bat\b(.*)/, 1)
# ...
```

## Lesson: Respond to Feature Changes
How to respond to feature changes with tests

What if we input "get good at swimming" but we don't want "at" to create a location tag. So we have a flaw in our design, it's not just a bug.

We can choose to use the upcase version "AT" to distinguish when to create a location.

We need to implement the new specification first, before taking care of the regression (we know passing this test will break the other tests). This new test will serve at the protection to ensure we capture the new feature/implementation.

So create the new test first:
```ruby
it 'creates a tag with upcase AT' do
  post :create, params: { todo: { name: 'shop AT the Apple Store' } }
    Tag.all.map(&:name).should == ['location:the Apple Store']
end
```

Fix it by using the upcase version of 'at'.
```ruby
location_string = @todo.name.slice(/.*\bAT\b(.*)/, 1)
```

Now this test will pass but other tests fail. We can go through the other tests and replace 'at' with 'AT'. This was a simple fix.

## Lesson: Transactions
Wrap batch operations in [transactions](http://markdaggett.com/blog/2011/12/01/transactions-in-rails/)
In the MyFlix app, we want the list order of the my queue to be validated altogether.

Use ActiveRecord Transactions to do this. Inside the block of the transaction, it will hit the database if everything inside the block passes and will rollback if not.
You should also understand [parameter naming conventions](http://guides.rubyonrails.org/form_helpers.html#understanding-parameter-naming-conventions) in Rails.

Think first about the data you want to send to the form. it serves as the contract between the form and the controller action. The data needs to be formatted in the right way for us to use in Rails.

**When using transactions, the data that fails to save must raise an exception or else the rollbaack won't occur.**

Example:

```ruby
class QueueItemsController < ApplicationController
  # rest of code
  def update_queue
    begin
      update_queue_items
      normalize_queue_item_positions
    rescue ActiveRecord::RecordInvalid
      flash[:danger] = "invalid position numbers."
    end

    redirect_to my_queue_path
  end

  private
  # rest of code

  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update_attributes!(position: queue_item_data["position"])
      end
    end
  end

  def normalize_queue_item_positions
    current_user.queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end
```

TESTS (needs to be refactored)
```ruby
describe QueueItemsController do
  describe "DELETE destroy" do
    it "normalizes the remaining queue items" do
      alice = Fabricate(:user)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
      queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
      delete :destroy, id: queue_item1.id
      expect(QueueItem.first.position).to eq(1)
    end

  describe "POST update_queue" do
    context "with valid inputs" do
      it "redirects to the my queue page" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(response).to redirect_to my_queue_path
      end

      it "reorders the queue items" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 2}, {id: queue_item2.id, position: 1}]
        expect(alice.queue_items).to eq([queue_item2, queue_item1])
      end

      it "normalizes the position numbers" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(alice.queue_items.map(&:position)).to eq([1, 2])
      end
    end

    context "with invalid inputs" do
      it "redirects to the my queue page" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end

      it "sets the flash danger message" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3.4}, {id: queue_item2.id, position: 2}]
        expect(flash[:danger]).to be_present
      end

      it "does not change the queue items" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2.1}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end

    context "with unauthenticated users" do
      it "redirects to the sign in path" do
        post :update_queue, queue_items: [{id: 2, position: 3}, {id: 3, position: 2}]
        expect(response).to redirect_to sign_in_path
      end
    end

    context "with queue items that do not belong to the current user" do
      it "does not change the queue items" do
        alice = Fabricate(:user)
        session[:user_id] = alice.id
        bob = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_items: [{id: queue_item1.id, position: 3}, {id: queue_item2.id, position: 2}]
        expect(queue_item1.reload.position).to eq(1)
      end
    end
  end
end
```

## Lesson: Structural Refactor

Push business concerns from the controller level down to the model level.
Before
```ruby
class TodosController < ApplicationController
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      location_string = @todo.name.slice(/.*\bAT\b(.*)/, 1)
      if location_string
        locations = location_string.split(/\,(?: and)?|and/).map(&:strip)
        locations.each do |loc|
          @todo.tags.create(name: "location:#{loc}")
        end
      end
      redirect_to root_path
    else
      render :new
    end
  end
end
```

After
```ruby
class TodosController < ApplicationController
  def create
    @todo = Todo.new(todo_params)
    if @todo.save_with_tags
      redirect_to root_path
    else
      render :new
    end
  end
end
```
AND
```ruby
class Todo < ActiveRecord::Base
  def save_with_tags
    if save
      create_location_tags
      true
    else
      false
    end
  end

  private

  def create_location_tags
    location_string = name.slice(/.*\bAT\b(.*)/, 1)
    if location_string
      locations = location_string.split(/\,(?: and)?|and/).map(&:strip)
      locations.each do |loc|
        tags.create(name: "location:#{loc}")
      end
    end
  end
end
```

All tests should still pass. If not, then the refactor was not done successfully.

In regards to moving the tests from the todo_controller_spec to the todo_spec, don't do it unless you are implementing something more in the new code.
The tests are there to ensure that refactoring is successful. Modifying them may negate this purpose.

## Lesson: Skinny Controller, Fat Model
One of the most popular Rails architectural guidelines. Essentially push logic down to the model layer if it makes sense. The controllers should just delegate actions.

[Jamis Buck Article](http://weblog.jamisbuck.org/2006/10/18/skinny-controller-fat-model)

## Lesson: Macros

```ruby
before do
  john = Fabricate(:user)
  session[:user_id] = john.id
end
```
Instead of placing the following code in front of every describe section, create a macro for it that better explains what the code is doing.

The `spec/support` directory will be automatically loaded by rspec

Create the file `spec/support/macros.rb`
```ruby
def set_curent_user
  john = Fabricate(:user)
  session[:user_id] = john.id
end

def current_user
  User.find(session[:user_id])
end
```

Now in the before action we can say

```ruby
before { set_current_user }
```

Now we can set the current user and access it by saying `bob = current_user`.

## Lesson: Shared Examples
Shared Examples in RSpec

Want to test all the actions for when the user is not signed in.

Assuming we have the `before` up above running, we need to first sign out then do our test.
```ruby
it "redirects user to the root path if they are not signed in" do
  clear_current_user
  get :index
  response.should redirect_to root_path
end
```

`clear_current_user` is another macro.
In `spec/support/macros.rb`
```ruby
def clear_current_user
  session[:user_id] = nil
end
```
Now the test should pass.

This is for one action, we want to do this for all the other actions as well. We could just copy the code above and paste it into every action test.
Instead, though, we will use shared examples.

Create `spec/support/shared_examples.rb`
```ruby
shared_examples "require_sign_in" do
  it "redirects to the front page" do
    clear_current_user
    action
    response.should redirect_to root_path
  end
end
```

Then instead of this:
```ruby
it "redirects user to the root path if they are not signed in" do
  clear_current_user
  get :index
  response.should redirect_to root_path
end
```

We can write this:
```ruby
it_behaves_like "require_sign_in" do
  let(:action) { get :index }
end
```

Now we can just paste this in every action and change the `get :index` part to whichever request we need to make.

```ruby
it_behaves_like "require_sign_in" do
  let(:action) { post :create, params: { todo: {name: 'something'} } }
end
```

## Lesson: Feature specs

Types of Specs we've been writing:
* Models (model specs)
* Controllers (controller specs)
* Views, Routes, Helpers, Mailers
  * There are specs for each of these components
  * but unlike models and controllers we don't have to create individual specs for each view, helper, etc.
  * Usually people make **features specs**

Feature specs are used to mimic a user using the app in the browser. They will penetrate the whole stack (model, controller, view). Testing things from user/browser and integrate all components.

Another type of specs are **request specs** which spans across multiple requests/responses and make sure they execute in sequence. People do this to make sure a business process works.

However, you might as well operate on the user level and create feature specs instead.

## Lesson: [Capybara](https://github.com/teamcapybara/capybara#using-capybara-with-rspec)

A way to simulate a real user to interact with your app.

Two styles of using it
1. follows rspec convention
2. their own DSL
  * use `background` instead of `before`
  * use `scenario` instead of `it`
  * use `given` instead of `let`
  * it's a different syntax that reads a bit better, describing it more from a higher level, closer to the mindset of the tests.

### Drivers for Capybara
Default driver is called **RackTest**. It is very fast, not a real browser, it is a headless driver. RackTest **does not support JavaScript**.

**Selenium** actually fires up a real browser (Firefox). It is very slow as it actually launches the browser.

**Capybara-webkit** is another driver. Need to use the gem `capybara-webkit` and configure the javascript driver to use webkit `Capybara.javascript_driver = :webkit`. This is a headless browser but does support javascript.

### The DSL for Capybara
Use `visit` to visit URLs
Can `click` links
Can `fill_in` forms, `choose` radio buttons, `check` boxes.
Can query using `page.has_selector?`, and others.
Can check content with `page.has_content?`

Can find things with `find_field`, `find_link`, `find_button`, etc.

## Lesson: First Feature Spec

Add Capybara in testing gem
```ruby
group :test do
  gem 'capybara'
end
```

Need to add it to the test helper file, `spec_helper`
```ruby
require 'capybara/rails'
```

Using the Capybara DSL, here is the first test. Test should go in `spec/features` folder.

Create file called `user_signs_in_spec.rb`
```ruby
require 'spec_helper'

feature 'User signs in' do
  background do
    User.create(username: 'john', fullname: 'John Doe')
  end

  scenario 'with existing username' do
    visit root_path
    fill_in 'Username', with: 'john'
    click_button 'Sign in'
    page.should have_content 'John Doe'
  end
end
```

## Lesson: Another example of a feature spec
Watch [RailsCasts Episode 257: Request Specs and Capybara](http://railscasts.com/episodes/257-request-specs-and-capybara)

Use the "launchy" gem to `save_and_open_page` while debugging. This will save the page in a temporary file and open it in the browser.

# Assignment: Feature Spec

Example of navigating through the my queue feature on the MyFlix app

Code is below. Here is [a blog article](https://robots.thoughtbot.com/acceptance-tests-at-a-single-level-of-abstraction) about the concept of feature test as a level of abstraction.

With this my queue page
```ruby
%section.my_queue.container
  .row
    .col-sm-10.col-sm-offset-1
      %article
        %header
          %h2 My Queue
        = form_tag update_queue_path do
          %table.table
            %thead
              %tr
                %th(width="10%") List Order
                %th(width="30%") Video Title
                %th(width="10%") Play
                %th(width="20%") Rating
                %th(width="15%") Genre
                %th(width="15%") Remove
            %tbody
              - @queue_items.each do |queue_item|
                %tr
                  %td
                    = hidden_field_tag "queue_items[][id]", queue_item.id
                    = text_field_tag "queue_items[][position]", queue_item.position, data: {video_id: queue_item.video.id}, class: "form-control"
                  %td
                    = link_to queue_item.video_title, video_path(queue_item.video)
                  %td
                    = button_to "Play", nil, class: "btn btn-default"
                  %td
                    = select_tag "queue_items[][rating]", options_for_video_reviews(queue_item.rating), class: 'form-control', include_blank: true
                  %td
                    = link_to queue_item.category_name, queue_item.category
                  %td
                    = link_to queue_item_path(queue_item), method: :delete do
                      %i.glyphicon.glyphicon-remove
          = submit_tag "Update Instant Queue", class: "btn btn-default"
```

this spec:

```ruby
require 'spec_helper'

feature 'User interacts with the queue' do
  scenario 'user adds and reorders videos in the queue' do
    comedies = Fabricate(:category, name: 'comedies')
    monk = Fabricate(:video, title: 'Monk', category: comedies)
    south_park = Fabricate(:video, title: 'South Park', category: comedies)
    futurama = Fabricate(:video, title: 'Futurama', category: comedies)

    sign_in
    find("a[href='/videos/#{monk.id}']").click
    page.should have_content monk.title

    click_link '+ My Queue'
    page.should have_content monk.title

    visit video_path(monk)
    page.should_not have_content "+ My Queue"

    visit home_path
    find("a[href='/videos/#{south_park.id}']").click
    click_link '+ My Queue'
    visit home_path
    find("a[href='/videos/#{futurama.id}']").click
    click_link '+ My Queue'

    find("input[data-video-id='#{monk.id}']").set(3)
    find("input[data-video-id='#{south_park.id}']").set(1)
    find("input[data-video-id='#{futurama.id}']").set(2)
    click_button "Update Instant Queue"

    expect(find("input[data-video-id='#{south_park.id}']").value).to eq("1")
    expect(find("input[data-video-id='#{futurama.id}']").value).to eq("2")
    expect(find("input[data-video-id='#{monk.id}']").value).to eq("3")
  end
end
```

OR
```ruby
require 'spec_helper'

feature 'User interacts with the queue' do
  scenario 'user adds and reorders videos in the queue' do
    comedies = Fabricate(:category, name: 'comedies')
    monk = Fabricate(:video, title: 'Monk', category: comedies)
    south_park = Fabricate(:video, title: 'South Park', category: comedies)
    futurama = Fabricate(:video, title: 'Futurama', category: comedies)

    sign_in
    find("a[href='/videos/#{monk.id}']").click
    page.should have_content monk.title

    click_link '+ My Queue'
    page.should have_content monk.title

    visit video_path(monk)
    page.should_not have_content "+ My Queue"

    visit home_path
    find("a[href='/videos/#{south_park.id}']").click
    click_link '+ My Queue'
    visit home_path
    find("a[href='/videos/#{futurama.id}']").click
    click_link '+ My Queue'

    within(:xpath, "//tr[contains(.,'#{monk.title}')]") do
      fill_in "queue_items[][position]", with: 3
    end

    within(:xpath, "//tr[contains(.,'#{south_park.title}')]") do
      fill_in "queue_items[][position]", with: 1
    end

    within(:xpath, "//tr[contains(.,'#{futurama.title}')]") do
      fill_in "queue_items[][position]", with: 2
    end

    click_button "Update Instant Queue"

    expect(find(:xpath, "//tr[contains(., '#{south_park.title}')]//input[@type='text']").value).to eq("1")
    expect(find(:xpath, "//tr[contains(., '#{futurama.title}')]//input[@type='text']").value).to eq("2")
    expect(find(:xpath, "//tr[contains(., '#{monk.title}')]//input[@type='text']").value).to eq("3")
  end
end
```

Final version:
```ruby
require 'spec_helper'

feature 'User interacts with the queue' do
  scenario 'user adds and reorders videos in the queue' do
    comedies = Fabricate(:category, name: 'comedies')
    monk = Fabricate(:video, title: 'Monk', category: comedies)
    south_park = Fabricate(:video, title: 'South Park', category: comedies)
    futurama = Fabricate(:video, title: 'Futurama', category: comedies)

    sign_in

    add_video_to_queue(monk)
    expect_video_to_be_in_queue(monk)

    visit video_path(monk)
    expect_link_not_to_be_seen("+ My Queue")

    add_video_to_queue(south_park)
    add_video_to_queue(futurama)

    set_video_position(monk, 3)
    set_video_position(south_park, 1)
    set_video_position(futurama, 2)

    click_button "Update Instant Queue"

    expect_video_position(south_park, 1)
    expect_video_position(futurama, 2)
    expect_video_position(monk, 3)
  end

  def expect_video_to_be_in_queue(video)
    page.should have_content video.title
  end

  def expect_link_not_to_be_seen(link_text)
    page.should_not have_content link_text
  end

  def add_video_to_queue(video)
    visit home_path
    find("a[href='/videos/#{video.id}']").click
    click_link '+ My Queue'
  end

  def set_video_position(video, position)
    within(:xpath, "//tr[contains(.,'#{video.title}')]") do
      fill_in "queue_items[][position]", with: position
    end
  end

  def expect_video_position(video, position)
    expect(find(:xpath, "//tr[contains(., '#{video.title}')]//input[@type='text']").value).to eq(position.to_s)
  end
end
```
