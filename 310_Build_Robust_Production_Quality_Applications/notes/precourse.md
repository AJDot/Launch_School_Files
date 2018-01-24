# Pre-course
## The Process of Going from Ideas to Products

1. Idea
2. Wireframes - use a tool like balsamic or moqups.
  - purpose is communication with others and yourself
  - don't over-design it, only for quickly putting a concept together
  - likely have several versions/iterations of a wireframe
3. Design
  - do it yourself or get a designer
  - layouts
  - colors
  - look & feel
  - typically done in photoshop -> .psd files
4. Slicing - .psd -> mockups (pixel perfect translation)
  - HTML
  - CSS
5. Development

## The Design to Development Handoff
Essentially, create a main page with a bunch of links to display each page mockup.

## Build Actual Views from Mockups
It's basically copying the mockup html with dummy data and changing it line by line to work with the right data.
Because the mockups were created already, the styles should just work.

## Seeding Data
Quickly populate database with records to play with application.

The seeds file is located at `db/seeds.rb`. Use Rails ActiveRecord methods to create data just as you would in the controllers.

Run `rake db:seed` to run the code in the seed file.
