# What is a project?
A project is the group of files that make up an entire application. These are files used in development, testing, construction, and distribution of the application. Examples of projects are software applications, modules, gems, and essentially anything else that can be organized into one cohesive unit.


Main ruby files should be kept in the `lib` folder.
Test file should be kep in the `test` folder.

Configure a `Gemfile` with the following information:
* if you need a `.gemspec` file

Run `bundle install` to create the `Gemfile.lock` file and install all project dependencies.
