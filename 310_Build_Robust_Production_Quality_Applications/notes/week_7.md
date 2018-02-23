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
