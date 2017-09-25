console.log(foo());

function foo() {
  console.log('Waiting for bar!');
}

function foo() {
  console.log(foo);
  function bar() {
    console.log('bar again');
  }

  bar();

  function bar() {
    console.log('bar again and again');
  }
}

// function foo() {
//   console.log('Waiting for bar!');
// }
//
// function foo() {
//   function bar() {
//     console.log('bar again');
//   }
//
//   function bar() {
//     console.log('bar again and again');
//   }
//
//   console.log(foo);
//
//   bar();
//
// }
//
// console.log(foo());
