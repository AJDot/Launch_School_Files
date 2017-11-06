# Stop Propagation 2
Click on an element. Click event listeners are setup for everything but the paragraphs. In the first group, stopPropagation is not invoked. In the second, it is invoked. Notice which events are fired when InnerInner is clicked vs. when InnerInner2 is clicked.
```html
<!doctype html>
<html lang="en-US">
  <head>
    <title></title>
    <style>
      div, p {
        padding: 10px;
        border: 2px dotted black;
      }

      th, td {
        width: 200px;
      }
    </style>
  </head>
  <body>
    <p>Click on an element. Click event listeners are setup for everything but the paragraphs. In the first group, stopPropagation is not invoked. In the second, it is invoked. Notice which events are fired when InnerInner is clicked vs. when InnerInner2 is clicked.</p>
    <h2>Without stopPropagation()</h2>
    <div class="outer">
      Outer
      <div class="inner">
        Inner
        <div class="innerinner">
          InnerInner
          <p class="paragraph">
            Paragraph
          </p>
        </div>
      </div>
    </div>

    <h2>With stopPropagation()</h2>
    <div class="outer2">
      Outer2
      <div class="inner2">
        Inner2
        <div class="innerinner2">
          InnerInner2
          <p class="paragraph2">
            Paragraph2
          </p>
        </div>
      </div>
    </div>
    <table>
      <thead>
        <tr>
          <th>currentTarget</th>
          <th>target</th>
        </tr>
      </thead>
      <tbody>
      </tbody>
    </table>
    <script>
      function makeAddInfo(stop) {
        return function(event) {
          addInfo(event, stop);
        }
      }

      function addInfo(event, stop) {
        if (stop) {
          event.stopPropagation();
        }

        var tbody = document.querySelector("tbody");
        var tr = document.createElement("tr");
        tr.innerHTML = "<td>" + event.currentTarget.firstChild.nodeValue + "</td>" +
                       "<td>" + event.target.firstChild.nodeValue        + "</td>";
        tbody.appendChild(tr);
        console.log(event.currentTarget);
      }

      document.addEventListener("DOMContentLoaded", function() {
        var outer = document.querySelector(".outer");
        var inner = document.querySelector(".inner");
        var innerinner = document.querySelector(".innerinner");

        var outer2 = document.querySelector(".outer2");
        var inner2 = document.querySelector(".inner2");
        var innerinner2 = document.querySelector(".innerinner2");

        var infoWithoutStopProp = makeAddInfo()
        var infoWithStopProp = makeAddInfo(true);

        outer.addEventListener("click", infoWithoutStopProp);
        inner.addEventListener("click", infoWithoutStopProp);
        innerinner.addEventListener("click", infoWithoutStopProp);

        outer2.addEventListener("click", infoWithStopProp);
        inner2.addEventListener("click", infoWithStopProp);
        innerinner2.addEventListener("click", infoWithStopProp);
      });
    </script>
  </body>
</html>
```
