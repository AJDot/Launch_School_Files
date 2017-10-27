# What is the SEAT Approach?

__S__ etup  

This is where you setup the objects and methods to be used in all of the tests. For example, if every time you want to test you need to make and object from a custom class and add some items to a list, then do this is the setup.

This is accomplished by creating a `setup` method and placing setup code there. This method will be executed before every test.

__E__ xecute

This is where additional code is executed before the assertion is made to verify the code. Any additional setup/preparations for the assertion is done at this time.

This code is inside a test method but before the intended assertion.

__A__ ssert


__T__ eardown

Create a `teardown` method and place any code in it that you need to run after every test. It is the complement to the `setup` method. Reasons to use a `teardown` method may be to close up database connections, close files,  log information, etc.