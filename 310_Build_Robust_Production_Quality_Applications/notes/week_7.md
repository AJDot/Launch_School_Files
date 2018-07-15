# Week 7

## Lesson: Wrapping APIs

Building a local wrapper for web APIs.

Example with Stripe:

Pro:
* We may have many places to interface with Stripe throughout our application. We can create a wrapper that will be placed in all these locations then the actual communication with Stripe will occur in just one place in our code.
* We can also customize it with our API keys
* We can better define methods to interact with Stripe.

**REMEMBER: The following code is using the outdated Stripe API. Modify it for current projects to mesh with the newer version.**
Create a model for the Stripe wrapper:
This is a plain ruby object.
```ruby
# app/models/stripe_wrapper

module StripeWrapper
  class Charge
    def self.create(options={})
      Stripe::Charge.create(amount: options[:amount], currency: "usd", card: options[:card])
    end
  end
end
```

Then in the `Payments#create` action we can change this:
```ruby
# app/controllers/payments_controller.rb

class PaymentsController < ApplicationController
  def create
    Stripe.api_key = "sk_test_fiAG8z1KPD3ixkm7nEMDheTD"

    token = params[:stripeToken]

    begin
      # Charge the user's card:
      charge = Stripe::Charge.create(
        :amount => 999,
        :currency => "usd",
        :card => token,
      )
      redirect_to new_payment_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    end
  end
end
```
to this:
```ruby
# app/controllers/payments_controller.rb

class PaymentsController < ApplicationController
  def create
    Stripe.api_key = "sk_test_fiAG8z1KPD3ixkm7nEMDheTD"

    token = params[:stripeToken]

    begin
      # Charge the user's card:
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => token,
      )
      redirect_to new_payment_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    end
  end
end
```

---

We also want to move the API key to the wrapper. It will be placed outside of charge because we may have others that need it.

```ruby
# app/models/stripe_wrapper

module StripeWrapper
  class Charge
    def self.create(options={})
      StripeWrapper.set_api_key
      Stripe::Charge.create(amount: options[:amount], currency: "usd", card: options[:card])
    end
  end

  def self.set_api_key
    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_LIVE_API_KEY'] : "sk_test_fiAG8z1KPD3ixkm7nEMDheTD"
  end
end
```

Then the payment controller becomes this with the api key removed:
```ruby
# app/controllers/payments_controller.rb

class PaymentsController < ApplicationController
  def create
    token = params[:stripeToken]

    begin
      # Charge the user's card:
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => token,
      )
      redirect_to new_payment_path
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_payment_path
    end
  end
end
```

---

Now we are done with the first half of the API - handling the request. Now we need to handle the response. We want something like looks like this.
```ruby
# app/controllers/payments_controller.rb

class PaymentsController < ApplicationController
  def create
    token = params[:stripeToken]

    charge = StripeWrapper::Charge.create(
      :amount => 999,
      :card => token,
    )

    if charge.successful?
      flash[:success] = "Thank you for your generous support!"
      redirect_to new_payment_path
    else
      flash[:error] = charge.error_message
      redirect_to new_payment_path
    end
  end
end
```

```ruby
# app/models/stripe_wrapper

module StripeWrapper
  class Charge
    attr_reader :response, :status

    def initialize(response, status)
      @response = response
      @status = status
    end

    def self.create(options={})
      StripeWrapper.set_api_key
      begin
        response = Stripe::Charge.create(amount: options[:amount], currency: "usd", card: options[:card])
        new(response, :success)
      rescue Stripe::CardError => e
        new(e, :error)
      end
    end

    def successful?
      status == :success
    end

    def error_message
      response.message
    end
  end

  def self.set_api_key
    Stripe.api_key = Rails.env.production? ? ENV['STRIPE_LIVE_API_KEY'] : "sk_test_fiAG8z1KPD3ixkm7nEMDheTD"
  end
end
```

So now we have a new instance of the StripeWrapper regardless of if the charge was successful though the status of the instance object will be different. The response data with either be the response from Stripe or the error from Stripe.

## Lesson: Fully Integrated API Tests

We didn't do TDD before. Should do that.

Typically two approaches to writing 3rd party API wrapper tests.
1. You only need to go to where your application boundary is but you actually make the request and receive response from 3rd party.
2. You call the 3rd party API but fake the response data coming back from the API.

In this test we will fully integrate with Stripe (method 1)

```ruby
# spec/models/stripe_wrapper_spec.rb

require 'spec_helper'

describe StripeWrapper::Charge do
  # need the API key
  before do
    StripeWrapper.set_api_key
  end

  let(:token) do
    token = Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: 3,
        exp_year: 2021,
        cvc: 123
      }
    ).id
  end

  context "with valid card" do
    let(:card_number) { '4242424242424242' }

    it "charges the card successfully" do
      response = StripeWrapper::Charge.create(amount: 300, card: token)
      response.should be_successful
    end
  end

  context "with invalid card" do
    let(:card_number) { '4000000000000002' }
    let(:response) { StripeWrapper::Charge.create(amount: 300, card: token) }

    it "does not charge the card successfully" do
      response.should_not be_successful
    end

    it "contains an error message" do
      response.error_message.should == 'Your card was declined'
    end
  end
end
```

## Lesson: Isolated API tests
The tests written above take a long time to do. Each tests hits Stripe twice for a total of around 15s for just these 3 tests.

So we can't afford to do this when our application grows.
[Webmock](https://github.com/bblimke/webmock) is a library for stubbing and setting expectiation on HTTP requsts. We can specify a request (post, etc) and say what response will come back from the request. However, webmock operates on a low level and we would have to do all of this setup manually and it doesn't integrate to great with rspec.

[Vcr](https://github.com/vcr/vcr) is the solution for this. This will record HTTP interactions and replay them during future test runs for fast, deterministic, accurate tests. So the server only needs to be hit once for each type of request.

To use it:
Include vcr (and webmock since vcr uses it) in the gemfile under the test group:
```ruby
# Gemfile

group :test do
  gem 'vcr'
  gem 'webmock'
end
```

The author/maintainer of Vcr is the same one as for rspec so the integrate with rspec is very simple.

Use [rspec metadata](https://relishapp.com/vcr/vcr/v/3-0-3/docs/test-frameworks/usage-with-rspec-metadata) to set it up.

```ruby
# spec/spec_helper.rb

require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  # so we can use :vcr rather than :vcr => true;
  # in RSpec 3 this will no longer be necessary.
  c.treat_symbols_as_metadata_keys_with_true_values = true
end
```

Now we need to use a symbol on each spec (:vcr).

```ruby
# spec/models/stripe_wrapper_spec.rb

require 'spec_helper'

describe StripeWrapper::Charge do
  # need the API key
  before do
    StripeWrapper.set_api_key
  end

  let(:token) do
    token = Stripe::Token.create(
      card: {
        number: card_number,
        exp_month: 3,
        exp_year: 2021,
        cvc: 123
      }
    ).id
  end

  context "with valid card", :vcr do
    let(:card_number) { '4242424242424242' }

    it "charges the card successfully" do
      response = StripeWrapper::Charge.create(amount: 300, card: token)
      response.should be_successful
    end
  end

  context "with invalid card", :vcr do
    let(:card_number) { '4000000000000002' }
    let(:response) { StripeWrapper::Charge.create(amount: 300, card: token) }

    it "does not charge the card successfully" do
      response.should_not be_successful
    end

    it "contains an error message" do
      response.error_message.should == 'Your card was declined'
    end
  end
end
```

Run the tests once and it should still take a while to do. This is the first recording of the requests. Run it again and the tests should run much faster because the recordings are used.

VCR has now created a directory for the requests. `spec/cassettes/StripeWrapper_Charge/with_valid_card` and `spec/cassettes/StripeWrapper_Charge/with_invalid_card`. This is where the recordings are stored.

VCR has a lot of customization options and record modes. By default the record mode is set to once - it will record once and always use that one. The other option is `:all` which means it will never use the replay and always run the whole spec. You should flip the option from :once to :all every now and then to make sure the web APIs you are integrating with haven't changed. using the recordings also means you don't need an Internet connection to run the tests.

## Lesson: [Test doubles](https://relishapp.com/rspec/rspec-mocks/v/3-7/docs/basics/test-doubles) and [method stubs](https://relishapp.com/rspec/rspec-mocks/v/3-7/docs/old-syntax/stub)
**NOTE: the `stub` method is the old way to [allow messages](https://relishapp.com/rspec/rspec-mocks/v/3-7/docs/basics/allowing-messages).**

We wrote tests for the `StripeWrapper` but we haven't written tests for the payments controller.

Stub methods are used when:
1. The operations are computationally expense or take a long time.
2. The interface of what we are stubbing has been tested extensively already so we don't need to test it in other settings.

Because the `StripeWrapper` method has been thoroughly tested elsewhere we don't really want to call the `create` method on the Stripe API. We will instead stub this method.

To do this we create a double that will stand for the `StripeWrapper::Charge` object - the actual return value from the wrapper.
Then stub the charge test double so that it will always return true from the `successful?` method.
Then stub the `StripeWrapper::Charge.create` method so that it will always return the double.
Since we are stubbing these methods, we are faking the requests and response, making sure that the stub returns what we would expect from the actual API request. We are simulating the actual API call.

```ruby
# spec/controllers/payments_controller_spec.rb

require 'spec_helper'

describe PaymentsController do
  describe "POST create" do
    context "with a successful charge" do
      before do
        charge = double('charge')
        charge.stub(:successful?).and_return(true)
        StripeWrapper::Charge.stub(:create).and_return(charge)

        post :create, token: '123'
      end

      it "sets the flash success message" do
        flash[:success].should == 'Thank you for your generous support!'
      end

      it "redirects to the new payment path" do
        response.should redirect_to new_payment_path
      end
    end

    context "with an error charge" do
        charge = double('charge')
        charge.stub(:successful?).and_return(false)
        charge.stub(:error_message).and_return('Your card was declined')
        StripeWrapper::Charge.stub(:create).and_return(charge)

        post :create, token: '123'

      it "sets the flash error message" do
        flash[:error].should == 'Your card was declined'
      end

      it "redirects to the new payment path" do
        response.should redirect_to new_payment_path
      end
    end
  end
end
```

## Assignment: Charge Credit Card on Registration

**Note: Capybara changed its implementation since we made this video such that if now runs on a different port if you use Selenium.**

I had to do a bunch to make it all work. Here are some resources I used:
* https://github.com/stripe/elements-examples/blob/master/js/index.js
* https://gist.github.com/iloveitaly/19ff89614b8e92a71de660c89b8a0fbf
* https://github.com/teamcapybara/capybara#using-capybara-with-rspec
* https://github.com/SeleniumHQ/selenium/wiki/ChromeDriver
* https://sites.google.com/a/chromium.org/chromedriver/getting-started
* https://makandracards.com/makandra/29465-install-chromedriver-on-linux
* http://www.virtuouscode.com/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/

To make it work, in `spec_helper.rb`, add

```ruby
Capybara.server_port = 52662
```

In `config/environments/test.rb`, change

```ruby
config.action_mailer.default_url_options = { host: 'localhost:3000' }
```
to

```ruby
config.action_mailer.default_url_options = { host: 'localhost:52662' }
```

Had to update the tests, several were failing because `vcr` didn't know what to do with `StripeWrapper` in the user tests.

Here are the updated user controller tests. The difference is in stubbing the `StriperWrapper`:
```ruby
require 'spec_helper'

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      expect(assigns(:user)).to be_instance_of(User)
      expect(assigns(:user)).to be_new_record
    end
  end

  describe "POST create" do
    context "with valid input" do
      before do
        StripeWrapper::Charge.stub(:create)
        post :create, user: Fabricate.attributes_for(:user)
      end

      it "creates the user" do
        expect(User.count).to eq(1)
      end

      it "redirects to the sign in page" do
        expect(response).to redirect_to sign_in_path
      end

      it "makes the user follow the inviter" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'John Doe' }, invitation_token: invitation.token
        joe = User.find_by email: 'joe@example.com'
        expect(joe.follows?(alice)).to be true
      end

      it "makes the inviter follow the user" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'John Doe' }, invitation_token: invitation.token
        joe = User.find_by email: 'joe@example.com'
        expect(alice.follows?(joe)).to be true
      end

      it "expires the invitation upon acceptance" do
        alice = Fabricate(:user)
        invitation = Fabricate(:invitation, inviter: alice, recipient_email: 'joe@example.com')
        post :create, user: { email: 'joe@example.com', password: 'password', full_name: 'John Doe' }, invitation_token: invitation.token
        expect(Invitation.first.token).to be_nil
      end
    end

    context "with invalid input" do
      before do
        post :create, user: {password: 'password', full_name: Faker::Name.name}
      end

      it "does not create the user" do
        expect(User.count).to eq(0)
      end

      it "renders the :new template" do
        expect(response).to render_template :new
      end

      it "sets @user" do
        expect(assigns(:user)).to be_instance_of(User)
      end
    end

    context "sending emails" do
      before do
        StripeWrapper::Charge.stub(:create)
      end

      after do
        ActionMailer::Base.deliveries.clear
      end

      it "sends out email to the user with valid inputs" do
        post :create, user: { email: "joe@example.com", password: "password", full_name: "Joe Smith" }
        expect(ActionMailer::Base.deliveries.last.to).to eq(['joe@example.com'])
      end

      it "sends out email containing the user's name with valid inputs" do
        post :create, user: { email: "joe@example.com", password: "password", full_name: "Joe Smith" }
        expect(ActionMailer::Base.deliveries.last.body).to include("Joe Smith")
      end

      it "does not send out email with invalid inputs" do
        post :create, user: { email: "joe@example.com" }
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end

  describe 'GET show' do
    it_behaves_like 'requires sign in' do
      let(:action) { get :show, id: 3 }
    end

    it 'sets @user' do
      set_current_user
      alice = Fabricate(:user)
      get :show, id: alice.id
      expect(assigns(:user)).to eq(alice)
    end
  end

  describe 'GET new_with_invitation_token' do
    it "renders the :new view template" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(response).to render_template :new
    end

    it "sets @user with recipient's email" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:user).email).to eq(invitation.recipient_email)
    end

    it "sets @invitation_token" do
      invitation = Fabricate(:invitation)
      get :new_with_invitation_token, token: invitation.token
      expect(assigns(:invitation_token)).to eq(invitation.token)
    end

    it "redirects to expired token page for invalid tokens" do
      get :new_with_invitation_token, token: 'asdfasdf'
      expect(response).to redirect_to expired_token_path
    end
  end
end
```

I also update the registration form to have separate fields for each credit card entry (they were in one input box). This is of course still constructed using Stripe Elements so it's still awkward to work with.

```haml
= content_for :head do
  %script(src="https://js.stripe.com/v3/");
  :javascript
    var stripe = Stripe("#{ENV['STRIPE_PUBLISHABLE_KEY']}");
  = javascript_include_tag 'payments'

%section.register.container
  .row
    .col-sm-10.col-sm-offset-1
      = bootstrap_form_for @user, html: { id: 'payment-form', class: 'form-horizontal' } do |f|
        %header
          %h1 Register
        %fieldset
          = f.email_field :email, label: "Email Address"
          = f.password_field :password
          = f.text_field :full_name, label: "Full Name"
          = hidden_field_tag :invitation_token, @invitation_token
        %fieldset.credit_card
          %span#card-errors.alert-danger
          .form-group
            %label.col-sm-3(for="card-number") Credit Card Number
            .col-sm-6
              #card-number.form-control
          .form-group
            %label.col-sm-3(for="card-expiry") Expiration Date
            .col-sm-6
              #card-expiry.form-control
          .form-group
            %label.col-sm-3(for="card-cvc") Security Code
            .col-sm-6
              #card-cvc.form-control
        %fieldset.actions.control-group.col-sm-offset-2
          .controls
            = submit_tag "Sign Up", class: "btn payment_submit"
```

```js
$(function() {
  var elements = stripe.elements();

  // Create an instance of the card Element
  var cardNumber = elements.create('cardNumber');
  var cardExpiry = elements.create('cardExpiry');
  var cardCvc = elements.create('cardCvc');

  // Add an instance of the card Element into the `card-element` <div>
  cardNumber.mount('#card-number');
  cardExpiry.mount('#card-expiry');
  cardCvc.mount('#card-cvc');

  // Listen for errors
  [cardNumber, cardExpiry, cardCvc].forEach(function(element, idx) {
    element.addEventListener('change', function(event) {
      var displayError = document.getElementById('card-errors');
      if (event.error) {
        displayError.textContent = event.error.message;
      } else {
        displayError.textContent = '';
      }
    });
  });

  // Look at the form element with the id and intercepts the submit event
  $('#payment-form').submit(function(event) {
    event.preventDefault();
    var $form = $(this);
    // disables the submit button so it can't be submitted again
    $form.find('.payment_submit').prop('disabled', true);
    // Comes from Stripe.js to create the token using the values
    // from the form
    // This is communicating with stripe to get a token back.
    // This is an async call.
    var cardData = {
      name: $('#user_email').val(),
    };

    stripe.createToken(cardNumber, cardData).then(stripeResponseHandler);

    return false;
  });

  var stripeResponseHandler = function(response) {
    var $form = $('#payment-form');

    // if credit card data has errors, then show them in the .card-errors element and let the form be submitted again
    if (response.error) {
      $form.find('.card-errors').text(response.error.messages);
      $form.find('.payment_submit').prop('disabled', false);
    } else {
      stripeTokenHandler(response.token);
    }
    return false;
  }

  var stripeTokenHandler = function(token) {
    var $form = $('#payment-form');
    // if no errors, take the response.id as the token and insert
    // a hidden field into the form that will then be submitted.
    var $hiddenStripeToken = $('<input>');
    $hiddenStripeToken.attr('type', 'hidden');
    $hiddenStripeToken.attr('name', 'stripeToken');
    $hiddenStripeToken.attr('value', token.id);
    $form.append($hiddenStripeToken);

    // var $hiddenStripeEmail = $('<input>');
    // $hiddenStripeEmail.attr('type', 'hidden');
    // $hiddenStripeEmail.attr('name', 'stripeEmail');
    // $hiddenStripeEmail.attr('value', $('#user_email').val());
    // $form.append($hiddenStripeEmail);
    //
    $form.get(0).submit();
  }
});
```

In the `spec_helper.rb` we need to use Selenium and the chrome driver, have `vcr` ignore requests to localhost, and use `database_cleaner` gem that will clean up the database when running js enabled tests.
```ruby
# spec_helper.rb

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/email/rspec'
require 'sidekiq/testing/inline'
require 'webmock/rspec'

Capybara.server_port = 52662
Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end
Capybara.javascript_driver = :chrome
# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_localhost = true
end

RSpec.configure do |config|
  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explictly tag your specs with their type, e.g.:
  #
  #     describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/v/3-0/docs
  config.infer_spec_type_from_file_location!

  # so we can use :vcr rather than :vcr => true;
  # in RSpec 3 this will no longer be necessary.
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
```

And while I'm at it, here is the current Gemfile:
```ruby
source 'https://rubygems.org'
ruby '2.1.2'

gem 'bootstrap-sass', '3.1.1.1'
gem 'bootstrap_form'
gem 'bcrypt'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'sidekiq', '4.0.0'
gem 'unicorn'
gem 'sentry-raven'
gem 'carrierwave'
gem 'mini_magick'
gem 'carrierwave-aws'
gem 'stripe'
gem 'figaro'

group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem 'letter_opener'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
  gem 'fabrication'
  gem 'faker'
end

group :test do
  gem 'database_cleaner', '1.4.1'
  gem 'shoulda-matchers', '2.7.0'
  gem 'vcr'
  gem 'capybara'
  gem 'capybara-email'
  gem 'launchy'
  gem 'webmock'
  gem 'selenium-webdriver'
end

group :production, :staging do
  gem 'rails_12factor'
end
```

## Lesson: Feature tests with JavaScript

Test for making credit card payment.

```ruby
# spec/features/visitor_makes_payment_spec.rb

require 'spec_helper'

feature 'Visitor makes payment' do
  scenario 'valid card number' do
    visit new_payment_path
    fill_in "Credit Card Number", with: '4242424242424242'
    fill_in "Security Code", with: "123"
    select "3 - March", from: 'date_month'
    select "2019", from: 'date_year'
    click_button "Submit Payment"
    expect(page).to have_content "Thank you for your generous support!"
  end

    scenario 'invalid card number'
    scenario 'declined card'
  end
end
```

At this point you may think the test will pass but it won't. The Stripe token will not make it back from the Stripe server. The reason is we need JavaScript to be turned on for Stripe.js to work.

So we should turn on JavaScript using `js: true`. This is make the javascript driver `:selenium` which will open up a browser to do the testing.

```ruby
# spec/features/visitor_makes_payment_spec.rb

require 'spec_helper'

feature 'Visitor makes payment', js: true do
  background do
    visit new_payment_path
  end

  scenario 'valid card number' do
    pay_with_credit_card("4242424242424242")
    expect(page).to have_content "Thank you for your generous support!"
  end

  scenario 'invalid card number' do
    pay_with_credit_card("4000000000000069")
    expect(page).to have_content "Your card's expiration date is incorrect"
  end

  scenario 'declined card' do
    pay_with_credit_card("4000000000000002")
    expect(page).to have_content "Your card was declined"
  end
end

def pay_with_credit_card(card_number)
  fill_in "Credit Card Number", with: card_number
  fill_in "Security Code", with: "123"
  select "3 - March", from: 'date_month'
  select "2019", from: 'date_year'
  click_button "Submit Payment"
end
```

We are using Selenium as the test driver. Sometimes this browser might not work correctly and usually that's because the version of selenium, capybara, or the browser might not match. Usually upgrading them all to the latest version should solve this problem.

Selenium is actually the slowest of all the js runners but is good for debugging since it is very visual.

However we can use another js runner called [capybara-webkit](https://github.com/thoughtbot/capybara-webkit). It depends on a package called [Qt](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit).

Once installed, bundle install the capybara-webkit gem. Then put this in `spec_helper.rb`:

```ruby
Capybara.javascript_driver = :webkit
```

This should be the default javascript runner but we may want to run on selenium sometimes to visually see what is happening. To do this add the driver in the test:
```ruby
# spec/features/visitor_makes_payment_spec.rb

require 'spec_helper'

feature 'Visitor makes payment', js: true do
  background do
    visit new_payment_path
  end

  scenario 'valid card number' do
    pay_with_credit_card("4242424242424242")
    expect(page).to have_content "Thank you for your generous support!"
  end

  scenario 'invalid card number', driver: :selenium do
    pay_with_credit_card("4000000000000069")
    expect(page).to have_content "Your card's expiration date is incorrect"
  end

  scenario 'declined card' do
    pay_with_credit_card("4000000000000002")
    expect(page).to have_content "Your card was declined"
  end
end

def pay_with_credit_card(card_number)
  fill_in "Credit Card Number", with: card_number
  fill_in "Security Code", with: "123"
  select "3 - March", from: 'date_month'
  select "2019", from: 'date_year'
  click_button "Submit Payment"
end
```

Now selenium will be used instead of webkit for that one spec.

Poltergeist is another headless js driver you can use.

## Lesson: Transactions and test database setup

If you look at the instructions for capybara here: https://github.com/jnicklas/capybara

In the "Transactions and database setup" section, it talks about the Selenium driver needs to run against a real HTTP server and that capybara will start one for you but it runs on a different thread. In this case using "transactions" as the strategy to reset the database after each spec can be a problem, and this is where you want to use the "database_cleaner" gem so that you can use the "truncation" strategy, which effectively just goes to your database and delete all the records. It's a bit slower than transaction rollbacks, but in this case guarantees data will be reset.

You can add the "database_cleaner" gem in your test group (for the setup below, make sure to use version 2.7.0), and use the following configuration in your `spec_helper` file inside of the `RSpec.configure do |config| ... end` block.

```ruby
config.before(:suite) do
  DatabaseCleaner.clean_with(:truncation)
end

config.before(:each) do
  DatabaseCleaner.strategy = :truncation
end

config.before(:each, :js => true) do
  DatabaseCleaner.strategy = :truncation
end

config.before(:each) do
  DatabaseCleaner.start
end

config.after(:each) do
  DatabaseCleaner.clean
end
```

## Assignment: Feature test for registration with credit card

**Note:** If you are using Nitrous.io as your development environment, you need to install phantomsjs package on your system, following this guide [here](http://help.nitrous.io/autoparts/). Then you can use the Poltergeist driver for capybara.

**Note:** You may need to add some sleeping time so that selenium can wait for the request to Stripe to come back. Please see [this discussion thread](https://launchschool.com/posts/57eb976a). You could also [adjust the default max wait time in Capybara](https://github.com/jnicklas/capybara#asynchronous-javascript-ajax-and-friends).

## Fixing Failing Tests when using CircleCI for Continuous Integration

**Background:**
I was using Ruby 2.1.2, Rails 4.1.1, and CircleCI API v1 at the time. At this point all tests were passing on my local machine but when run through CircleCI they would fail. Here is an output of the failing tests that CircleCI ran:
```
bundle exec rspec --color spec --format progress
I, [2018-02-23T20:45:07.332452 #20460]  INFO -- sentry: ** [Raven] Raven 2.7.2 configured not to capture errors: Not configured to send/capture in environment 'test'
.........................................................................................................F.....F.F.FF...................................................................

Failures:

  1) user invites friend User successfully invites friend and invitation is accepted
     Failure/Error: expect(page).to have_content("Sign in")
       expected to find text "Sign in" in "MyFLiX Register Email Address Password Full Name Credit Card Number Expiration Date Security Code © 2013 MyFLiX"
     # ./spec/features/user_invites_friend_spec.rb:37:in `friend_accepts_invitation'
     # ./spec/features/user_invites_friend_spec.rb:9:in `block (2 levels) in <top (required)>'

  2) User registers with invalid user info and valid card
     Failure/Error: expect(page).to have_content "Invalid user information. Please check the errors below."
       expected to find text "Invalid user information. Please check the errors below." in "MyFLiX Register Email Address Password Full Name Credit Card Number Expiration Date Security Code © 2013 MyFLiX"
     # ./spec/features/user_registers_spec.rb:36:in `block (2 levels) in <top (required)>'

  3) User registers with valid user info and declined card
     Failure/Error: expect(page).to have_content "Your card was declined."
       expected to find text "Your card was declined." in "MyFLiX Register Email Address Password Full Name Credit Card Number Expiration Date Security Code © 2013 MyFLiX"
     # ./spec/features/user_registers_spec.rb:29:in `block (2 levels) in <top (required)>'

  4) User registers with valid user info and valid card
     Failure/Error: expect(page).to have_content "Thank you for registering with MyFlix. Please sign in now."
       expected to find text "Thank you for registering with MyFlix. Please sign in now." in "MyFLiX Register Email Address Password Full Name Credit Card Number Expiration Date Security Code © 2013 MyFLiX"
     # ./spec/features/user_registers_spec.rb:14:in `block (2 levels) in <top (required)>'

  5) User registers with invalid user info and declined card
     Failure/Error: expect(page).to have_content "Invalid user information. Please check the errors below."
       expected to find text "Invalid user information. Please check the errors below." in "MyFLiX Register Email Address Password Full Name Credit Card Number Expiration Date Security Code © 2013 MyFLiX"
     # ./spec/features/user_registers_spec.rb:51:in `block (2 levels) in <top (required)>'

Finished in 53.39 seconds
184 examples, 5 failures

Failed examples:

rspec ./spec/features/user_invites_friend_spec.rb:4 # user invites friend User successfully invites friend and invitation is accepted
rspec ./spec/features/user_registers_spec.rb:32 # User registers with invalid user info and valid card
rspec ./spec/features/user_registers_spec.rb:24 # User registers with valid user info and declined card
rspec ./spec/features/user_registers_spec.rb:8 # User registers with valid user info and valid card
rspec ./spec/features/user_registers_spec.rb:46 # User registers with invalid user info and declined card

Randomized with seed 2321


((bundle exec rspec "--color" "" "spec" --format "progress")) returned exit code 1
```

These tests passed locally so I thought it might just be a timing issue. Sometimes 5 tests fails, sometimes only 3, but they are all from `user_registers_spec.rb`. So I thought it was a timing issue since there are AJAX requests. I increased the Capybara max wait time using `Capybara.default_max_wait_time = 5` in the `spec_helper.rb` but that didn't fix it.

I thought: Is 5 not long enough of a wait? Any help or guidance would be appreciated. Also, I have looked at https://github.com/jnicklas/capybara#asynchronous-javascript-ajax-and-friends and https://launchschool.com/posts/57eb976a as suggested from one of the assignments.

I posted this on the LS discussion board and Brandon Conway gave me a bit of help. Circle API 1.0 doesn't play nice anymore as they have upgraded to 2.0. He suggested to do the following:

---

It seems students have been having trouble with Circle, and Circle doesn't work as well with version 1.0 of the config anymore. I worked out the conversion for myflix to use Circle 2.0 configs. Your tests pass for me after doing that (except one related to sending an email when it shouldn't that fails sometimes).

Here are the steps you have to follow:

1. Upgrade to Ruby 2.2.9 (in your Gemfile and .ruby-version files)
1. Add `rspec_junit_formatter` to your Gemfile
1. `bundle update json eventmachine`
1. `bundle install` (this should report that everything was already installed
1. Add the following file to your project as `config/database.ci.yml` (make sure you include the `.ci.yml`)

```
test:
  database: myflix_test
  adapter: postgresql
  encoding: unicode
  pool: 5
  timeout: 5000
```

6. Add the following file to your project as `.circleci/config.yml`:

```
version: 2
jobs:
  test-job:
    docker:
      - image: circleci/ruby:2.2.9-node-browsers
        environment:
          - RAILS_ENV: test
          - PGHOST: 127.0.0.1
          - PGUSER: root
          - PGPASSWORD: ""

      - image: circleci/postgres:9.6
        environment:
        - POSTGRES_USER: root
        - POSTGRES_DB: myflix_test
        - POSTGRES_PASSWORD: ""

    working_directory: ~/myflix

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
          - v1-dependencies-{{ checksum "Gemfile.lock" }}
          # fallback to using the latest cache if no exact match is found
          - v1-dependencies-

      - run:
          name: install dependencies
          command: |
            bundle install --jobs=4 --retry=3 --path vendor/bundle

      - save_cache:
          paths:
            - ./vendor/bundle
          key: v1-dependencies-{{ checksum "Gemfile.lock" }}

      # Database setup
      - run: mv config/database.ci.yml config/database.yml
      - run: bundle exec rake db:create
      - run: bundle exec rake db:schema:load

      # run tests!
      - run:
          name: run tests
          command: |
            mkdir /tmp/test-results
            TEST_FILES="$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split --split-by=timings)"

            bundle exec rspec --format progress \
                            --format RspecJunitFormatter \
                            --out /tmp/test-results/rspec.xml \
                            --format progress \
                            $TEST_FILES

      # collect reports
      - store_test_results:
          path: /tmp/test-results
      - store_artifacts:
          path: /tmp/test-results
          destination: test-results

  production-deploy:
    machine: true
    steps:
      - git fetch --unshallow
      - ...

  staging-deploy:
    machine: true
    steps:
      - git fetch --unshallow
      - ...

workflows:
  version: 2
  test-deploy:
    jobs:
      - test-job
      - production-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: master
      - staging-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: staging
```

7. Update the file you just added to add your deployment commands in the production-job and staging-job jobs. You can see where I already have the first command in each. I want you to do this so you understand a bit of what is happening. Also, read the `workflows` section and let me know if you have any questions about how it works. You can also consult the circleci docs.

8. Commit your changes and push.

Your tests *should pass* after you do these things. If you have any trouble please let me know. I will probably move these instructions to week 5 after you have verified that I wrote them up properly 😃

---

I followed the steps, and by filling in my own heroku commands, I ended up with the following `.circleci/config.yml` file:
```
version: 2
jobs:
  test-job:
    docker:
      - image: circleci/ruby:2.2.9-node-browsers
        environment:
          - RAILS_ENV: test
          - PGHOST: 127.0.0.1
          - PGUSER: root
          - PGPASSWORD: ""

      - image: circleci/postgres:9.6
        environment:
        - POSTGRES_USER: root
        - POSTGRES_DB: myflix_test
        - POSTGRES_PASSWORD: ""

    working_directory: ~/myflix

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
          - v1-dependencies-{{ checksum "Gemfile.lock" }}
          # fallback to using the latest cache if no exact match is found
          - v1-dependencies-

      - run:
          name: install dependencies
          command: |
            bundle install --jobs=4 --retry=3 --path vendor/bundle

      - save_cache:
          paths:
            - ./vendor/bundle
          key: v1-dependencies-{{ checksum "Gemfile.lock" }}

      # Database setup
      - run: mv config/database.ci.yml config/database.yml
      - run: bundle exec rake db:create
      - run: bundle exec rake db:schema:load

      # run tests!
      - run:
          name: run tests
          command: |
            mkdir /tmp/test-results
            TEST_FILES="$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split --split-by=timings)"

            bundle exec rspec --format progress \
                            --format RspecJunitFormatter \
                            --out /tmp/test-results/rspec.xml \
                            --format progress \
                            $TEST_FILES

      # collect reports
      - store_test_results:
          path: /tmp/test-results
      - store_artifacts:
          path: /tmp/test-results
          destination: test-results

  production-deploy:
    machine: true
    steps:
      - git fetch
      - heroku maintenance:on --app ah-myflix
      - heroku pg:backups capture --app ah-myflix
      - git push git@heroku.com:ah-myflix.git $CIRCLE_SHA1:refs/heads/master
      - heroku run rake db:migrate --app ah-myflix
      - heroku maintenance:off --app ah-myflix

  staging-deploy:
    machine: true
    steps:
      - git fetch
      - heroku maintenance:on --app ah-myflix-staging
      - git push git@heroku.com:ah-myflix-staging.git $CIRCLE_SHA1:refs/heads/master
      - heroku run rake db:migrate --app ah-myflix-staging
      - heroku maintenance:off --app ah-myflix-staging

workflows:
  version: 2
  test-deploy:
    jobs:
      - test-job
      - production-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: master
      - staging-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: staging
```

I committed these changes and pushed the code to the staging branch. Circle CI is supposed to run the `test-job` job and then the `staging-deploy` job. The `test-job` job ran successfully and all tests passed but the `staging-deploy` job didn't run. I got this error.

```
Build-agent version 0.0.4666-05dad47 (2018-01-25T18:14:33+0000)
Configuration errors: 1 error occurred:

* In step 1 definition: No step of type "git fetch __unshallow" is defined
```

I changed  `- git fetch --unshallow` to `- git fetch`.

---

Then I read that Heroku deployment isn't that easy to do on Circle 2.0 now but can still be done manually. I followed this doc, https://circleci.com/docs/2.0/deployment-integrations/#heroku, to get to the final solution. The following is taken mostly from the doc, with some added notes:

1. Create a script to set up Heroku similar to this example `setup-heroku.sh` file in the `.circleci` folder:
```bash
#!/bin/bash
wget https://cli-assets.heroku.com/branches/stable/heroku-linux-amd64.tar.gz
sudo mkdir -p /usr/local/lib /usr/local/bin
sudo tar -xvzf heroku-linux-amd64.tar.gz -C /usr/local/lib
sudo ln -s /usr/local/lib/heroku/bin/heroku /usr/local/bin/heroku

cat > ~/.netrc << EOF
machine api.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
EOF

cat >> ~/.ssh/config << EOF
VerifyHostKeyDNS yes
StrictHostKeyChecking no
EOF
```

This file sets up the heroku CLI and other requirements so it can be used to push code to heroku. More information about this is in the doc. Obtain your `HEROKU_API_KEY` from https://dashboard.heroku.com/account. The `HEROKU_LOGIN` is your login information, most likely your email on the account. Add these environment variables to CircleCI on the Project > Settings > Environment Variables page.

2. Now you need a new SSH key to connect to the Heroku Git server. In the terminal, run:

``` bash
ssh-keygen -t rsa
```

It will ask you to enter the file to save the key, you can leave this blank to save it in the default location it lists. Then it'll ask you for a passphrase, leave this blank - just hit enter. Confirm the passphrase by hitting enter again. The files are made for the private and public keys.

The private key will look something like:
```
-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEA25Gsob9zlrSspe/hknSN2v61+pCQHmpnrGWQpPiNDpH/uEpG
n2jLRbxqbaV7MNlnkrs2p5NUvgLS7tDNqy8gnx7CqwDn30HRuydzUdf45l2yg+ZS
njdPurcXe2w+1tOkpe7cIW/a1BdUsKGhQvTgo9f0hUwa3y8SWsjLNujaRs7D4GP3
H+FMP6lONh7dGp9GdlnOHp9k0JhLgvfvlID/z4Uk9n14gctlFN/C49s+XuDuMogt
wRtR9LRRUq3P3UgnqT/S3HeeMh9LnGbbq3BpYJ0UbrLb82vrmKY51cV1Vl7MPeEa
... several more lines
-----END RSA PRIVATE KEY-----
```

The private key will look something like this:
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDbkayhv3OWtKyl7.............several more characters <OWNER>
```

3. Take the entire contents of the private key (including the BEGIN and END parts), and enter it into Circle on this page: https://circleci.com/gh/USERNAME/APPNAME/edit#ssh - The "SSH Permissions" page.
Use `git.heroku.com` as the Hostname and your private key as the private key.

4. Add the public key to heroku on the https://dashboard.heroku.com/account screen. Again, paste the entire contents of the file in the input box. You can change the OWNER part to USERNAME@circleci.com.

5. Modify the `config.yml` file to the following:

```yml
version: 2
jobs:
  test-job:
    docker:
      - image: circleci/ruby:2.2.9-node-browsers
        environment:
          - RAILS_ENV: test
          - PGHOST: 127.0.0.1
          - PGUSER: root
          - PGPASSWORD: ""

      - image: circleci/postgres:9.6
        environment:
          - POSTGRES_USER: root
          - POSTGRES_DB: myflix_test
          - POSTGRES_PASSWORD: ""

    working_directory: ~/myflix

    steps:
      - checkout

      # Download and cache dependencies
      - restore_cache:
          keys:
          - v1-dependencies-{{ checksum "Gemfile.lock" }}
          # fallback to using the latest cache if no exact match is found
          - v1-dependencies-

      - run:
          name: install dependencies
          command: |
            bundle install --jobs=4 --retry=3 --path vendor/bundle

      - save_cache:
          paths:
            - ./vendor/bundle
          key: v1-dependencies-{{ checksum "Gemfile.lock" }}

      # Database setup
      - run: mv config/database.ci.yml config/database.yml
      - run: bundle exec rake db:create
      - run: bundle exec rake db:schema:load

      # run tests!
      - run:
          name: run tests
          command: |
            mkdir /tmp/test-results
            TEST_FILES="$(circleci tests glob "spec/**/*_spec.rb" | circleci tests split --split-by=timings)"

            bundle exec rspec --format progress \
                            --format RspecJunitFormatter \
                            --out /tmp/test-results/rspec.xml \
                            --format progress \
                            $TEST_FILES
      # collect reports
      - store_test_results:
          path: /tmp/test-results
      - store_artifacts:
          path: /tmp/test-results
          destination: test-results

  production-deploy:
    machine: true
    steps:
      - checkout
      - run:
          name: Run setup script
          command: bash .circleci/setup-heroku.sh
      - add_ssh_keys:
          fingerprints:
            - "b0:01:cb:56:32:7d:3c:58:5c:11:c3:c3:f3:0b:1d:35"
      - run:
          name: Deploy Staging to Heroku
          command: |
            git fetch
            heroku maintenance:on --app ah-myflix
            heroku pg:backups capture --app ah-myflix
            git push git@heroku.com:ah-myflix.git $CIRCLE_SHA1:refs/heads/master
            heroku run rake db:migrate --app ah-myflix
            heroku maintenance:off --app ah-myflix

  staging-deploy:
    machine: true
    steps:
      - checkout
      - run:
          name: Run setup script
          command: bash .circleci/setup-heroku.sh
      - add_ssh_keys:
          fingerprints:
            - "b0:01:cb:56:32:7d:3c:58:5c:11:c3:c3:f3:0b:1d:35"
      - run:
          name: Deploy Staging to Heroku
          command: |
            git fetch
            heroku maintenance:on --app ah-myflix-staging
            git push git@heroku.com:ah-myflix-staging.git $CIRCLE_SHA1:refs/heads/master
            heroku run rake db:migrate --app ah-myflix-staging
            heroku maintenance:off --app ah-myflix-staging

workflows:
  version: 2
  test-deploy:
    jobs:
      - test-job
      - production-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: master
      - staging-deploy:
          requires:
            - test-job
          filters:
            branches:
              only: staging
```

If you are following along you will need to use your "fingerprints" obtained from the Circle CI SSH permissions page and of course your production and deployment app names when pushing to heroku.

This file now tells Circle CI to run that setup script we created earlier, add the `fingerprint` generated from the private SSH key we added to Circle, then run our commands that will push to heroku and setup the database.

6. Commit these changes and push the code to the staging branch. Circle CI should now run the `test-job` successfully as it did before, then run the `staging-deploy` job successfully and result in the code being pushed to heroku.

7. You should be able to do the same for the master branch as well. Not the `heroku pg:backups capture` line used to backup the database in case of tragedy.

## Lesson: Beyond MVC (1) - Decorators

As your applications grows even more, how do you manage complexity and keep code base clean.

### Technique 1 - Decorator Pattern

In our Todo App we have this code to format and display a Todo name:
```ruby
class Todo < ActiveRecord::Base
  def display_text
    name + tag_text
  end

  private

  def tag_text
    # ....
  end
end
```

We will now extract this into a decorator.

Create a directory `app/decorators`. Create the file `app/decorators/todo_decorator.rb`
```ruby
# app/decorators/todo_decorator.rb

class TodoDecorator
  attr_reader :todo

  def initialize(todo)
    @todo = todo
  end

  def display_text
    todo.name + tag_text
  end

  private

  def tag_text
    # ....
  end
end
```

Now in the view we can change:
```haml
= link_to todo.display_text, todo
```
to
```haml
= link_to TodoDecorator.new(todo).display_text, todo
```

We can even do this:
```ruby
class Todo < ActiveRecord::Base
  def display_text
    name + tag_text
  end

  def decorator
    TodoDecorator.new(self)
  end

  private

  def tag_text
    # ....
  end
end
```
then this:
```haml
= link_to todo.decorator.display_text, todo
```

---

In complex views we may need methods from both the object and its decorator but we don't want the view to have to remember when to instantiate the decorator and when to use the model.

So go to the controller and let's now pass in a list of decorators, extend the Forwardable module in the decorator and define some delegators so that the delegator will respond correctly to the model methods.

```ruby
class TodosControlelr < AuthenticatedController
  def index
    @todos = current_user.todos.map(&:decorator)
  end
end
```

```ruby
class TodoDecorator
  extend Forwardable

  # name_only? is part of the full Todo class
  def_delegators :todo, :name_only?

  attr_reader :todo

  def initialize(todo)
    @todo = todo
  end

  def display_text
    todo.name + tag_text
  end

  private

  def tag_text
    # ....
  end
end
```

Decorators are valuable when we persist models one way in the database and present them differently on the web page. The decorator defines the presentation logic. Now we can test the logic and presentation methods separately.

There is a gem called [draper](https://github.com/drapergem/draper). It give a few convenience methods like `delegate_all`.

So a lot of helpers and logic in views can be pulled into decorators for a cleaner solution.

## Lesson: Beyond MVC (2) - Policy Objects
Introducing Policy Objects

We have complicated logic in `TodosController#create` action.
```ruby
class TodosController < AuthenticatedController
  def create
    @todo = Todo.new(params[:todo])
    if @todo.save_with_tags
      if current_user.created_at < Date.new(2010, 1, 1) || current_user.plan.premium?
        new_credit_balance = current_user.current_credit_balance - 1
      else
        new_credit_balance = current_user.current_credit_balance - 2
      end

      current_user.current_credit_balance = new_credit_balance
      current_user.save

      if new_credit_balance < 0
        AppMailer.notify_insufficient_credit(current_user).deliver
      elsif current_user.current_credit_balance < 10
        AppMailer.notify_low_balance(current_user).deliver
      end

      redirect_to root_path
    else
      render :new
    end
  end
end
```

Clearly we have different types of users, a premium user and a regular user (based on the credits charged).

We will use a **Policy Object** here to handle the distinctions.

```ruby
# app/models/user_level_policy.rb

class UserLevelPolicy
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def premium?
    if user.created_at < Date.new(2010, 1, 1) || user.plan.premium?
  end
end
```

Then in the controller:

```ruby
class TodosController < AuthenticatedController
  def create
    @todo = Todo.new(params[:todo])
    if @todo.save_with_tags
      if UserLevelPolicy.new(current_user).premium?
        new_credit_balance = current_user.current_credit_balance - 1
      else
        new_credit_balance = current_user.current_credit_balance - 2
      end

      current_user.current_credit_balance = new_credit_balance
      current_user.save

      if new_credit_balance < 0
        AppMailer.notify_insufficient_credit(current_user).deliver
      elsif current_user.current_credit_balance < 10
        AppMailer.notify_low_balance(current_user).deliver
      end

      redirect_to root_path
    else
      render :new
    end
  end
end
```

So we are using the policy object to capture a specific piece of knowledge - what a premium user is. We could have `premium`, `gold`, `silver`, etc. Now we have one place to define all the levels, uncomplicated.

## Lesson: Beyond MVC (3) - Domain Objects
Introducing Domain Objects

They are objects for domain models, meaning models in the context of the application domain. So far we have some already, all inherit from ActiveRecord::Base and match to a table in the database.

For the credit balance example above, credit is not mapped to a database table, it is only stored as a column on a table. Let's create it's own model though so we don't have to go through the user every time.

Create a new domain model called `Credit`. Note we are not extending from `ActiveRecord::Base` because we don't need it to map to a database table.
```ruby
class Credit
  attr_accessor :credit_balance, :user

  def initialize(user)
    @credit_balance = user.current_credit_balance
    @user = user
  end

  def -(number)
    credit_balance = credit_balance - number
  end

  def save
    user.current_credit_balance = credit_balance
    user.save
  end

  def depleted?
    credit_balance < 0
  end

  def low_balance?
    credit_balance < 10
  end
end
```

Now let's refactor the `TodosController#create` action:

```ruby
class TodosController < AuthenticatedController
  def create
    @todo = Todo.new(params[:todo])
    @credit = Credit.new(current_user)
    if @todo.save_with_tags
      if UserLevelPolicy.new(current_user).premium?
        credit = credit - 1
      else
        credit = credit - 2
      end

      credit.save

      if credit.depleted?
        AppMailer.notify_insufficient_credit(current_user).deliver
      elsif credit.low_balance?
        AppMailer.notify_low_balance(current_user).deliver
      end

      redirect_to root_path
    else
      render :new
    end
  end
end
```

Now this code is much easier to read. All the business logic around credits is now contained in one place. Using these domain objects is that you don't have to couple the concepts directly with the way they are persisted in the database.

## Lesson: Beyond MVC (4) - Service Objects
Introducing Service Objects

Look at that `create` action again.
```ruby
      if UserLevelPolicy.new(current_user).premium?
        credit = credit - 1
      else
        credit = credit - 2
      end

      credit.save

      if credit.depleted?
        AppMailer.notify_insufficient_credit(current_user).deliver
      elsif credit.low_balance?
        AppMailer.notify_low_balance(current_user).deliver
      end
```

This section of it only pertains to how to deduct credits from a user's account. Just like using domain object to make a concept more explicit, we can use **service objects** to make a business process in the application domain more explicit.

Services are about modeling the verbs in your application, so the naming convention for the following service could be `DeductCredit` instead of `CreditDeduction`. (Domain objects typically model nouns). We will use `CreditDeduction` because we are modeling the process not simply the literal action of deducting credit.

```ruby
# app/services/credit_deduction.rb

class CreditDeduction
  attr_accessor :credit, :user

  def initialize(credit, user)
    @credit = Credit.new(user)
    @user = user
  end

  def deduct_credit
    if UserLevelPolicy.new(user).premium?
      credit = credit - 1
    else
      credit = credit - 2
    end

    credit.save

    if credit.depleted?
      AppMailer.notify_insufficient_credit(user).deliver
    elsif credit.low_balance?
      AppMailer.notify_low_balance(user).deliver
    end
  end
end
```

Then the controller create action now looks like this:

```ruby
class TodosController < AuthenticatedController
  def create
    @todo = Todo.new(params[:todo])
    if @todo.save_with_tags
      CreditDeduction.new(current_user).deduct_credit

      redirect_to root_path
    else
      render :new
    end
  end
end
```

## Lesson: Beyond MVC (5) - Object Composition, Object Oriented Design and YAGNI

To review:
1. In the controller we delegate logic to the service object `CreditDeduction`.
2. `CreditDeduction` collaborate with the domain object `Credit`, `User`, and `UserLevelPolicy` objects (and `AppMailer`) to accomplish the task.

This is called **object composition** - build complex logic out of small components with simple responsibilities. We get modularity and reuseability but at a cost - indirection. It can be tough to follow the logic, from class to class, file to file.

**YAGNI**: You aren't gonna need it. Don't abstract if you probably aren't going to need. It's better to wait and make that abstraction in the future if you really need to.

## Lesson: Message expectations
Rspec Message Expectations

**The expectation/assertion must be placed before that actual action that will test it.**

Example from docs:
A message expectation is an expectation that an object should receive a specific message during the course of a code example:

```ruby
describe Account do
  context "when closed" do
    it "logs an 'account closed' message" do
      logger = double()
      account = Account.new
      account.logger = logger

      logger.should_receive(:account_closed).with(account)

      account.close
    end
  end
end
```

This example specifies that the account object sends the logger the account_closed message (with itself as an argument) when it receives the close message.

View https://relishapp.com/rspec/rspec-mocks/v/2-99/docs/message-expectations/expect-a-message-on-any-instance-of-a-class for when you can get a handle on the specific object.

## Lesson: Mocking
In our Todo app we have the CreditDeduction inside the create action. To test this object collaboration, in the Todo spec we just need to make sure the Todo controller is telling the CreditDeduction to do something, but that something doesn't need to be tested in the TodosController. The CreditDeduction functionality can be tested in its own spec.

This is called **mocking** - instead of asserting on values like usual, we assert on communication.

Start with this code we wrote before:
```ruby
class TodosController < AuthenticatedController
  def create
    @todo = Todo.new(params[:todo])
    if @todo.save_with_tags
      CreditDeduction.new(current_user).deduct_credit

      redirect_to root_path
    else
      render :new
    end
  end
end
```

Then add some specs to the TodosController spec.
```ruby
# spec/controllers/todos_controller_spec.rb

require 'spec_helper'

describe TodosController do
  describe "POST create" do
    it "delegates to CreditDeduction to deduct credit" do
      # create test double for service object
      credit_deduction = double("credit deduction")
      # whenever we call CreditDeduction.new we will make sure it returns the test double
      CreditDeduction.stub(:new).with(alice).and_return(credit_deduction)
      # assert the double should be sent the message :deduct_credit
      credit_deduction.should_receive(:deduct_credit)
      # the trigger for the action
      post :create, todo: {name: "cook", description: "I like cooking!"}
    end
  end
end
```

Look at the domain model.
```ruby
class Credit
  attr_accessor :credit_balance, :user

  def initialize(user)
    @credit_balance = user.current_credit_balance
    @user = user
  end

  # This does change state
  # Set balance, change it, then assert the credit object is in a certain state
  def -(number)
    credit_balance = credit_balance - number
  end

  # This goes beyond the boundary of the object, to a collaborate (user)
  # To make a true unit test we should mock the user and test the
  # user receive a certain trigger (current_credit_balance) with (credit_balance)
  def save
    user.current_credit_balance = credit_balance
    user.save
  end

  # These two don't change the state of the credit object.
  # Test them by setting credit balance to specific value.
  # Then test each by looking for true/false

  def depleted?
    credit_balance < 0
  end

  def low_balance?
    credit_balance < 10
  end
end
```

## Lesson: Stubs and Mocks

https://martinfowler.com/articles/mocksArentStubs.html
http://confreaks.tv/videos/rubyconf2011-why-you-don-t-get-mock-objects

## Watch "The Magic Tricks of Testing"

This is a good video by Sandi Metz talking about how to test objects in collaboration. It's a good one, and should help solidify some of the concepts we introduced in this lesson.


https://www.youtube.com/watch?v=URSWYvyc42M

| Message | Query | Command |
| --- | --- | --- |
| Incoming | Assert the result | Assert the direct public side effects |
| Sent to Self | Ignore | Ignore |
| Outgoing | Ignore | Expect to send the message |
