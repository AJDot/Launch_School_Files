# Lesson 3
## Setting Up the Project Directory
First, name the directory. Choose a name consisting of only letter, digits, and underscores. __No spaces in directory name or any of its parent or grandparent directories__. Very strange bugs may occur if there are spaces.

Your project should be a git repository. Make sure it is not contained within another git repository.

### What is a Project?
As a loose definition, a project is a collection of one or more files used to develop, test, build, and distribute software. The software may be executable, a library module, or a combination. It includes the source code, tests, assets, HTML files, databases, configuration files, and more.

There are some standards that are followed among Ruby-based projects. The most common is the Rubygems standard.

### Walkthrough: Setting Up Your Project
1. Create remote github repository.
2. Setup local repository and create initial commit.
3. Ruby source files typically are located in the `lib` folder.
4. Ruby test files are typically located in the `test` folder.
5. The subfolder `assets` will typically contain `images`, `javascript`, and `stylesheets`.
6. HTML "template" files are usually in the `views` directory.

## Setting Up the Gemfile
A `Gemfile` needs four main pieces of info:
* Where should Bundler look for Rubygems it needs to install?
* Do you needs a `.gemspec` file?
* What version of Ruby does your program need?
* What Rubygems does your program use?

## Preparing a Rubygem

We have already been using the Rubygems layout (see Setting Up Your Project).

To prepare your project for distribution, do the following:
* Read the [Rubygems](http://guides.rubygems.org/) documentation.
* Prepare any additional directories that you need.
* Prepare a README.md file.
* Write documentation if necessary.
* Prepare your `.gemspec` file. Note that the actual `.gemspec` file has a name like `project.gemspec`, where "project" is your project name. See below for an example `.gemspec`.
* Add a `gemspec` statement to your `Gemfile`.
  ```ruby
  gemspec
  ```
* Modify your `Rakefile` to include the standard Rubygem tasks. See below.

### A Simple .gemspec
For our Todo List Manager project:
```ruby
Gem::Specification.new do |s|
end
```
Name this `todolist_project.gemspec`.

### Modify Rakefile
add `require "bundler/gem_tasks"` near the top of the `Rakefile`. This adds several tasks, including:
* `rake build`: Constructs a `.gem` file in the `pkg` directory. This contains the actual Rubygem to distribute.
* `rake release`: Send your `.gem` file to the remote Rubygems library for the world to download.

## Summary
* Rubygems are libraries of code you can run inside your own Ruby programs.
* Rubygems allows you to release your own Gems. These are either `require`d into your Ruby programs or are independent Ruby programs (like `bundle` from the Bundler gem).
* Ruby projects usually use the Rubygems format.
* Ruby Version Managers help you manage multiple versions of Ruby on a single system. Each has its own set of tools (like `gem` and `bundle`).
* Bundler provides tools to describe dependencies for Ruby programs. It even ensures that corrects versions of gems are used.
* Rake provides a way to easily manage and run repetitive tasks.
* `.gemspec` file provides info about a Gem. Need this to release a program or library as a Gem.