# What is Cross-Site Scripting and how do we prevent it?
Cross-Site Scripting (XSS) is when users are allowed to enter HTML or JavaScript that ends up being displayed directly by the site. Essentially this is allowing a user to inject code into your program, potentially giving access to sensitive data or damaging your application.

How to prevent it:


* Escape all user input when displaying it. In this way the browser will not interpret user inputs as code to be executed.