# What is the difference between methods declared with a `helpers` block and those defined at the top level in a classic Sinatra application?



The general rule followed in the course is this:

As Brandon said, where code lives becomes more important in larger frameworks and projects. Larger Sinatra applications will often use a class-based style (called the "modular style" within the Sinatra documentation). When a class-based structure is used, no methods are declared at the top level, making the purpose of using helpers more obvious.