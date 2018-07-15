# Week 5

## Lesson: Interact with Emails in Feature Tests

How to use [capybara-email](https://github.com/DavyJonesLocker/capybara-email) to interact with emails in feature tests.

Nice interface to interact with email content.

Can
* clear_emails
* visit - like normal capybara
* open_email - sets the current email.
* current_email

To do
* forgot password page
* input email
* send email
* user clicks link in email
* user puts in new password, submits
* verify that user can sign in with new password

## Lesson: Concerns
`ActiveSupport::Concerns`

When there are multiple models that need to so a singular thing, such as generating a token, then it should be put into a concern. Then the code will be located in only one place.

```ruby
# lib/tokenable.rb - though I think this is now outdated
# app/models/concerns/tokenable.rb - probably the place to put this stuff now

module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :generate_token
  end

  private

  def generate_token
    self.token = SecureRandom.urlsafe_base64
  end
end
```

So taking all the token code and putting it into a model. now in the model...
```ruby
class Todo < ActiveRecord::Base
  include Tokenable
end
```

Also need to load the `lib` directory (again, for Rails 3).

```ruby
require_relative '../../lib/tokenable'

class Todo < ActiveRecord::Base
  include Tokenable
end
```

Can also place it in the `app/models` folder.

Or go to the `config/application.rb` file and say.
```ruby
config.autoload_paths << "#{Rails.root}/lib"
```

Then remove the `require_relative` code from the model.

## Read [DHH's Blog](https://signalvnoise.com/writers/dhh)
about using ActiveSupport::Concerns

## Lesson: Email Service Providers

Clear limitations to using your Gmail to send emails. Only up to ~2000 per day or so, and other limits.

Should offload this duty to a 3rd party mailer.

#### Recommended Simple Email Services (SES)
**Mailgun** and **Postmark**

When you consider vendors, opt for deliverability instead of just sending.

Read [this](https://www.quora.com/Why-are-Mailgun-and-Postmark-so-much-more-expensive-than-SendGrid-AWS-SES-and-Pepipost), especially the replies from mailgun and postmark founders.

## Lesson: [Mailgun](https://www.mailgun.com/)
### Now recommend using [sendinblue](https://www.sendinblue.com) for this app instead of Mailgun.
Use [this](https://github.com/mailin-api/sendinblue-ruby-gem/issues/6) as a template.

Mailgun as an email service provider.

Built for developers with very powerful APIs that is very low level. Built for tweaking with lots of options.

**Major Features**
* Transaction emails
* optimize for deliverability
* supports receiving emails
  * specify an email address to listen to
  * mailgun can preprocesses and parse out the different parts of the email and send to application for processing
* supports campaign emails for tracking/analytics etc

**Integrating Mailgun into server (Heroku)**
There is an [add-on](https://elements.heroku.com/addons/mailgun) for heroku
Start playing with the free plan, upgrade when necessary.

Sign in to heroku account, go to add-on and add to app.
Then just read the docs and change the gmail configuration to the heroku configuration. The variables will be set by heroku automatically.

Heroku supports two modes of delivering emails, SMTP and HTTP.
Rails action mailer helps prepare for SMTP.
If sending via HTTP, no need to rely on Rails to prepare it for you. You can use RestClient to send an HTTP post containing the email information.

## Lesson: Background Jobs
```ruby
def create
  if ...
    AppMailer.notify_on_new_todo(current_user, @todo).deliver
    ...
  else
    ...
  end
end
```

Typically email sending is not fast because you have to rely on 3rd party service. This holds up the application from the user's point of view. Nothing can proceed until the email is sent.

In some cases, email sending doesn't have to happen synchronously. We can offload this email sending to a **background process**.

Typically a server has:
* 1 or more web processes - handle incoming requests
* 1 or more background processes - handle incoming requests

requests -->        web processes
                    web processes

background jobs --> background worker processes
                    background worker processes

Each web process has its own instance of Rails to handle request and generate response.
We can offload from web process to background jobs.
**Background jobs** is a queue of items added from the web processes. Items will be worked one-by-one.

So web requests/processes can now be very fast and time consuming operations like sending emails can be processed at a later time through background worker processes.

## Lesson: Resque and Sidekiq
Two popular background jobs frameworks

Here is [an article](https://github.com/blog/542-introducing-resque) by github explaining the history of background jobs and why resque was a better solution at the time.

Also watch this [Rails Cast](http://railscasts.com/episodes/271-resque) about Resque, Redis, and background jobs in general.


[Sidekiq](http://sidekiq.org/) ([source](https://github.com/mperham/sidekiq)) is a newer, higher performance solution to background jobs. It is compatible with Resque.
Watch this [Rails Cast](http://railscasts.com/episodes/366-sidekiq) about Sidekiq.

## Lesson: Sidekiq in action

Take this code from the todos app.
```ruby
def create
  if ...
    AppMailer.notify_on_new_todo(current_user, @todo).deliver
    ...
  else
    ...
  end
end
```

1. Install the sidekiq gem
```ruby
# Gemfile
gem 'sidekiq'
```

2. Use sidekiq to process the job of sending email.
```ruby
def create
  if ...
    AppMailer.delay.notify_on_new_todo(current_user, @todo)
    ...
  else
    ...
  end
end
```

3. For testing, use the "Testing Workers Inline" ability of sidekiq.
```ruby
# spec_helper.rb

require 'sidekiq/testing/inline'
```

So the `delay` makes in work asynchronously during development/production and now it will work inline during testing.

Since these notes, Sidekiq has changed its API. View [this doc](https://github.com/mperham/sidekiq/wiki/Testing) for updated code.

**Note: A bit further explanation on background jobs and Sidekiq:**

*How come Sidekiq needs Redis? How does Redis fit into the picture?*

Sidekiq (and Resque, for that matter) needs to retain a job queue so that the jobs that are queued first will be run first. Redis is used to maintain that queue. You could, of course, use something else to do this, such as a database (that’s what delayed_job does https://github.com/collectiveidea/delayed_job), where you essentially add records to a db table to maintain the queue. Redis as a key-value store is much simpler than a full fledged database, and that's why Sidekiq has picked it to store its job queue.

*Why it's not a good idea to pass Ruby objects directly to Sidekiq?*

The reason you don’t want to pass Ruby objects directly into sidekiq jobs is that your job processor could be on a different server than your web app. In fact, your Rails App, Sidekiq workers and the Redis can run on 3 different servers - If you run on Heroku, for examples, your “dynos” (web dyno and worker dynos) may very likely run on different EC2 servers (Heroku uses Amazon EC2 under the cover). And if you use a Redis plugin provider like redis-to-go, that itself runs on a different server. Whenever you are sending data across servers, you want to keep your data in a way that’s easily serializable - you can't send Ruby objects directly over the wire, you can only send string representation of objects. The simplest would be integers or strings. You could, of course, host your own server and run all 3 on the same server, but it’s good to keep that flexibility in mind.

## Lesson: Procfile and Foreman

Use Procfile and Foreman to manage processes

[Heroku and Procfile](https://devcenter.heroku.com/articles/procfile)

On production server we need to start redis, sidekiq, and rails servers. We want to do all this with heroku automatically.

The default Rails server is done using:
```bash
web: bundle exec rails server -p $PORT
```

For the worker process using **delayedJobs** you would need this:
```bash
worker: bundle exec rake jobs:work
```

For **Sidekiq** do this:
```bash
<process type>: <command>
```

For us it will be this:
```bash
worker: sidekiq
```

In total, our Procfile will look like:
```bash
web: bundle exec rails server -p $PORT
worker: sidekiq
```

Then push to Heroku and it will automatically start the two proceesses defined. I suspect the redis server will need to be started as well...


**Foreman** is used to do all of this locally.
```bash
foreman start
```

This way the local development environment will load the same processes of the production environment.

```bash
heroku ps
```

Will tell you all the processes currently running on the heroku server.

```bash
heroku logs
```
Will give the logs from both the web and worker processes.

## Lesson: Riding Unicorns

Use unicorn as production server. A very popular alternative Rails server.

By default, Rails will handle one request at a time, unicorn solves this. Can start multiple instances of the Rails server.

[Heroku and Unicorn](https://devcenter.heroku.com/articles/rails-unicorn)

To use unicorn as server:

```ruby
gem 'unicorn'
```

Copy on configuration file from the web site linked above into `config/unicorn.rb`:

```ruby
# config/unicorn.rb
worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 15
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
```

`worker_processes` - how many Rails instances to start with unicorn. This says it'll look at the environment variable first, or 3
The doc explains a lot of the config file.

Now to use it in the Procfile:
```bash
web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
```

This includes the unicorn configuration file.

## Set up production server

Install Redis-To-Go on Heroku for the app.

Note: Sidekiq 3.0 have since removed bulit-in support for redis-to-go. If you are using Sidekiq 3.0 or above (you can tell by doing a bundle exec gem list), you need to run this line to set the environment variable on your production server:

`heroku config:set REDIS_PROVIDER=REDISTOGO_URL`

Note 2: If you use the [hack we mentioned in the video](https://coderwall.com/p/fprnhg/free-background-jobs-on-heroku), you can just use 1 dyno, therefore you can remove the line for the worker process in your Procfile, so you won't be charged. What happens here is that instead letting Foreman to start both Unicorn and Sidekiq processes, each taking a dyno, now you are only starting a Unicorn process and Unicorn supports forking processes and can start a Sidekiq process itself.


## Understand staging server and production server

[Tutorial](https://devcenter.heroku.com/articles/multiple-environments) on why a staging server is needed and how to set it up with Heroku (focus on the explanations and don't follow the steps here).

A few things I'd like to add:

1) Make staging server's configuration and data as close to the production server as possible - after all, the purpose of having the staging server is to be able to test out new features in a "production like" environment.

If your production app is already launched, you can periodically take database dumps from the production server to populate the staging server. You could automate this as well with either a replication service, or if you are on Heroku, use Heroku's follower DB (comes with a cost) https://devcenter.heroku.com/articles/heroku-postgres-follower-databases

2) You want to be mindful on email sending on staging - staging server will actually send out emails. You want to make sure that you do not spam your users while testing out features on the staging server. This can be achieved by adding a conditional in your mailer to see if the environment is staging, and if it is, set email recipients to administrators (such as yourself). This way, you can still test and verify that emails are sent out, but you don't spam users.

3) Your staging server can (and typically should) have a different config itself - you just need to create a `staging.rb` file in `config/environments` directory, and with it you can specify the exact settings you want on there (for example, turning on asset pipeline or not, sending out email or not, charging credit card for real or not, etc). On your Heroku staging server, make sure to set `RACK_ENV` and `RAILS_ENV` to `staging`, then it'll use that config instead. For Heroku specifically, you also need to add the `rails_12factor` gem to the staging environment for the asset pipeline to work on Heroku.


## Understand and set up a simple deployment pipeline

Read this article: http://martinfowler.com/bliki/DeploymentPipeline.html

Deployment pipelines can become very complex - typically the larger the project is and the more teams are involved, the more complicated the automatic deployment process is. For our purpose, we are going to adopt a simple but effective deployment pipeline for solo dev or small team situations.

1) Follow the Github Flow process, and after you complete a feature, merge the pull request back to the master branch.

2) Run your entire test suite. This is very important and you should always do this before pushing code to Github. The master branch should always have working code. Developers call this "don't break the build".

3) Deploy your code to the staging environment and test on your staging server manually to make sure that the new feature works. Again, your staging server should be as close to your production server as possible.

4) Deploy code to production. You want to deploy code to production as often as possible to get feedback as fast as possible. If something breaks, it's much easier to fix it with your mind still fresh with the feature you worked on. In some teams this step is out of your control and there are strict production deployment times. In that situation you'd go back to step 1 and build your next feature.

When you deploy to the staging server or the production server, effectively what you are doing is to push code from your local master branch to the corresponding Heroku server's master branch.

Why is it important to also push/deploy from your local master branch? The problem with deploying from a feature branch is that you miss the step of integration with other developers. For example, while you work on your feature, I might have push out my feature as well. If you deploy from your branch even if it does work you didn’t test if your feature would integrate with the feature that I just deployed, AFTER you branched off. By forcing everyone to integrate with master first, now every time you push, you HAVE to integrate with everyone else’s push at that moment. If someone pushed code after you branched off, this would force you to do a pull first on master, then integrate with it, otherwise you can’t push.

Note that you should never deploy to production before you go back home or go to sleep. Make sure you can be around your computer for some time to fix anything that could happen after a production deploy. Your error monitoring app will alert you with emails if they do happen.

In summary, our simple deployment pipeline process is `run entire test suite locally -> deploy to staging and test -> deploy to production`. This is probably good enough for solo developers or small teams. We'll talk about Continuous Integration and Continuous Deployment with more automation in the next several topics.


## Set up production error monitoring

Regardless how well we have tested our application, there will always be errors on the production server. To get notified of production errors so you can respond to them, you need to set up an error monitoring service on production.

Go ahead and install Sentry from here: https://getsentry.com/welcome/. There's a trial plan that you can use.

You also need to install the "sentry-raven" gem in your app: https://github.com/getsentry/raven-ruby


## Continuous Integration
By this time, you should be aware and comfortable with automated tests and the benefits. Up until now, we're relying on developer's discipline to always ensure tests pass locally before they deploy features. This is probably ok in small and high-trust teams, but in larger teams you typically see Continuous Integration (CI) introduced as part of the development process.

In his article on [Continuous Integration](http://martinfowler.com/articles/continuousIntegration.html), Martin Fowler defines continuous integration as:

> Continuous Integration is a software development practice where members of a team integrate their work frequently, usually each person integrates at least daily - leading to multiple integrations per day.

The problem that CI solves is to **force** integration on a regular basis. For example, you may have just finished a feature on `my_feature` branch and have had all the tests pass locally. You open a PR and your fellow coworkers are happy with the way the code looks. Github shows the PR can be automatically merged without conflict - so you do that, merge it back to the `master` branch and ready to deploy the feature!

The danger of this workflow is that while you are working on your feature, someone else could have just finished their feature and pushed to the master branch to Github, and your new feature never integrated with this new piece of code.

A Continuous Integration solution would watch your repository and force integration (running the entire test suite on the CI server) whenever necessary.

Once we have our CI server set up to monitor our repository, it'll pull the latest code and run the entire test suite every time we push code to any branch on Github (when you work with a CI server, you want to make sure that every push should always make the tests pass) and notify you on the results. The CI server also runs every time we merge our pull request to the `master branch` to ensure integration.

A CI server helps us catch integration errors before they reach production, and the earlier we catch errors, the less costly we can fix them.

A CI solution doesn't eliminate the necessity to run your tests locally - your will lose friends quickly if you constantly push code that "breaks the build" and have everyone notified. However, in cases of long running test suites, it is acceptable to run only the tests pertaining to the new feature built, and have the CI server to run the entire test suite to catch any potential regression. Most modern CI services allow you to run the tests in parallel (with a paid plan, typically) so it could run your tests several times faster.


## Set Up Continuous Integration with Circle CI
[Circle CI](https://circleci.com/) is a popular Continuous Integration service. Setting up your project with Circle CI is pretty simple - link and authorize your Github account, then add the repository that you want to enable CI. By default, Circle CI runs on every push and PR merge.

Since Circle will run your tests, make sure that you set up necessary environment variables there too.


## Continuous Delivery
**Continuous Delivery** (CD) or sometimes known as **Continuous Deployment** goes one step beyond CI to automatically deploy features when the new code passes the continuous integration phase. Continuous Delivery encourages small and incremental software updates over big and infrequent releases to shorten the feedback loop and fix bugs earlier.

Let's look at an example development workflow that has both CI and CD enabled, based on the Github Flow process:

* we pull the latest code from Github
* we create a new feature branch and develop a new feature
* after we finish the feature, we push it to a branch with the same name on Github
* we create a PR from this branch to the `staging` branch.
* we wait for the the CI server to ensure all tests pass.
* we allow the CI server to automatically deploy the code from the `staging` branch to our staging server
* we perform sanity tests on our staging server
* we create a PR from the `staging` branch to the `master` branch on Github
* this will trigger another round of integration and if it passes, the CI server will automatically deploy the code to the production server.

If adopted by everyone in the development team, this process will make sure our master branch is always in sync with the production server and new features are also always build on top of what's on the production server.


## Assignment: Set up Continuous Delivery with Circle CI
For this assignment, you are going to enable Continuous Delivery with Circle CI.

Here are the steps:

* create a `staging` branch locally if you don't have it yet.
* in Circle CI, follow `Project settings` for your project and select `Heroku Deployment` under Continuous Deployment
* configure the Heroku API key. (Get it from your [Heroku account page](https://dashboard.heroku.com/account))
* associate Heroku SSH key with your Circle account so Circle can have the authority to deploy to Heroku on your behalf.
* create a `circle.yml` file in your projects root directory and make sure your adjust `production_app_name` & `staging_app_name` to your own app name.

Here is an example of a `circle.yml` file that you can use:

```yml
machine:
  ruby:
    version: 2.1.5
deployment:
  production:
    branch: master
    commands:
      - git fetch --unshallow
      - heroku maintenance:on --app production_app_name
      - heroku pg:backups capture --app production_app_name
      - git push git@heroku.com:production_app_name.git $CIRCLE_SHA1:refs/heads/master
      - heroku run rake db:migrate --app production_app_name
      - heroku maintenance:off --app production_app_name
  staging:
    branch: staging
    commands:
      - git fetch --unshallow
      - heroku maintenance:on --app staging_app_name
      - git push git@heroku.com:staging_app_name.git $CIRCLE_SHA1:refs/heads/master
      - heroku run rake db:migrate --app staging_app_name
      - heroku maintenance:off --app staging_app_name
```

Note: you should change the Ruby version to the version you're using for this project.

This code should be pretty self explanatory - this allows Circle to monitor your `staging` branch and deploy to the staging server, and monitor your `master` branch to deploy to the production server. It'll run migrations for you and for the production server, it also automatically backs up the database before a deploy.

#### Notifications Options
By default we will be notified by email on every status change of our builds. But receiving an email every time a build fails or passes is cumbersome and there are also good alternatives.

For Mac users - there is a free application CCMenu by ThoughtWorks which we install and it will stick to our upper bar. In order to make it fully run - we will need to generate a CircleCI API key (Project settings -> API keys) and http address of build. See the setup info guide here. A great feature of this app is that it can play sounds based on build's status and we are able to customize it to our needs.

For Chrome users - there is an addon called [CircleCI Monitor](https://chrome.google.com/webstore/detail/circleci-monitor/pkdkfaokllclembpkggkndfejdhcpmpk) that takes a couple of seconds to install and works out of the box.

Another great feature most CIs offer are [Embedded Status Badges](https://circleci.com/docs/status-badges). These are especially useful for open source projects. They look nice in a project's README and also help to provide information about whether the current build is passing or failing.
