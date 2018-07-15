# Week 6

## Lesson: Separating Actors

Separating actors in your application.

It is very typically for applications to have different types of users (admin, etc), typically called actors.

One way to do this is to add something to each controller to give each actor different abilities.
```ruby
class TodosController < ApplicationController
  def index
    if current_user.admin?
      Todo.all
    else
      @todos = current_user.todos
    end
  end
end
```

This might be ok if this were the only place we needed to do this. It becomes cumbersome if this is scattered throughout the application.

Another way is to have a separate action, like `admin_index`.

```ruby
class TodosController < ApplicationController
  def admin_index
    Todo.all
    render :index
  end
end
```

Advantage: All admin stuff is in separate action, and clear.
Problem: If there is a lot that admin can do then we will have a ton of a "admin" style actions. If there are more actors, then we need actions for each one of them. This is also hard to secure the application and keep the priveleges separated with respect to the correct actor.


**Solution:**

```ruby
# config/routes.rb

namespace :admin do
  resources :todos, only: [:index, :destroy]
end
```
This way, admin will be the only ones who can destroy todos. Then for multiple actors we can just make multiple namespaces.

Run `rake routes` and you will see a couple routes:
| Prefix Verb | URI Pattern | Controller#Action |
| --- | --- |--- | --- |
| admin_todos | GET | /admin/todos(.:format) | admin/todos#index |
| admin_todo | DELETE | /admin/todos/:id(.:format) | admin/todos#destroy |

So now URLs will all start with `admin` because of the `namespace`. And the controller is actually `admin/todos`. So this is placed in the `app/controllers/admin/todos_controller.rb`.
```ruby
# app/controllers/admin/todos_controller.rb
class Admin::TodosController < ApplicationController
  def index
    @todos = Todo.all
  end
end
```

To test, create an admin in rails console. And before we do that we need a migration to create a column to specify if someone is an an admin.

```ruby
# migration file
class AddAdminToUser < ActiveRecord::Migration
  def change
    add_column :users, :admin, :boolean
  end
end
```

Migrate this.

`rake db:migrate db:test:prepare`

Now make an admin.

```bash
rails c
User.create(username: "admin", full_name: "Admin User", email: "admin@example.com", admin: true)
```

Now signing in as the admin user will work but it will not be directed to the `admin/todos` controller, just the normal `todos` controller. This is because of the `sessions` controller. In the `create` action of `sessions`, we need to differentiate these behaviors.

```ruby
class SessionsController < ApplicationController
  def create
    user = User.where(username: params[:username]).first
    session[:user_id] = user.id
    redirect_to current_user.admin? ? admin_todos_path : todos_path
  end
end
```

Now create the view template:
```ruby
# app/views/admin/todos/index.html.haml

# Give the view anything you want just the admin to be able to see.
```

## Lesson: Securing Access

Securing access for different actors.

Could do this by adding `ensure_admin` before filter.
```ruby
# app/controllers/admin/todos_controller.rb
before_action :ensure_admin

class Admin::TodosController < ApplicationController
  def index
    @todos = Todo.all
  end
end
```

Ok if we have a very simple app without a lot of controllers for admin area.

Instead, create a new controller called `AdminsController` and inherit from it.

```ruby
# app/controllers/admin/todos_controller.rb
class Admin::TodosController < AdminsController
  def index
    @todos = Todo.all
  end
end
```

```ruby
# app/controllers/admins_controller.rb
class AdminsController < ApplicationController
  before_filter :ensure_admin

  def ensure_admin
    flash[:error] = 'You do not have access to that area.'
    redirect_to root_path unless current_user.admin?
  end
end
```

So now all admin controllers can inherit from this admins controller and will automatically have this ensure admin check.

We can go one step further and make the `ensure_sign_in` used for authenticated users as part of a separate controller.

```ruby
# app/controllers/authenticated_controller.rb
class AuthenticatedController < ApplicationController
  before_action :ensure_sign_in
end
```

And now since an admin needs to ensure sign in as well, the `AdminsController` should inherit from `AuthenticatedController` (which inherits from the main `ApplicationController`).
```ruby
# app/controllers/admins_controller.rb
class AdminsController < AuthenticatedController
  before_filter :ensure_admin

  def ensure_admin
    flash[:error] = 'You do not have access to that area.'
    redirect_to root_path unless current_user.admin?
  end
end
```

So having actor-specific controllers, we can easily separate the abilities of each actor. These actor controllers can inherit from other actor controllers like we did here.

#### Summary
Compartmentalize the resource manipulation into the controllers for specific actors using `namespace`.
Those controllers should inherit from actor-specific controllers where you can secure access.

## Lesson: [Amazon S3](https://aws.amazon.com/free/?sc_channel=PS&sc_campaign=acquisition_US&sc_publisher=google&sc_medium=s3_b_rlsa_hv&sc_content=s3_e&sc_detail=amazon%20s3&sc_category=s3&sc_segment=213224374763&sc_matchtype=e&sc_country=US&s_kwcid=AL!4422!3!213224374763!e!!g!!amazon%20s3&ef_id=WJfFGAAAAcQMUF2u:20180220170307:s&awsf.undefined=categories%23featured) Service

A cloud-based storage service useful for application data and user data.

Can serve content like images, videos, audios, etc. Or you can allow users to upload content to your website.

There is a free tier for limited storage.

Just create at account, then a bucket, then use the UI to upload to S3.

If interacting with it frequently, [Cyberduck](https://cyberduck.io/) and [transmit](https://panic.com/transmit/) are good choices for Mac users. There are others for other platforms.

## Lesson: File Uploading with [Carrierwave](https://github.com/carrierwaveuploader/carrierwave)

Also watch this [Rails Cast](http://railscasts.com/episodes/253-carrierwave-file-uploads).

The go-to gem in ruby/rails for file uploading.

How to use:
1. In Rails, add it to Gemfile:
    ```ruby
    gem 'carrierwave'
    ```
      and `bundle install`. This will add a new generator that will allow you to generate uploaders to manage the infrastructure concerns for file uploading including uploading, processing, and storage.
2. Generate uploader
    ```bash
    rails generate uploader Avatar
    ```
3. Generating an uploader will create an uploader class and extend it from CarrierWave::Uploader::Base
    ```ruby
    class AvatarUploader < CarrierWave::Uploader::Base
      storage :file
    end
    ```
4. Then you can store and retrieve files like so:
    ```ruby
    uploader = AvatarUploader.new
    uplaoder.store!(myfile)
    uploader.retrieve_from_store!('my_file.png')
    ```
5. Use `store` for permanent storage and `cache` for temporary storage.

#### It works with ActiveRecord nicely
May need `require 'carrierwave/orm/activerecord'`
1. Add a string column to teh model you want to mount the uploader on:
    ```ruby
    add_column :users, :avatar, :string
    ```
2. Mount the uploader
    ```ruby
    class User < ActiveRecord::Base
      mount_uploader :avatar, AvatarUploader
    end
    ```
3. Now yo ucan cache files by assigning them to the attribute, they will automatically be stored when teh record is saved.
    ```ruby
    u = User.new
    u.avatar = params[:file]
    u.avatar = File.open('somewhere')
    u.save!
    u.avatar.url # => '/url/to/file.png'
    u.avatar.current_path # => 'path/to/file.png'
    u.avatar.identifier # => 'file.png'
    ```

CarrierWave is customizable. Can change source directory (like to cloud storage). You can secure uploads, allow only certain extensions, etc.

**Really valuable feature:** Being able to allow multiple versions of the same file. For example: having a thumbnail image of a main file.
```ruby
class MyUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  process :resize_to_fit => [800, 800]

  version :thumb do
    process :resize_to_fill => [200, 200]
  end
end
```

To do this you need to install [Image Magick](https://www.imagemagick.org/script/index.php) on local machine.

Then you can do:
```ruby
uploader = AvatarUploader.new
uploader.store!(my_file)                              # size: 1024x768

uploader.url # => '/url/to/my_file.png'               # size: 800x800
uplaoder.thumb.url # => '/url/to/thumb_my_file.png'   # size: 200x200
```

#### Providing a Default URL
A default url is a fallback in case no file has been uploaded. Override the default method in uploader:
```ruby
class MyUploader < CarrierWave::Uploader::Base
  def default_url
    "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end
end
```
Could put the username in it to ensure the url is unique to each user.

#### Testing with CarrierWave
Test the uploader separately. CarrierWave comes with its own matchers.

It's a good idea to test your uploaders in isolation. In order to speed up your tests, it's recommended to switch off processing in your tests, and to use the file storage. In Rails you could do that by adding an initializer with:

```ruby
if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end
end
```

```ruby
require 'carrierwave/test/matchers'

describe MyUploader do
  include CarrierWave::Test::Matchers

  let(:user) { double('user') }
  let(:uploader) { MyUploader.new(user, :avatar) }

  before do
    MyUploader.enable_processing = true
    File.open(path_to_file) { |f| uploader.store!(f) }
  end

  after do
    MyUploader.enable_processing = false
    uploader.remove!
  end

  context 'the thumb version' do
    it "scales down a landscape image to be exactly 64 by 64 pixels" do
      expect(uploader.thumb).to have_dimensions(64, 64)
    end
  end

  context 'the small version' do
    it "scales down a landscape image to fit within 200 by 200 pixels" do
      expect(uploader.small).to be_no_larger_than(200, 200)
    end
  end

  it "makes the image readable only to the owner and not executable" do
    expect(uploader).to have_permissions(0600)
  end

  it "has the correct format" do
    expect(uploader).to be_format('png')
  end
end
```

#### Using CarrierWave with Amazon S3
**Remember not to put sensitive info in source files.**

[Fog AWS](http://github.com/fog/fog-aws) is used to support Amazon S3. Ensure you have it in your Gemfile:

```ruby
gem "fog-aws"
```

You'll need to provide your fog_credentials and a fog_directory (also known as a bucket) in an initializer. For the sake of performance it is assumed that the directory already exists, so please create it if it needs to be. You can also pass in additional options, as documented fully in lib/carrierwave/storage/fog.rb. Here's a full example:

```ruby
CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     'xxx',                        # required
    aws_secret_access_key: 'yyy',                        # required
    region:                'eu-west-1',                  # optional, defaults to 'us-east-1'
    host:                  's3.example.com',             # optional, defaults to nil
    endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
  }
  config.fog_directory  = 'name_of_directory'                                   # required
  config.fog_public     = false                                                 # optional, defaults to true
  config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
end
```

In your uploader, set the storage to :fog

```ruby
class AvatarUploader < CarrierWave::Uploader::Base
  storage :fog
end
```

That's it! You can still use the CarrierWave::Uploader#url method to return the url to the file on Amazon S3.

#### Using [MiniMagick](https://github.com/minimagick/minimagick) vs. RMagick
Prefer MiniMagick - it's a way to have the power of ImageMagick without having to worry about install all the RMagick libraries.

To do this just include the `MiniMagick` module:
```ruby
class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  process :resize_to_fill => [200, 200]
end
```

Requirement: use mini magick gem
```ruby
gem 'mini_magick'
```

## Assignment: Admin adds a video

**Important Update for Amazon S3**: Amazon has since added an extra step that you need to now add permissions by attaching a user policy to a user. You can follow it here:

http://docs.aws.amazon.com/AmazonS3/latest/dev/walkthrough1.html

You can use this user policy:
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "NotAction": "iam:*",
      "Resource": "*"
    }
  ]
}
```

**Also, the `carrierwave` gem now recommends using the `fog-aws` gem for s3 uploads, but we have found it to be buggy. We now recommend using the `carrierwave-aws` gem instead.** You can see it here:

https://github.com/sorentwo/carrierwave-aws

Follow instructions there to set it up with carrierwave, and remember to use it only on staging and production environments.

**Note: If you don't have ImageMagick locally, you need to install it.**

If you are on Mac, the easiest way is to use homebrew. Follow the instruction here: http://stackoverflow.com/questions/7053996/how-do-i-install-imagemagick-with-homebrew

If you are on Linux, you can use apt-get: http://superuser.com/questions/163818/how-to-install-rmagick-on-ubuntu-10-04

**WARNING: You should never commit your Amazon AWS credentials directly into your code, and this is especially so if you are pushing your code to Github as an open source project. There are bots that scan Github repositories and extract credentials and then turn around to hack into your Amazon AWS account to use your computing resource. We have seen people getting bills of a few thousand dollars in the past! Store your credentials on Heroku as environment variables. You could also use a solution like dotenv or figaro - see [this blog post of ours](http://launchschool.com/blog/managing-environment-configuration-variables-in-rails).**

## Assignment: Watch Video

Note: if for some reason you can't have the videos stream in the browser, check the following settings in the AWS console:

Within your bucket, right-click on the video to bring up the contextual menu, and select "Properties". Under "Metadata", make sure that the Key is "Content-Type" and that its associated value is "video/mp4" (you may have to manually set it).

You may also need to manually edit bucket permissions (check view permissions for everyone) for the video to stream.

## Lesson: Collect Credit Card Payments

Read [this article](https://signalvnoise.com/posts/753-ask-37signals-how-do-you-process-credit-cards) to understand what a pain it was back then (2007) to process credit card payments.

What is not included in the article is [Payment Card Industry Data Security Standard](https://en.wikipedia.org/wiki/Payment_Card_Industry_Data_Security_Standard). This means (PCI compliant). The gist of this is that it requires a ton of steps and custom code to become PCI compliant and have your small app be able to process credit card payments.

Luckily the online payment structure has changed a ton.

[Stripe](https://stripe.com) now exists to make this whole process much much easier.
Now you don't need a merchant account or gateway. This is a huge relief because creating a merchant account used to mean going to a bank, talking to someone, filling out an application, etc etc and then once a approved you can go to your gateway and set everything up.

It even offers a test mode so you can play with the process before going live. Once your ready you just have to link your stripe account to your bank account.

Using Stripe.js allows you to never have to process user information. Their info goes directly to the Stripe servers which let's you bypass all PCI compliant requires because Stripe handles everything.

## Lesson: First Charge with Stripe

Sign up with Stripe.

Flipping to "Live mode" will require you to activate your account, attach bank account info, etc.

Include stripe in `Gemfile`.
```ruby
gem 'stripe'
```

Go to the rails console.
```bash
rails console
```

Specify Stripe API key, use the Test Secret Key
```bash
Stripe.api_key = "TEST_SECRET_KEY"
```

Example charge from Stripe API documentation.
**Remember: Ecommerce payments are always in cents.**
```ruby
require "stripe"
Stripe.api_key = "TEST_SECRET_KEY"

Stripe::Charge.create(
  :amount => 2000,
  :currency => "usd",
  :source => "tok_visa", # obtained with Stripe.js
  :description => "Charge for emma.harris@example.com"
)
```

Go to https://stripe.com/docs/testing for info on testing, including fake credit card numbers used to simulate different accounts.

Input this above charge into console and a JSON return from Stripe should pop up.
Looks like Strip automatically filled out card information under the `source` key.
```json
#<Stripe::Charge:0x33d2798 id=ch_1By06JEB8VdfobgqygCGGdsc> JSON: {
  "id": "ch_1By06JEB8VdfobgqygCGGdsc",
  "object": "charge",
  "amount": 2000,
  "amount_refunded": 0,
  "application": null,
  "application_fee": null,
  "balance_transaction": "txn_1By06JEB8VdfobgqyAAYjytT",
  "captured": true,
  "created": 1519229147,
  "currency": "usd",
  "customer": null,
  "description": "Charge for emma.harris@example.com",
  "destination": null,
  "dispute": null,
  "failure_code": null,
  "failure_message": null,
  "fraud_details": {},
  "invoice": null,
  "livemode": false,
  "metadata": {},
  "on_behalf_of": null,
  "order": null,
  "outcome": {"network_status":"approved_by_network","reason":null,"risk_level":"normal","seller_message":"Payment complete.","type":"authorized"},
  "paid": true,
  "receipt_email": null,
  "receipt_number": null,
  "refunded": false,
  "refunds": {"object":"list","data":[],"has_more":false,"total_count":0,"url":"/v1/charges/ch_1By06JEB8VdfobgqygCGGdsc/refunds"},
  "review": null,
  "shipping": null,
  "source": {"id":"card_1By06JEB8VdfobgqzaRByz0i","object":"card","address_city":null,"address_country":null,"address_line1":null,"address_line1_check":null,"address_line2":null,"address_state":null,"address_zip":null,"address_zip_check":null,"brand":"Visa","country":"US","customer":null,"cvc_check":null,"dynamic_last4":null,"exp_month":8,"exp_year":2019,"fingerprint":"pel6e9vrF4SvsbpN","funding":"credit","last4":"4242","metadata":{},"name":null,"tokenization_method":null},
  "source_transfer": null,
  "statement_descriptor": null,
  "status": "succeeded",
  "transfer_group": null
}
```

## Lesson: Accept Payments with [Checkout](https://stripe.com/docs/checkout)

Accept credit card payments with Stripe Checkout

Create a route for payments:
```ruby
# config/routes.rb

resources ;payments, only: [:new]
```

Create the `:new` view:
The JavaScript tag was taken from the Stripe Checkout page linked above.
```ruby
# app/views/payments/new.html.haml

= form_tag payments_path do |f|
    %script(src="https://checkout.stripe.com/checkout.js" class="stripe-button" data-key="TEST_PUBLISHABLE_KEY" data-amount="3000" data-name="Support Todo App!" data-description="Thank you for you donation!" data-locale="auto" data-zip-code="true")
```

This loads the JS from Stripe.com.
`data-key`: our publishable test key because we are in test mode.
`data-amount`: how much we want to charge in cents
`data-name`: the name of the form
`data-description`: of the payment
`data-image`: logo of charge form (we don't have one so get rid of it.)

**Look on the Stripe docs to find more info you can collect from users.**

Now go to the app, make a payment with fake info:
* card number: 4242424242424242
* cvc: 123
* exp date: 11/19
* and any other info you need (maybe zipcode and email)

Put a `binding.pry` in the `Payments#create` action and view the params that are returned.

There should be a `stripeToken` and possibly other stipe keys. The actually credit card number doesn't flow through our server, we just get the token that represents it.



Go to the [docs](https://stripe.com/docs/charges) for charging cards.
code copied from that doc:
```ruby
# Set your secret key: remember to change this to your live secret key in production
# See your keys here: https://dashboard.stripe.com/account/apikeys
Stripe.api_key = "sk_test_fiAG8z1KPD3ixkm7nEMDheTD"

# Token is created using Checkout or Elements!
# Get the payment token ID submitted by the form:
token = params[:stripeToken]

# Charge the user's card:
charge = Stripe::Charge.create(
  :amount => 999,
  :currency => "usd",
  :description => "Example charge",
  :source => token,
)
```

Copy this code into the `create` action of the controller.

Actually, modify this to the following:
```ruby
# Set your secret key: remember to change this to your live secret key in production
# See your keys here: https://dashboard.stripe.com/account/apikeys
Stripe.api_key = "sk_test_fiAG8z1KPD3ixkm7nEMDheTD"

# Token is created using Checkout or Elements!
# Get the payment token ID submitted by the form:
token = params[:stripeToken]

begin
  # Charge the user's card:
  charge = Stripe::Charge.create(
    :amount => 999,
    :currency => "usd",
    :description => "Example charge",
    :source => token,
  )
rescue Stripe::CardError => e
  flash[:error] = e.message
end
```

Be sure to test the failing cases as well using "bad" credit card numbers that simulate various errors. They can be found on [this page](https://stripe.com/docs/testing).

## Lesson: Accept Payments with Custom Form

Accept credit card payments with Stripe.js

This is for a more integrated approach to have the form right in the app. This way we can have total control of the fields.

For the Todos App:
```ruby
# app/views/payments/new.html.haml

%h4 Please make a payment with your credit card.

= form_tag payments_path, id: 'payment-form' do
  %fieldset.credit_card
    %span.payment-errors
    %label Credit Card Number
    %input.span3.card-number(type="text")
    %label Security Code
    %input.span3.card-cvc(type="text")
    %label Expiration
    = select_month(Date.today, {add_month_numbers: true}, name: nil, class: 'span2 card-expiry-month')
    = select_year(Date.today.year, {start_year: Date.today.year, end_year: Date.today.year + 4}, name: nil, class: 'span1 card-expiry-year')
  %fieldset.actions
    = submit_tag "Submit Payment", class: "btn payment_submit"
```

Remember if using `form_for` or `bootstrap_form_for` to place the form id inside the `html` key like so:
```ruby
= bootstrap_form_for @user, layout: :horizontal, label_col: "col-sm-2", control_col: "col-sm-6", html: { id: "payment-form" } do |f|
  ...
```

We will use [Stripe.js](https://stripe.com/docs/stripe-js) to build our own custom form that looks like this. This may be the more appropriate page to reference [quickstart](https://stripe.com/docs/stripe-js/elements/quickstart).


In the layout put this:
```ruby
<!DOCTYPE html>
<html>
  <head>
    <title>Todo310</title>
    <%= csrf_meta_tags %>

    <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
    <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
    ##################################################
    <%= yield :head %>
    ##################################################
  </head>

  <body>
    <%= render 'shared/messages' %>
    <%= yield %>
  </body>
</html>
```

And in the payment view include this:
```ruby
# app/views/payments/new.html.haml
##################################################
= content_for :head do
  %script(src="https://js.stripe.com/v3/")
##################################################

%h4 Please make a payment with your credit card.

= form_tag payments_path, id: 'payment-form' do
  %fieldset.credit_card
    %span.payment-errors
    %label Credit Card Number
    %input.span3.card-number(type="text")
    %label Security Code
    %input.span3.card-cvc(type="text")
    %label Expiration
    = select_month(Date.today, {add_month_numbers: true}, name: nil, class: 'span2 card-expiry-month')
    = select_year(Date.today.year, {start_year: Date.today.year, end_year: Date.today.year + 4}, name: nil, class: 'span1 card-expiry-year')
  %fieldset.actions
    = submit_tag "Submit Payment", class: "btn payment_submit"
```

**This is outdated instruction using Stripe.js version 1. (currently v3).**
Then set the publishable key:

```ruby
# app/views/payments/new.html.haml
= content_for :head do
  %script(src="https://js.stripe.com/v3/")
  :javascript
    Stripe.setPublishableKey('STRIPE_PUBLISHABLE_KEY');

%h4 Please make a payment with your credit card.

= form_tag payments_path, id: 'payment-form' do
  %fieldset.credit_card
    %span.payment-errors
    %label Credit Card Number
    %input.span3.card-number(type="text")
    %label Security Code
    %input.span3.card-cvc(type="text")
    %label Expiration
    = select_month(Date.today, {add_month_numbers: true}, name: nil, class: 'span2 card-expiry-month')
    = select_year(Date.today.year, {start_year: Date.today.year, end_year: Date.today.year + 4}, name: nil, class: 'span1 card-expiry-year')
  %fieldset.actions
    = submit_tag "Submit Payment", class: "btn payment_submit"
```

**IMPORTANT: None of the inputs have name attributes so they will not be posted to our server. This is a good this so we never have a record of the sensitive information. Our JS will intercept the submit and send the info off the Stripe so we can get a safe-to-use tooken back.**

Then inlucde the javascript payments file:
```ruby
# app/views/payments/new.html.haml
= content_for :head do
  %script(src="https://js.stripe.com/v3/")
  :javascript
    Stripe.setPublishableKey('STRIPE_PUBLISHABLE_KEY');
  = javascript_include_tag 'payments'

  ...
```

```js
// app/assets/javascripts/payments.js

jQuery(function($) {
  // Look at the form element with the id and intercepts the submit event
  $('#payment-form').submit(function(event) {
    var $form = $(this);
    // disables the submit button so it can't be submitted again
    $form.find('.payment_submit').prop('disabled', true);
    // Comes from Stripe.js to create the token using the values
    // from the form
    // This is communicating with stripe to get a token back.
    // This is an async call.
    Stripe.createToken({
      number: $('.card-number').val(),
      cvc: $('.card-cvc').val(),
      exp_month: $('.card-expiry-month').val(),
      exp_year: $('.card-expiry-month').val()
    }, stripeResponseHandler);
    //
    return false;
  });

  var stripeResponseHandler = function(status, response) {
    var $form = $('#payment-form');

    // if credit card data has errors, then show them in the .payment-errors element and let the form be submitted again
    if (response.error) {
      $form.find('.payment-errors').text(response.error.messages);
      $form.find('.payment_submit').prop('disabled', false);
    } else {
      // if no errors, take the response.id as the token and insert
      // a hidden field into the form that will then be submitted.
      var token = response.id;
      $form.append($('<input type="hidden" name="stripeToken" />').val(token));
      $form.get(0).submit();
    }
  }
});
```

Our charge submission code was already written in the create action earlier, nothing needs to be changed there. Everything should work just as before.

## Assignment: Use Stripe custom form to charge credit card
**SEE THE NEXT SECTION FOR MY UPDATED IMPLEMENTATION USING STRIPE v3.**

**Note:** Remember to include your `payments.js` javascript file inside your view template, like the way we did in 03:27 of the previous lesson. Also, make sure you **DON'T** include it in the `application.js` file. If you include it in both places, that javascript code is going to be executed twice and you'll get strange errors.

You should also create a file `config/initializers/assets.rb` with the following content (assuming your javascript file is called `payments.js`):

```ruby
Rails.application.config.assets.precompile += ['payments.js']
```

This file will help to make sure that you add the `payments.js` file in the asset pipeline for all environments (dev, test and production), although in the development environment it doesn't really compress the assets for you.

**Note:** If you are using CircleCI at this point, your build may fail and you may need to set your stripe key environment variable on the CircleCI server as well, so it'll have access to it. (Project Settings -> Environment Variables)

## Solution Using Stripe v3

For adding credit card payment on the registration page for a new user.

```ruby
# app/views/layouts/application.html.haml

!!! 5
%html(lang="en-US")
  %head
    %title MyFLiX - a video on demand service
    %meta(charset="UTF-8")
    %meta(name="viewport" content="width=device-width, initial-scale=1.0")
    = csrf_meta_tag
    = stylesheet_link_tag "application"
    = javascript_include_tag "application"
    = yield :head
  %body
    %header
      = render 'shared/header'
    %section.content.clearfix
      = render 'shared/messages'
      = yield
    %footer
      &copy 2013 MyFLiX
```

```ruby
# app/views/users/new.html.haml

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
            %label.col-sm-3(for="card-element") Payment Information
            .col-sm-6
              #card-element.form-control
        %fieldset.actions.control-group.col-sm-offset-2
          .controls
            = submit_tag "Sign Up", class: "btn payment_submit"
```

```ruby
# config/initializers/assets.rb

Rails.application.config.assets.precompile += ['payments.js']
```

```js
// app/assets/javascripts/payments.js

$(function() {
  var elements = stripe.elements();

  // Create an instance of the card Element
  var card = elements.create('card');

  // Add an instance of the card Element into the `card-element` <div>
  card.mount('#card-element');

  // Listen for errors
  card.addEventListener('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
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

    stripe.createToken(card, cardData).then(stripeResponseHandler);

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
    // console.log($form)
    // if no errors, take the response.id as the token and insert
    // a hidden field into the form that will then be submitted.
    var $hiddenStripeToken = $('<input>');
    $hiddenStripeToken.attr('type', 'hidden');
    $hiddenStripeToken.a$(function() {
  var elements = stripe.elements();

  // Create an instance of the card Element
  var card = elements.create('card');

  // Add an instance of the card Element into the `card-element` <div>
  card.mount('#card-element');

  // Listen for errors
  card.addEventListener('change', function(event) {
    var displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
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

    stripe.createToken(card, cardData).then(stripeResponseHandler);

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
    // console.log($form)
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
ttr('name', 'stripeToken');
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

And don't forget to use the figaro gem and store sensitive information in this file:
```yml
# Add configuration values here, as shown below.
#
# pusher_app_id: "2954"
# pusher_key: 7381a978f7dd7f9a1117
# pusher_secret: abdc3b896a0ffb85d373
# stripe_api_key: sk_test_2J0l093xOyW72XUYJHE4Dv2r
# stripe_publishable_key: pk_test_ro9jV5SNwGb1yYlQfzG17LHK
#
development:
  STRIPE_PUBLISHABLE_KEY: `123456789`
  STRIPE_SECRET_KEY: `123456789123456789`

test:
  STRIPE_PUBLISHABLE_KEY: `123456789`
  STRIPE_SECRET_KEY: `123456789123456789`

production:
  STRIPE_PUBLISHABLE_KEY: `123456789`
  STRIPE_SECRET_KEY: `123456789123456789`
```
