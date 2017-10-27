# Gems
## What are Gems?
__RubyGems__, often just called __Gems__ are packages of code you can download, install and use in Ruby program or on the command line.
Some examples of gems are:
* `rubocop`: checks for Ruby style guide violations and other potential issues.
* `pry`: helps debug Ruby programs
* `sequel`: provides a set of classes and methods that simplify database access
* `rails`: provide a web application framework that simplifies and speeds web applications development

## Gems, Ruby, and your Computer
After `gem install`, where does the install go? How does Ruby find the install? What about multiple versions of gems?

### The Remote Library
The main RubyGems Libraris where most of your gems come from. When you type `gem install GEM_NAME`, the `gem` program will look to the main site for the gem.

### The Local Library

### Gems and Your File System
To find a gem, start by running `gem env`. This prints a list of info about RubyGems.

__RUBY VERSION__
The version of Ruby you ran the command with. Each Ruby version has its own `gem` command.

__RUBY EXECUTABLE__
The location of the `ruby` command tha tyou should use with the Gems managed by this `gem` command.

__INSTALLATION DIRECTORY__
The default install location for Gems. This varies depending on Ruby version number and whether a version manager is being used.

Looking in this directory you can see the structure/subdirectories where all Gems are located along with their version numbers.

__USER INSTALLATION DIRECTORY__
You may install Gems somehwere in your home directory instead of a system-level directory. This is that location.

__EXECUTABLE INSTALLATION DIRECTORY__
Some Gems have commands that can be used directly from a terminal prompt. `gem` puts those in this directory. `bundler` and `rubocop` executables are usually located in the `bin` subdirectory. Note that this directory needs to be included in your shell `PATH` variable so the shell can find these commands.

__REMOTE SOURCES__
The remote library used by this `gem` installation.

__SHELL PATH__
A list of directories in your shell path. This is a good diagnostic when you see `command not found` messages or the wrong version of something is used.