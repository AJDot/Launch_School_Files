# Deploying Sinatra Applications

## Configuring an Application for Deployment

In this assignment, we will create a few files in the project and modify a few settings to define how the project will be served once it is deployed.

Pry doesn't work with Heroku out of the box. If you have any calls to binding.pry within your application files, then they should be removed before running your application on Heroku.
Prevent the application from reloading in production by adding if development? to the line that requires sinatra/reloader:

```ruby
require "sinatra/reloader" if development?
```

Sinatra provides development? and production? methods whose return values are determined by the current value of the RACK_ENV environment variable. This environment variable is set automatically to "production" by Heroku, so when the application is running in production, production? will return true and development? will return false.

Specify a Ruby version in Gemfile so that Heroku knows the exact version of Ruby to use when serving the project:

```ruby
ruby "2.2.3"
```
If you don't do this, you will see an error similar to this one when you push to Heroku:

```
remote: ###### WARNING:
remote:        You have not declared a Ruby version in your Gemfile.
remote:        To set your Ruby version add this line to your Gemfile:
remote:        ruby '2.0.0'
remote:        # See https://devcenter.heroku.com/articles/ruby-versions for more information.
```
Configure your application to use a production web server.

We've been using WEBrick for local development, but in production it is better to use a different Ruby server. Read this article in the Heroku documentation to learn why, and then add puma to the project's Gemfile:

```ruby
group :production do
  gem "puma"
end
```
Always run bundle install after making changes to a project's Gemfile. This will install any new dependencies and help detect potential deployment issues as early as possible.
Create a config.ru file in the root of the project that tells the web server, which in this case will be Puma, how to start the application:

```ruby
require "./book_viewer"
run Sinatra::Application
```
Create a file called Procfile in the root of the project with the following contents:

```
web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
```
For larger applications it is recommended to use a separate config file for Puma instead of providing its configuration inline as we are doing here. This article in the Heroku documentation goes into more details. For this project, though, the simpler approach will be fine.

If you don't do this, you will see an error similar to this one when you push to Heroku:

```
remote: ###### WARNING:
remote:        No Procfile detected, using the default web server (webrick)
remote:        https://devcenter.heroku.com/articles/ruby-default-web-server
```
A project's Procfile determines what processes should be started when the application boots up. Read more about Procfiles in the Heroku documentation.

Test your Procfile locally

Use the heroku local command to boot the project locally in the same way that it will be once it's pushed to Heroku. This provides an opportunity to troubleshoot problems in your local development environment.

You should see output like this:

```
$ heroku local
forego | starting web.1 on port 5000
web.1  | Puma starting in single mode...
web.1  | * Listening on tcp://0.0.0.0:5000
web.1  | Use Ctrl-C to stop
```
The first time you run heroku local, it will download and install a compiled copy of forego, which is a program that runs Procfile-compatible applications. This only happens once, and should only take a few moments.

You may also see a warning message that says: "[WARN] No ENV file found" on certain operating systems. Your app should still work without the .env file. And this warning message can safely be ignored. The .env file is used to set environment variables for local testing of your application. If you want to get rid of the warning, you can always create a .env file within your project directory.
You should be able to visit the application at localhost:5000 and test it out. If everything appears to be working, you can proceed with the next step: deploying to Heroku.

## Creating a Heroku Application

Now that the application is running locally using the production configuration, it is time to deploy it to a remote server. We'll be using Heroku for this assignment.

1. Create a Heroku application using `heroku apps:create $NAME`, where `$NAME` is the application name you wish to use. If you don't provide this value, Heroku will generate a random application name for you.

```
$ heroku apps:create ls-170-book-viewer
Creating ls-170-book-viewer... done, stack is cedar-14
https://ls-170-book-viewer.herokuapp.com/ | https://git.heroku.com/ls-170-book-viewer.git
Git remote heroku added
```
You have probably already seen the command heroku create $NAME in some Heroku articles. heroku create is an alias for the command heroku apps:create which we use above.
Push the project to the new Heroku application using git push heroku master:

```
$ git push heroku master
Counting objects: 152, done.
Delta compression using up to 12 threads.
Compressing objects: 100% (148/148), done.
Writing objects: 100% (152/152), 93.86 KiB | 0 bytes/s, done.
Total 152 (delta 80), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote:
remote: -----> Ruby app detected
remote: -----> Compiling Ruby/Rack
remote: -----> Using Ruby version: ruby-2.2.3
remote: -----> Installing dependencies using bundler 1.9.7
remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
remote:        Fetching gem metadata from https://rubygems.org/..........
remote:        Fetching version metadata from https://rubygems.org/..
remote:        Installing multi_json 1.11.2
remote:        Installing erubis 2.7.0
remote:        Installing backports 3.6.6
remote:        Installing tilt 2.0.1
remote:        Using bundler 1.9.7
remote:        Installing rack 1.6.4
remote:        Installing rack-test 0.6.3
remote:        Installing rack-protection 1.5.3
remote:        Installing puma 2.15.3
remote:        Installing sinatra 1.4.6
remote:        Installing sinatra-contrib 1.4.6
remote:        Bundle complete! 4 Gemfile dependencies, 11 gems now installed.
remote:        Gems in the groups development and test were not installed.
remote:        Bundled gems are installed into ./vendor/bundle.
remote:        Bundle completed (3.95s)
remote:        Cleaning up the bundler cache.
remote:
remote: -----> Discovering process types
remote:        Procfile declares types     -> web
remote:        Default types for buildpack -> console, rake
remote:
remote: -----> Compressing... done, 17.5MB
remote: -----> Launching... done, v4
remote:        https://ls-170-book-viewer.herokuapp.com/ deployed to Heroku
remote:
remote: Verifying deploy... done.
To https://git.heroku.com/ls-170-book-viewer.git
 * [new branch]      master -> master
```
Heroku only looks at the master branch of a repository when processing a git push. This means that you must push the code you want to be run on Heroku to the remote master branch, regardless of what branch it is in locally.

If you have been working in a branch, you can push that branch to Heroku by specifying its name when pushing:

$ git push heroku local-branch-name:master
Otherwise, you can merge your changes into your local master branch and push using git push heroku master.
Visit your application and verify that everything is working.

Recall that we are expecting Heroku to automatically set the RACK_ENV environment variable to "production". To see how this works, run heroku config in the book viewer's directory after deploying to Heroku:

```
$ heroku config
=== ls-170-book-viewer Config Vars
LANG:     en_US.UTF-8
RACK_ENV: production
```
While adding a default value for RACK_ENV is a special feature of Heroku, everything else about how this value is set or provided to applications is the same as it is for any other environment variable. Environment variables are often used to provide API keys and other secret values to applications without including them in the application's source code.

## Summary
We deployed thte book viewer application to Heroku
1. `Procfile` defines what types of processes are provided by the application and how to start them.
2. `config.ru` tells the web server how to start the application. In this project, we require the file that contains the Sinatra application and then start it.
3. While WEBrick is a fine web server for development, it is better to use a production-ready web server such as Puma when deploying a project.
4. Puma is a threaded web server, which means that it can handle more than one request at a time using a single process. As a result, Puma will perform much better for most applications.
5. A specific version of Ruby can be specified in the `Gemfile` to ensure that the same version is used in both development and production.
