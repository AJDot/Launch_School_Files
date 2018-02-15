# Deploying to Heroku

make sure you're using Ruby 2.0.0 and that it's specified in the Gemfile. If you forgot, revisit this: https://launchschool.com/lessons/2e912916/assignments/7b9b71eb
if you're following along with the below video, you may end up with the wrong Heroku stack. We need the older "cedar-14" stack to work with Ruby 2.0.0, but the latest Heroku stack is "heroku-16".
after you follow the instructions in the video, issue heroku info to see what stack you're using. If it says "heroku-16", you can change the stack with the following command: heroku stack:set cedar-14. After that, you should be able to git push heroku master and deploy your app.

1. Download the Heroku Toolbelt.
2. Go to Heroku.com and register.
3. Issue "heroku login" to authenticate, with the credentials from previous step. Make sure it's a git repository, by issuing "git init", and also "git add", "git commit" your files.
4. Then "heroku create" to create this app on heroku. This command also adds a "heroku" remote repository that you can push to.
5. To deploy, issue "git push heroku master".
6. You may need to run migrations on heroku afterwards, with "heroku run rake db:migrate".
7. Other helpful heroku commands:
  * heroku logs
  * heroku logs -t
  * heroku rename
  * heroku restart
  * heroku run console
  * heroku help
