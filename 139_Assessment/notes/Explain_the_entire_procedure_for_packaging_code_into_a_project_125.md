# Explain the entire procedure for packaging code into a project.

There are numerous paths one might take to package code into a project

1. Create a Github repository for the project.


2. Place key files in these locations.
    * `lib`: ruby source files
    * `test`: test code
    * `assets/images`: images
    * `assets/javascript`: JavaScript
    * `assets/stylesheets`: CSS
    * `views`: HTML "template" files


3. Create a Gemfile to keep track of project dependencies. This file should include:
    * Where should Bundler look for Rubygems it needs to install?
    * Do you need a `.gemspec` file?
    * What version of Ruby does your program need? (Recommended, not required)
    * What Rubygems does your program use?


4. Run `bundle install` to find and install all project dependencies. This creates a `Gemfile.lock` that contains all the dependency information for your app. Run this command again if the `Gemfile` is updated.






7. Use `bundle exec rake <task>` to run a task from the `Rakefile`. Many processes can be automated using Rake such as testing, create file structures, listing all project files, etc.


8. Follow all the rules for preparing a Rubygems gem.


9. One of those rules is to create a `.gemspec` file which details several bits of information about the project: name, version, summary, description, authors, email, homepage, files.


10. Add `require "bundler/gem_tasks"` to the top of the `Rakefile`. This defines the following tasks:
    * `rake build`
    * `rake install`
    * `rake release`
