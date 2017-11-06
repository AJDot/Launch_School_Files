# Partial Function Application
```javascript
function makePushLog(list) {
  return function(item) {
    list.push(item);
    console.log(item + " was pushed to the list.");
    return item;
  }
}

var awesomeList = [];
var awesomeListPushLog = makePushLog(awesomeList);

awesomeListPushLog(1);
awesomeListPushLog(2);
awesomeListPushLog(3);
awesomeListPushLog(4);
awesomeListPushLog([1, 2, 3, 4, 5]);
```

```javascript
function partial(primary, arg1) {
  return function(arg2) {
    return primary(arg1, arg2);
  };
}

function add(a, b) {
  return a + b;
}

function pushLog(list, item) {
  list.push(item);
  console.log(item + " was pushed to the list.");
  return item;
}

var awesomeList = [];

var add1 = partial(add, 1);
console.log(add1(10));
var awesomePushLog = partial(pushLog, awesomeList);
awesomePushLog(15);
```
