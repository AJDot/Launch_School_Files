var App = {
  startTimer: function(event) {
    var self = this;
    this.timer = setTimeout(function() {
      self.showToolTip(event);
    }, 2000);
  },
  showToolTip: function(event) {
    var target = event.target;
    if (target.tagName === "IMG") {
      var figcaption = target.nextElementSibling;
      this.fadein(figcaption);

    }
  },
  removeToolTip: function(event) {
    if (this.timer) {
      clearTimeout(this.timer);
    }

    var target = event.target;
    if (target.tagName === "IMG") {
      var figcaption = target.nextElementSibling;
      this.fadeout(figcaption);
    }
  },
  fadein: function(element) {
      element.classList.remove("fadeout");
      element.classList.add("fadein");
      element.style.display = "initial";
  },
  fadeout: function(element) {
    setTimeout(function() {
      element.classList.remove("fadein");
      element.classList.add("fadeout");
      setTimeout(function() {
        element.style.display = "none";
      }, 300);
    }, 500);
  },
  init: function() {
    var self = this;
    document.addEventListener("DOMContentLoaded", function() {
      var animals = document.getElementById("animals");
      animals.addEventListener("mouseover", self.startTimer.bind(self));

      animals.addEventListener("mouseout", self.removeToolTip.bind(self));
    });
  }
}

App.init();
