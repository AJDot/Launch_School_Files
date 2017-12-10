document.addEventListener('DOMContentLoaded', function() {
  var OPS = ["+", "-", "*", "/", "^"];
  var CLICKABLE = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0",
                   "+", "-", "*", "/", "^", ".", "Enter", "Backspace"];

  function inList(list) {
    var items = [].slice.call(arguments, 1);
    return items.every(function(item) {
      return list.indexOf(item) !== -1;
    })
  }

  function hasDecimal(item) {
    if (item) { return item.match(/\./); }
  }

  function hasDigits(item) {
    if (item) { return item.match(/\d+/); }
  }

  function sPop(string) {
    return string.slice(0, -1);
  }

  function last(list) {
    return list[list.length - 1];
  }

  function clickClass(element, className) {
    element.classList.add(className);
    setTimeout(function() {
      element.classList.remove(className);
    }, 1000);
  }

  function Stack() {
    this.stack = [];
  }

  Stack.prototype = {
    constructor: Stack,

    popDigitOfLast: function() {
      var lastIndex = this.stack.length - 1;
      this.stack[lastIndex] = this.last().slice(0, -1);
    },

    appendToLast: function(item) {
      this.stack[this.stack.length - 1] = this.last() + item;
      return item;
    },

    pop: function() {
      return this.stack.pop();
    },

    push: function(item) {
      return this.stack.push(item);
    },

    last: function() {
      var lastIndex = this.stack.length - 1;
      if (lastIndex < 0) { return; }
      return this.stack[lastIndex];
    },

    hasOp: function() {
      return this.stack.some(function(item) {
        return inList(OPS, item);
      });
    },

    has: function(item) {
      return this.stack.indexOf(item) !== -1;
    },

    splice: function(start, deleteCount) {
      var additions = [].slice.call(arguments, 2);
      return this.stack.splice.apply(this.stack, [start, deleteCount].concat(additions));
    },

    getOpParams: function(op) {
      var index = this.stack.findIndex(function(token) {
        return token === op;
      });

      var num1 = parseFloat(this.stack[index - 1], 10);
      var num2 = parseFloat(this.stack[index + 1], 10);

      return { index: index, num1: num1, num2: num2 };

    }
  }

  var Calculator = {
    calc: document.querySelector('.calculator'),
    input: document.querySelector('.input'),
    display: document.querySelector('.display'),
    stack: new Stack(),
    last: null,

    processClick: function(e) {
      e.preventDefault();
      var target = e.target;

      if (target.tagName === 'BUTTON') {
        var id = target.getAttribute('data-id');

        switch (id) {
          case "Enter":
            // if last in stack is OP, ignore it.
            if (inList(OPS, this.stack.last())) { this.stack.pop(); }

            this.calculate();
            this.writeAnswer();
            clickClass(target, 'click');
            break;

          case "Clear":
            // if stack is already empty, show error
            if (!this.stack.last()) {
              clickClass(target, 'click-error');
              return;
            }

            this.reset();
            clickClass(target, 'click');
            break;

          case "Backspace":
            if (hasDigits(this.stack.last())) {
              this.stack.popDigitOfLast();
              if (this.stack.last() === "") { this.stack.pop(); }
              this.removeLastInput();
              clickClass(target, 'click');
            } else if (inList(OPS, this.stack.last())) {
              this.stack.pop();
              this.removeLastInput();
              clickClass(target, 'click');
            } else {
              clickClass(target, 'click-error');
            }
            break;

          default:
            this.addToStack(target);
            break;
        }

        this.moveCursorToEnd(this);

      }
    },

    addToStack: function(button) {
      var content = button.textContent;
      var id = button.getAttribute('data-id');
      if (id === "^") { content = id };

      // ignore OP or '.' if it is the first entry
      if (!this.stack.last() && (inList(OPS, id) || id === '.')) {
        clickClass(button, 'click-error');
        return;
      }

      // ignore '.' if last is OP or '.'
      if (id === '.' &&
         (hasDecimal(this.stack.last()) || inList(OPS, this.stack.last()))) {
        clickClass(button, 'click-error');
        return;
      }

      if (inList(OPS, id, this.stack.last())) {
        // OP is the same as last, don't do anything.
        if (id === this.stack.last()) {
          clickClass(button, 'click-error');
          return;
        }
        // if current is OP and last was OP, replace last
        this.input.textContent = sPop(this.input.textContent) + content;
        this.stack.pop();
        this.stack.push(id);
      } else if (!inList(OPS, id) && hasDigits(this.stack.last())) {
        // if last exists and is a number (and not an OP)
        // then current is another digit of number, append it
        this.appendToInput(content);
        this.stack.appendToLast(id);
      } else {
        // if current is a number
        // or an OP coming after a number
        this.appendToInput(content);
        this.stack.push(id);
      }

      clickClass(button, 'click');
    },

    calculate: function() {
      var data, result;

      while (this.stack.hasOp()) {
        if (this.stack.has("^")) {
          data = this.stack.getOpParams('^');
          result = Math.pow(data.num1, data.num2);
        } else if (this.stack.has('*') || this.stack.has('/')) {
          if (this.stack.has('/')) {
            data = this.stack.getOpParams('/');
            result = data.num1 / data.num2;
          } else { // multiply
            data = this.stack.getOpParams('*');
            result = data.num1 * data.num2;
          }
        } else if (this.stack.has('-')) { // subtract
            data = this.stack.getOpParams('-');
          result = data.num1 - data.num2;
        } else { // add
            data = this.stack.getOpParams('+');
          result = data.num1 + data.num2;
        }
        this.stack.splice(data.index - 1, 3, result);


      }

      this.answer = this.stack.pop();
      this.reset();
    },

    reset: function() {
      this.stack = new Stack();
      this.input.textContent = "";
    },

    removeLastInput: function() {
      this.input.textContent = this.input.textContent.slice(0, -1);
    },

    appendToInput: function(item) {
      this.input.textContent += item;
    },

    writeAnswer: function() {
      this.display.textContent = this.answer;
    },

    processKeydown: function(e) {
      e.preventDefault();
      console.log(e.key);
      if (CLICKABLE.indexOf(e.key) !== -1) {
        var click = new Event('click', { "bubbles": true, });
        var button = document.querySelector('[data-id="' + e.key + '"]');
        button.dispatchEvent(click);
      }
    },

    moveCursorToEnd: function() {
      // if input isn't focus, then focus
      if (!(document.activeElement === this.input)) {
        this.input.focus();
      }

      if (!this.input.firstChild) { return; }

      var len = this.input.textContent.length;

      var range = document.createRange();
      range.setStart(this.input.firstChild, len);
      range.setEnd(this.input.firstChild, len);
      var sel = window.getSelection();
      sel.removeAllRanges();
      sel.addRange(range);
    },

    bindEvents: function() {
      this.calc.addEventListener('click', this.processClick.bind(this));
      this.input.addEventListener('keydown', this.processKeydown.bind(this));
    },

    init: function() {
      this.bindEvents();
    }
  }

  Calculator.init();

  function inStack() {
    var args = [].slice.call(arguments);
    return inList.apply(null, [Calculator.stack].concat(args));
  }

});
