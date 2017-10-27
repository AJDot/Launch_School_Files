# Deploying Sinatra Applications

## Summary
We deployed thte book viewer application to Heroku
1. `Procfile` defines what types of processes are provided by the application and how to start them.
2. `config.ru` tells the web server how to start the application. In this project, we require the file that contains the Sinatra application and then start it.
3. While WEBrick is a fine web server for development, it is better to use a production-ready web server such as Puma when deploying a project.
4. Puma is a threaded web server, which means that it can handle more than one request at a time using a single process. As a result, Puma will perform much better for most applications.
5. A specific version of Ruby can be specified in the `Gemfile` to ensure that the same version is used in both development and production.