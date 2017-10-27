# Ruby Version Managers
These are programs that let you install, manage, and use multiple versions of Ruby.

RVM and rbenv are the two major version managers. 

## How RVM Works
A typical file structure with 2 versions of Ruby.
```
$ tree /usr/local/rvm        # the following is partial output
/usr/local/rvm               # RVM path directory
├── gems
│   ├── ruby-2.2.4
│   │   ├── bin
│   │   │   ├── bundle
│   │   │   └── rubocop
│   │   └── gems
│   │       ├── bundler-1.12.5
│   │       ├── freewill-1.0.0
│   │       │   └── lib
│   │       │       └── freewill.rb
│   │       ├── pry-0.10.4
│   │       └── rubocop-0.43.1
│   └── ruby-2.3.1
│       ├── bin
│       │   ├── bundle
│       │   └── rubocop
│       └── gems
│           ├── bundler-1.12.5
│           ├── freewill-1.0.0
│           │   └── lib
│           │       └── freewill.rb
│           ├── pry-0.10.4
│           └── rubocop-0.45.0
└── rubies
    ├── ruby-2.2.4
    │   └── bin
    │       ├── gem
    │       ├── irb
    │       └── ruby
    └── ruby-2.3.1
        └── bin
            ├── gem
            ├── irb
            └── ruby
```
When you use `rvm use VERSION` to change the version of Ruby you use, the `rvm` function is invoked. It modifies your environment so teh correct Ruby and Gems are used.

### Installing Rubies
Use `rvm install VERSION`.

### Setting Local Rubies
Use `rvm use VERSION`. Usually though you will define a default version, and then override the default when needed. To do this use `rvm use VERSION --default`. If you get off the default, use `rvm use default` to get back.


## When Thing Go Wrong
The following is copied straight from Launch School

Here are some useful troubleshooting hints and commands:

* Make sure your directory name does not include any spaces, and none of its ancestors (parents, grandparents, etc) do either. RVM does not currently support directory names with spaces.


* `type cd | head -1 ; type rvm | head -1`

  Use this command to verify that you are using the cd and rvm functions, not the built-in cd command nor the executable file rvm. These commands should print:

  ```
  cd is a function
  rvm is a function
  ```


  ```
  $ source "{RVM PATH}"/scripts/rvm"
  ```
  (`{RVM PATH}` is the name of your RVM path.) This command should be near the end of the file, after any commands that set or modify your PATH variable or replace built-in commands with functions. If you must change the file, start a new terminal session after making the changes, then close any previously open terminal sessions.
  
* `echo $PATH`

  Confirm that the `{RVM PATH}/rubies-{VERSION}/bin` and `{RVM PATH}/gem/rubies-{VERSION}/bin` directories are present in your `PATH`, and listed before any other directories that may contain programs with the same name. If, for example, `/usr/bin` occurs before `{RVM_PATH}/rubies-{VERSION}/bin` in your `PATH`, your system may load the system version of Ruby instead of one managed by RVM.

* `rvm info`

  Displays a longish list of information about the current RVM environment. Similar to `gem env` in the information provided, but formatted differently, and includes RVM-specific information.

* `rvm current`


* `rvm fix-permissions`

Repairs the permissions on RVM files. This may be useful if you accidentally use `sudo` to install, modify or update RVM, or any of its rubies or Gems. If you see "permission denied" messages on any of these files, try running this command.

* `rvm repair all`

  Repairs files that help RVM manage the different rubies. This may be useful if RVM seems completely broken in areas.

* `rvm get latest`

  Download and install the latest version of RVM. This is most useful when you are using a new or unfamiliar feature that may not be available or working correctly in your current version of RVM

* `gem env`
  
  Display configuration information about your RubyGems system.

* `gem list`

  Displays a list of all Gems installed for the current Ruby, along with their version numbers. For instance:

  ```
  $ gem list
  bundler (1.12.5)
  freewill (1.1.1, 1.0.0)
  pry (0.10.4)
  rubocop (0.43.1)
  ```
  
  Note how this shows two different versions for the `freewill` Gem, which means that both versions are installed and available. If you switch to another Ruby version, the output will be different:

  ```
  $ rvm use 2.1.5
  bundler (1.12.2)
  pry (0.10.1)
  rubocop (0.35.1)
  ```
  
  Here, all of the Gem versions have changed, and the lack of an entry for `freewill` shows that it is not installed for this Ruby.

* https://rvm.io/support/troubleshooting

  Read the official troubleshooting information for RVM.

