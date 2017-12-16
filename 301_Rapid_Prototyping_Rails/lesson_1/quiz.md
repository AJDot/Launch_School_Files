# Quiz: Lesson 1

### Why do they call it a relational database?

A relational database is used to connect two or more entities together through natural links. For example, a relational database may contain `people` and `accounts` and may setup a relationship that allows people to be linked to accounts.

### What is SQL?

Structure Query Language. A declarative language used to access and manipulate data in a database.

### There are two predominant views into a relational database. What are they, and how are they different?

The two main views are the schema and the data.
The schema describe the structure of the database. It describes the tables and their columns along with any constraints and relationships through foreign keys.
The data view is looking at the actual data in the tables. Data can have many types including text, string, number, datetime, and more.

### In a table, what do we call the column that serves as the main identifier for a row of data? We're looking for the general database term, not the column name.

Primary key.

### What is a foreign key, and how is it used?

A foreign key is a value that links two relations together. It will be stored in one table and its value will be a value from the primary key column of another table. This key will link a row from one table with a row from another.

### At a high level, describe the ActiveRecord pattern. This has nothing to do with Rails, but the actual pattern that ActiveRecord uses to perform its ORM duties.

ActiveRecord is an object relational mapper (ORM) which is design to have each object represent one row of data in a table. With this one-to-one matching, actions such as creating, deleting, updating, etc. an object is simplified to interacting with a single row of data in the database. Of course, more complicated structures may exist, but even these are greatly simplified using the ORM pattern.

### If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?

`crazy_monkeys`. This was found by executing `"CrazyMonkey".tableize` in the rails console. This returns what rails will use as the table name for the given class name.

### If I'm building a 1:M association between Project and Issue, what will the model associations and foreign key be?

```ruby
class Project < ActiveRecord::Base
  has_many :issues
end

class Issue < ActiveRecord::Base
  belongs_to :project
end
```
A project has many issues and an issue belongs to a project. The foreign key will be `project_id` and this column will be stored on the `issues` table.

### Given this code

```ruby
class Zoo < ActiveRecord::Base
  has_many :animals
end
```

#### What do you expect the other model to be and what does database schema look like?

```ruby
class Animal < ActiveRecord::Base
  belongs_to :zoo
end
```
The will also need to be a foreign key column in the `animals` table called `zoo_id`.

#### What are the methods that are now available to a zoo to call related to animals?

```ruby
Zoo.animals
Zoo.animals.first
Zoo.animals.last
Zoo.animals << animal
Zoo.animals.find(id)
Zoo.animals.where(property: "value")
```

#### How do I create an animal called "jumpster" in a zoo called "San Diego Zoo"?

```ruby
zoo = Zoo.create(name: "San Diego Zoo");
zoo.create_animal(name: "jumpster");
# OR
zoo = Zoo.create(name: "San Diego Zoo");
animal = Animal.create(name: "jumpster")
zoo.animals << animal
# OR
zoo = Zoo.create(name: "San Diego Zoo");
animal = Animal.create(name: "jumpster")
animal.zoo = zoo;
```

### What is mass assignment? What's the non-mass assignment way of setting values?

Mass assignment is simply assigning more than one property to an object at a time. At the database level it is filling out more than one column of a table row at once.

### Suppose Animal is an ActiveRecord model. What does this code do? Animal.first

This will retrieve the first record in the `animals` table in the database and return it as an object.

### If I have a table called "animals" with a column called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe". Which methods makes sure it saves to the database?

```ruby
Animal.new(name: "Joe")
Animal.save
# OR
Animal.create(name: "Joe")
```

### How does a M:M association work at the database level?

To relate two tables with a M:M relationship a third table, often called a join table must be created. Each row in this table will store a foreign key from each of the two tables.

### What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?

```ruby
class Zoo < ActiveRecord::Base
  has_and_belongs_to_many :animals
end
# OR
class Zoo < ActiveRecord::Base
  has_many :zoo_animals
  has_many :animals, through: :zoo_animals
end
```
In the HABTM format, a join table is not created in the database. The joining of `zoos` and `animals` is done behind the scenes by rails.
In the HMT format, a separate join table must be created in the database and explicitly linked using the `through:` property.

The HABTM provides no way to attached additional attributes to the relationship since there is no table to attached them to. This method is only useful is we know for sure that we will never need additional attributes.
The HMT method allows use to maintain the join table ourselves so it is more flexible. The only problem I see is having to maintain this additional code.

### Suppose we have a User model and a Group model, and we have a M:M association all set up. How do we associate the two?

I partially wrote one out above for Zoos and Animals but here it is.

```ruby
class User < ActiveRecord::Base
  has_many :user_groups
  has_many :groups, through: :user_groups
end

class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group
end

class Group < ActiveRecord::Base
  has_many :user_groups
  has_many :users, through: :user_groups
end
```

## LS Solution
### Why do they call it a relational database?

We call it a relational database, because the tables within the database are associated with each other. This association can be created with primary/foreign keys and various syntax.

### What is SQL?

SQL stands for "Structured Query Language" and it is used to manage the operations of a relational database.

### There are two predominant views into a relational database. What are they, and how are they different?

The two predominant views are the data and schema views. Data view displays like a spreadsheet, with the table columns at the top and rows of data per each object instance.

A schema view shows us the column names and the value type of each column.

### In a table, what do we call the column that serves as the main identifier for a row of data? We're looking for the general database term, not the column name.

We call this the "primary key".

### What is a foreign key, and how is it used?

A foreign key is the identifier that connects an association with the models involved. The foreign key is always on the "many" side and is always in an integer type.

### At a high level, describe the ActiveRecord pattern. This has nothing to do with Rails, but the actual pattern that ActiveRecord uses to perform its ORM duties.

ActiveRecord is a way to access the database. A database table is related to a class. An object of that class is created as a row in the table. This object can have different attribute values shown as the columns in the table. We can create, retrieve, update, and delete the object instances by altering the database table.

### If there's an ActiveRecord model called "CrazyMonkey", what should the table name be?

By Rails convention, the table name should be "crazy_monkeys" by using `"CrazyMonkey".tableize`.

### If I'm building a 1:M association between `Project` and `Issue`, what will the model associations and foreign key be?

In the `Project` model:
```ruby
class Project < ActiveRecord::Base
  has_many :issues, foreign_key: :project_id
end
```
In the `Issue` model:

```ruby
class Issue < ActiveRecord::Base
  belongs_to :project, foreign_key: :project_id
end
```
The foreign key will be `project_id`.

### Given this code

```ruby
class Zoo
  has_many :animals
end
```
##### What do you expect the other model to be and what does database schema look like?

The Animal model:

```ruby
class Animal
  belongs_to :zoo
end
```
The database schema will have tables named:
```
- `zoos` table with a primary key of `id`
- `animals` table with a primary key of `id` and foreign key of `zoo_id`
```
##### What are the methods that are now available to a zoo to call related to animals?
```
- `zoo.animals` will return all a list of all of the animals.
- `zoo.animals.first` will return the first row of data in the `animals` table.
```
You can also iterate through the list of a zoo's animals and display certain properties of the animals.

##### How do I create an animal called "jumpster" in a zoo called "San Diego Zoo"?

In the Rails console, enter the following commands:

```
zoo = Zoo.create(name: 'San Diego Zoo')         # => Sets the primary id of 1 for San Diego Zoo
animal = Animal.create(name: 'jumpster', zoo_id: 1)
```

### What is mass assignment? What's the non-mass assignment way of setting values?

Mass assignment allows us to assign multiple values to attributes with only a single assignment operator.

Mass assignment:

```
Post.new(title: 'My first post', topic: 'Life')
Post.create(title: 'My first post', topic: 'Life')
```
Non-mass assignment:

```
post = Post.new
post.title = 'My first post'
post.topic = 'Life'
```

### What does this code do? Animal.first

This will return the first row of data for the first Animal instance object in the animals table.

### If I have a table called "animals" with columns called "name", and a model called Animal, how do I instantiate an animal object with name set to "Joe". Which methods makes sure it saves to the database?

```
animal = Animal.create(name: 'Joe')         # => Using "create" will hit the database and automatically saves it.
```
```
animal = Animal.new(name: 'Joe')            # => Using "new" will require you to use the save method afterwards to save it to the database.
animal.save
```
### How does a M:M association work at the database level?

On the database level of a M:M association, we use a join table to support it. Both of the primary models will each have a 1:M association with the join table.

By using the has_many :through technique, we are able to create an indirect M:M association with the two primary models.

### What are the two ways to support a M:M association at the ActiveRecord model level? Pros and cons of each approach?

The two ways to support a M:M association are the has_many :through and has_and_belongs_to_many methods.

has_many :through requires an explicit join model and a join table, but it is more flexible and we can add additional attributes to the join table.

has_and_belongs_to_many doesn't require a join model but still requires a join table, but it is less flexible and we cannot add additional attributes to the join table.

Note: always use has many :through, as has_and_belongs_to_many will be deprecated in the future.

### Suppose we have a User model and a Group model, and we have a M:M association all set up. How do we associate the two?

We will need to use a join model(UserGroup) and table(user_groups) in this situation.

The User model:

```ruby
class User < ActiveRecord::Base
    has_many :user_groups, foreign_key: :user_id
    has_many :groups, through: :user_groups
end
```
The User_Group model:

```ruby
class UserGroup < ActiveRecord::Base
    belongs_to :user, foreign_key: :user_id
    belongs_to :group, foreign_key: :group_id
end
```
The Group model:

```ruby
class Group < ActiveRecord::Base
    has_many :user_groups, foreign_key: :group_id
    has_many :users, through: :user_groups
end
```
