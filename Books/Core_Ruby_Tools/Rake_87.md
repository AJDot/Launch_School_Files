# Rake
## What is Rake?

Common Rake tasks:
* Set up required environment by creating directories and files
* Set up and initalize databases
* Run tests
* Package your application and all of it files for distribution
* Install the application
* Perform common Git tasks
* Rebuild certain files and directories (assets) based on changes to other files and directories

It is used to automate just about anything during the development, testing, and release cycles.

## How Do You Use Rake?
Rake use a file called `Rakefile` in your project directory. It describes tasks that Rake can do for your project. Example file:
```ruby
task :hello do
  puts "Hello there. This is the `hello` task."
end

task :bye do
end

task :default => [:hello, :bye]
```
3 tasks are in this file
* first two are named `:hello` and `:bye`

Each task has a `desc` and a `task`. `desc` method is a short description Rake display when it runs the task using `rake -T`. `task` associates a name with either a Ruby block of code (lines 2-4 and 7-9) or a list of dependencies (line 11).
```bash
$ bundle exec rake -T
rake bye      # Say goodbye
rake default  # Do everything
rake hello    # Say hello
```
Use `bundle exec` when invoking `rake`. 

## Why Do I Need Rake?
For one, nearly every Ruby project has a `Rakefile` which means you need to use `Rake` if you want to work on that project. So many tasks can be automated to save time and frustration. To release a new version of an existing program, you may want to:
* Run all tests associated with the program.
* Increment the version number.
* Create your release notes. 
* Make a complete backup of your local repo.

Four main things to note when using `Rake`:
* Use `bundle exec rake` instead of `rake` whenever you work on a project that uses Bundler.
* `bundle exec rake -T` displays a list of all tasks associated with your `Rakefile`.
* the task name and description statement are listed by this command.
* Remember, `bundle exec` is used just to make sure the Bundler environment is used with any code run from `Rakefile`.