# Twitter API
## Reading Documentation
Collection information:
* What *protocol*, *host*, and *path* will provide access to appropriate resource?
* What parameters do I need to include in the request?
* Is authentication required?

[official Twitter API documentation](https://dev.twitter.com/rest/public).

## Gaining Access
Trying making a request using Postman. Twitter API requires authentication using the OAuth protocol and Postman supports this.

## What is OAuth?
Complicated. Provides a way for users to grant access to third party applications without revealing their credentials. The result of this process is the user is given an *access token* and an *access token secret* which when combined with an *application key* and *application secret* belonging to the requesting application, provide enough information to build a request using a somewhat involved list of steps.

*application key* and *application secret* are like the applications username and password. The *access token* and *access token secret* are like the username and password belonging to an individual user. This can be a lot of work for a developer to implement, though libraries exist to ease the pain.

Twitter provides an *access token* and *access token secret* for development purposes, thankfully.

## Setting up a Twitter Application
Setup a Twitter Account.
Register the Twitter Application via the [Application Management page on Twitter](https://apps.twitter.com/).
Change the permissions to be *Read and Write*.
Generate an access token for the current user (which is you). Our access is through this user. This also implies applications can perform actions on behalf of users.
Input the *Consumer Key* (API key), *Consumer Secret (API Secret)*, *Access Token*, and *Access Token Secret* into Postman.
Verify by sending request to `https://api.twitter.com/1.1/account/verify_credentials.json`

## Fetching a Tweet
Make request to `https://api.twitter.com/1.1/statuses/show.json?id=20`

## Posting a Tweet
Use POST to create new resource (tweet in this case). [POST statuses/update](https://developer.twitter.com/en/docs/tweets/post-and-engage/api-reference/post-statuses-update)
* A URL of https://api.twitter.com/1.1/statuses/update.json
* A status parameter, which is the text of the tweet.
* The HTTP method POST since this is creating a new resource.

Use *x-www-form-urlencoded* for the body so the parameters will be included in the request body and encoded as if they were query parameters.

## Twitter API and REST
Twitter API is successful in that thousands of apps use it but it doesn't quite follow REST. It's less RESTful because:
* It only uses GET and POST instead of the full range of HTTP methods. This makes the API less expressive.
* As a result, resource paths include actions that are being performed on them.

| Objective | HTTP Method | Path | Improved HTTP Method | Improved Path |
| --- | --- | --- | --- | --- |
| Fetch a single status | GET | /statuses/show/:id | GET | /statuses/:id |
| Create a status | POST | /statuses/update | POST | /statuses |
| Delete a status | POST | /statuses/destroy/:id | DELETE | /statuses/:id |
