var Stamper = {
  setShape: function(e) {
    e.preventDefault();
    var $e = $(e.target);
    var className = 'active';
    $e.closest('ul').find('.' + className).removeClass(className);
    $(e.target).addClass(className);

    this.method = $e.attr('data-method');
  },

  drawingMethods: {
    size: 30,
    square: function(x, y) {
      var size = this.size;
      return function() {
        this.ctx.fillRect(x - size / 2, y - size / 2, size, size);
      }
    },
    circle: function(x, y) {
      var radius = this.size / 2;
      return function() {
        this.ctx.beginPath();
        this.ctx.arc(x, y, radius, 0, 2 * Math.PI);
        this.ctx.fill();
        this.ctx.closePath();
      }
    },
    triangle: function(x, y) {
      var dim = this.size / 2;
      return function() {
        var dim = 30 / 2;
        this.ctx.beginPath();
        this.ctx.moveTo(x, y - dim);
        this.ctx.lineTo(x + dim, y + dim);
        this.ctx.lineTo(x - dim, y + dim);
        this.ctx.lineTo(x, y - dim);
        this.ctx.fill();
        this.ctx.closePath();
      }
    },
    clear: function() {
      return function() {
        this.ctx.clearRect(0, 0, this.canvas.width, this.canvas.height);
      }
    }
  },

  draw: function(e) {
    var x = e.offsetX;
    var y = e.offsetY;
    this.ctx.fillStyle = $('input').val();

    switch (this.method) {
      case 'square':
        // this.ctx.fillRect(x - 20, y - 20, 40, 40);
        this.drawingMethods.square(x, y).call(this);
        break;
      case 'circle':
        this.drawingMethods.circle(x, y).call(this);
        break;
      case 'triangle':
        this.drawingMethods.triangle(x, y).call(this);
        break;
    }
  },

  clear: function(e) {
    e.preventDefault();
  },

  bindEvents: function() {
    $('.drawing_method').on('click', this.setShape.bind(this)).eq(0).click();
    $('canvas').on('click', this.draw.bind(this));
    $('#clear').on('click', this.drawingMethods.clear().bind(this));
  },

  init: function() {
    this.canvas = document.querySelector('canvas'),
    this.ctx = this.canvas.getContext('2d'),
    this.bindEvents();
  }
}

$(Stamper.init.bind(Stamper));
