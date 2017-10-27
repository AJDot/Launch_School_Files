# When to Use Validations?

If the bad data comes from a form the user filled out incorrectly, then handle the error. The validation should provide a way for the user to correct the mistakes, such as redisplaying the form.

You do not want to check for something that can only happen if there is a bug in your code. In this case, if there is a bug you should find it and fix it.

Keep in mind what an error message to the user should say. Saying something like, "The array is empty!", will not help the user as they do not know what an array may be. Saying something like, "No items were found.", may make more sense.