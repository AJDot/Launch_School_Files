# Take-Home Project Q & A

##### Describe the general structure of the project.

Focusing on the JavaScript, the project consists of 5 key objects, `Todo`, `Todos`, `Form`, `DisplayData`, `App`. `Todos` holds the list of every `Todo` and contains behaviors related to list operations like finding, creating, updating, deleting, etc. a `Todo`. A `Todo` contains mainly the unique state of a task (title, dueDate, complete status, etc.). A `Todo` can mark itself as complete and can update itself but that's about it.

There is one `Form` object which is just a collection of methods used to interact with the modal form for adding/updating a `Todo`. With it you can show or hide the form, populate it with data from a `Todo`, and retrieve the data on the form.

The `DisplayData` object handles updating the information displayed to the user. A list of properties in this object are used in the Handlebars templates when the entire page is updated. Anytime information on the page needs to be updated, this object handles it.

The `App` object is the controller; it handles all the events and delegates tasks to the other objects I described. When a list item is clicked, the `App` utilizes the `Form` object to load its information. When a list in the navigation is clicked, the `DisplayData` object is utilized to fetch the `Todos` sublist for that category and update the entire page.

---

##### Describe the process you used to create the project.
I first tasks I had was to decide what my main structure was going to be - what main objects I was going to need. I started with just `Todo` objects that would be maintained in a list in a `Todos` object as well as the `App` object. I didn't have the `DisplayData` or `Form` objects initially.

I took the suggestion in the problem description and focused first on the `main` section of the page. This immediately required me to redesign the HTML structure a bit to make working with the form easier. I started with the few events I knew I was going to need, `processForm`, `showForm`, `hideForm`, `markComplete`, `toggleComplete`, etc. This outlined the basic features I was going to implement. I focused on each of them one at a time, working slowly and abstracting code to methods along the way. The `main` section was fairly easy for me to implement.

The navigation area is where I needed to focus most of my effort. The initial design of the project required me to update each section of the display independently. This turned out to be confusing and hard to keep track of every detail in every section. I eventually resorted to creating a `DisplayData` object that held all of the dynamic information on the page. Then, whenever page information was changed, I would update the `DisplayData` object then rewrite the entire page. The app was small enough that I didn't need to worry about performance. If there were 1000s of elements to update, I likely would have taken a different approach.

So I split the HTML into templates, a main template and several partial templates that would be used to build the lists in each section of the app. This worked very well; all the page information was organized well in the `DisplayData` object so I didn't have to worry about which part of the page to update, just update all of it.

---

##### What challenges did you face and how did you overcome them?
Maybe trivial, but one of the biggest struggles I had was keeping the `active` information current after every action. Since the page was being recreated every time, the CSS that highlights the active information/list was lost. In the end I stored the title of the selected list on the `DisplayData` object. Then every time I update the list in the main area, I would use the title of that list to find the corresponding list in the navigation on the left and apply the appropriate CSS to it.

Certainly another of my struggles was figuring out a nice was to set the list to display in the main area. There were 4 different avenues for choosing how a list was to be selected - all todos, all todos of a month, all completed todos, all completed todo of a month. I got bogged down in determining the factors that could control which route to take. It boiled down to two variables, a due date and a completed status. I employed a little bit of cleverness by making the "dueDate" for `All Todos` and `Completed` equal to their titles - not actual due dates. But this did allow me reduce the needed variable from 3 to 2. Every navigation list item and their headings have a `data-title` attribute that determines if the clicked item has a due date - indicating a particular month was clicked - or is a section heading. A similar and simpler process was used to determine if all todos or only completed todos should be selected. Then, thanks to the 5 methods starting with `set` in the `DisplayData` object, all I had to do was update the `selectedTitle`, `dueDate`, and `completed` properties. The `setSelected` method then used this info to pick to right sublist.

---

##### What do you like / did you enjoy the most about this project?

Hmm... Well, what I'm about to say isn't specific to this project but all of programming. In fact, I think it runs much deeper than that. I enjoy that feeling when everything starts to click into place. For this project, it was when I realize that I should update the entire page every time a change was made, which led me to create the `DisplayData` object. Once I had a centralized location for everything dealing with the output, the project went much faster and smoother than before.

In hindsight this is something that may have been realized during the planning phase of the app. In any case, it is the moment when you can stop squinting to in order to see the project. From that point on, developing is more or less straight forward.

Implementing a new feature was now streamlined. For example, "How do I make sure that the title and the todos count is always up-to-date and reflects the current list?" Answer: every time a list is selected or a change to a list is made, recalculate the current title and count. How can I make sure the active list is always highlighted? Answer: again, keep track of its title on the display object whenever a change is made.

In short, I think I like the way the project is structured. It's very clear to me which objects handle which tasks. I know where to look for something and I would know where to place the next new feature. Need to sort list items? The `Todos` object should be able to sort its own list. Then update the `DisplayData` object to display the sorted list. Need to add categories to a `Todo`. A `Todo` object should be able to hold the information. `Todos` can sort, group, retrieve, a list dealing with each category. Then `DisplayData` can display the new information.

Oh, and refactoring. I really like to do it.

---

##### What do you not like / did you not enjoy about this project?

One specific implementation comes to mind; I don't like the way I binded the events. Every time I create an event listener I first remove any event listeners of that type from the element. This is of course to prevent duplicate event listeners from piling up on an element. I couldn't find a better way to solve this. I thought, because the entire page is being updated, there are some elements that will be destroyed and recreated, meaning I need to rebind some events. However, other events remain intact but I would need to make sure that listener is removed before it is added after rewriting the page.

In general though, I don't like that "lost" feeling. This is the feeling I get when the code starts to pull away from me and get out of hand. This occurred when I focused my attention on the left navigation area. Suddenly I went from the feeling of completing a task to the feeling of having too many tasks. The todos needed to be grouped by month, the months needed to be sorted, then groups again by their completed status. The counts needed to always be current. The current selection needed to be displayed and highlighted.

What do I work on first? Second? I tend to stick with one task at a time but as I develop it I get sidetracked as thoughts about the other features pop into my head. Soon enough it's like I'm working on all the features at once which is a nightmare. The only fix I have found for this is to step away. Go cook, clean, watch something, do anything to get my mind off of the code. It's a way to "unload" the project from my head. Then when I return the project is "loaded" back into my head, but this process isn't incremental and allows me to narrow my focus before I get overloaded again.

---
