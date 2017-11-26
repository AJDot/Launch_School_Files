I spent a significant amount of time working on this project. My initial focus was on the functionality, then I refactored, then I focused on the usability.

Relevant to this course in particular, here are some features I intended to hit:

* Utilize some kind of object creation pattern for the contacts. I went with the pseudo-classical pattern. With this I do have a question:

  You will see that the prototype object for `Contact` is set to an new object literal as opposed to assigning methods one-by-one.

  ```javascript
  Contact.prototype = {
    update: function(data) {
      // ...
    },

    hasTag: function(tag) {
      // ...
    },
  }

  // vs.

  Contact.prototype.update = function(data) {
    // ...
  };

  Contact.prototype.hasTag = function(tag) {
    // ...
  };
  ```

  Is there a downfall to doing the first option?

* The list of contacts are stored in localStorage.
* I tried to separate intentions between `Contact`, `Contacts`, `Tags`, and `App`. The `App` handles the events, manipulates the DOM, and delegates tasks to the `Contacts` and `Tags` objects.
* The code became very modular when I tried to separate intentions as well as when I tried to make the app more robust. I found on many occasions that I needed to break up a method into smaller pieces so that I could reuse some of them in other locations or limit their use based on when/where the method was being used. In short, I feel like I may have too many methods which may make the code unreadable because a developer has to juggle many methods in their head as he/she works through the code.
* The above being said, I did what I could to name methods appropriately - a task I find difficult most days.

Here are some app features:
* Add and edit contacts should work without a problem.
* Contacts and tags are always sorted alphabetically (this also means that `10` will come before `2` if used as tags.)
* Search by name with find a person if the first name, last name, or full name starts with the user's query (case-insensitive).
* Clicking on a tag name, whether on a contact or on the top tag bar, will filter contacts that have that tag.
* The tag filtering logic is "OR" based (not "AND"), meaning if multiple tags are selected for filtering, then any contact that has any tag selected will remain visible.
* Tag filtering and name filtering can be used together, though there are some bugs in certain situations.
* When a tag is no longer present on any contact then the tag itself will be removed from the app.
* Tags can be added to a contact through the form by either clicking on a tag from the tag list and/or by entering a comma-separated list.
* Duplicate and blank tags on the add/edit form are ignored.
* There is minimal form validation.

* **Note:** When the app is loaded, if no contacts are found then several example contacts will be added. This is the `data` at the bottom of the `manager.js` file.


Please take a look and let me know what you think.
