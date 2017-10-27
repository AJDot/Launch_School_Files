# Core Tools/Packaging Code
There are 4 main tools we will use to package code into a distributable project.
* Rubygems
* RVM and Rbenv
* Bundler
* Rake


## Purpose of Core Tools
### Rubygems
Gems are packages of code you can download, install and use in your Ruby programs or from the command line. Gems can do many things; for example, rubocop, pry, sequel, and rails are all Gems used to make life a bit easier.

Each version of Ruby has its own set of Gems.

### Ruby Version Managers
RVM and Rbenv are the two main managers. Managers let you install, manage, and use multiple versions of Ruby. This is useful when a program requires a specific version of Ruby and you do not want to uninstall your current version just to run it. As features get added or removed from Ruby, previously made programs may not run correctly on the newer versions. 

Version managers allow you to easily manage each version of Ruby, the utilities (like irb), and their corresponding set of Gems.

### Bundler
Bundler solves the problem of project dependencies. It is a dependency manager. It lets you describe exactly which Ruby and Gems you want to use with your Ruby apps. I lets you install multiple versions of each Gem under a specific version of Ruby and __then use the proper version in your app__.



### Rake
Rake is a RubyGem used to automate many common functinos required to build, test, package, and install programs. Some common Rake tasks are:
* Set up required environment by creatign directories and files
* Set up and initialize databases
* Run tests
* Package your application and all of its files for distribution
* Install the application
* Perform common Git tasks
* Rebuild certain files and directories (assets) basd on chagnes to other files and directories

### Summary (Copied straight from LS)
Your Ruby Version Manager is at the top level -- it controls multiple installations of Ruby and all the other tools.

Within each installation of Ruby, you can have multiple Gems -- even 1000s of Gems if you want. Each Gem becomes accessible to the Ruby version under which it is installed. If you want to run a Gem in multiple versions of Ruby, you need to install it in all of the versions you want to use it with.

Each Gem in a Ruby installation can itself have multiple versions. This frequently occurs naturally as you install updated Gems, but can also be a requirement; sometimes you just need a specific version of a Gem for one project, but want to use another version for your other projects.

Ruby projects are programs and libraries that make use of Ruby as the primary development language. Each Ruby project is typically designed to use a specific version (or versions) of Ruby, and may also use a variety of different Gems.

The Bundler program is itself a Gem that is used to manage the Gem dependencies of your projects. That is, it determines and controls the Ruby version and Gems that your project uses, and attempts to ensure that the proper items are installed and used when you run the program.

## Gemfiles