var myObject = {
  myMethod: function() {
    console.log("myMethod");
  }
};

function myFunction() {
  console.log("myFunction");
}

// Method Invocation
myObject.myMethod();

// Function Invocation
myFunction()

// Also Function Invocation
var myFunctionWasMethod = myObject.myMethod;
myFunctionWasMethod();
