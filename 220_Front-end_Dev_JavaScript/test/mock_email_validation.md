# Mock Email Validation

This code checks for a valid email address after every `keyup` event on the input. Styles and a little behavior is changed accordingly if the address is valid or not.

Once the form is submitted, a confirmation is displayed.
#### HTML
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title></title>
  </head>
  <body>
    <form action="#" method="post" novalidate>
      <h2>Newsletter Sign Up</h2>
      <fieldset>
        <label for="email">Enter your email address:</label>
        <input type="email" name="email" value="" placeholder="example@domain.com" />
        <input type="submit" value="Sign Up" disabled />
      </fieldset>
    </form>
  </body>
</html>
```
#### CSS
```css
body {
  font: normal 14px sans-serif;
}
form {
  width: 400px;
  border: 5px solid #5298DA;
  border-radius: 10px;
}

form h2 {
  font: normal 16px sans-serif;
  padding: 5px 20px;
  margin: 0;
  background: #5298DA;
  text-align: center;
}

form h3 {
  font: inherit;
  font-weight: bold;
  text-align: center;
}

p {
  text-align: center;
}

fieldset {
  padding: 10px 20px;
  border: none;
}

label {
  display: block;
  font-weight: bold;
  margin: 0 0 10px 0;
  color: #333333;
}

input {
  font: inherit;
  padding: 10px;
  margin: 0 0 10px 0;
  border: none;
  outline: none;
}

[type="email"] {
  width: 80%;
  border: 2px solid #333333;
}

input[type="submit"] {
  display: block;
  color: white;
  background: linear-gradient(to bottom, lightgreen, green);
  border-radius: 10px;
  cursor: pointer;
}

.error {
  border-color: #dd3333;
}

input[disabled] {
  opacity: .5;
  cursor: default;
}
```
#### JS
```javascript
function validEmail(email) {
  // A quick put-together to validate email
  return /^[^@]+@[^@.]+\.[^@.]+/.test(email);
}

function validateEmail(event) {
  var target = event.target;
  var submit = document.querySelector('[type="submit"]');

  if (validEmail(target.value)) {
    // Remove CSS to signify an error
    target.classList.remove("error");
    // Remove "disabled" attribute to allow the form to be submitted.
    submit.removeAttribute("disabled");
  } else {
    // Add CSS to indicate an error in input
    target.classList.add("error");
    // Disable the submit input so the form cannot be submitted.
    submit.setAttribute("disabled", "");
  }
}

function displaySubmitSuccess(event) {
  event.preventDefault();
  var target = event.target;
  var fieldset = document.querySelector("fieldset");
  result = "<h3>Thank you for signing up!</h3>" +
           "<p>You are the 5,678th person to sign up.";
  fieldset.innerHTML = result;
}

document.addEventListener("DOMContentLoaded", function() {
  var emailInput = document.querySelector('[type="email"]');
  emailInput.addEventListener("keyup", validateEmail);

  var submit = document.querySelector('[type="submit"]');
  submit.addEventListener("click", displaySubmitSuccess);
});
```
