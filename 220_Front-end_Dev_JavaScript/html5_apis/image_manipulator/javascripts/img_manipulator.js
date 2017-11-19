var canvas = document.createElement('canvas');
var ctx = canvas.getContext('2d');

var preloader = {
  path: "images/",
  srcs: [
    "24755057340_d14e6d1148_z.jpg",
    "24755457070_b70b22317e_z.jpg",
    "24869815362_198a8d40db_z.jpg"
  ],
  createImage: function(i, src) {
    var $img = $('<img />', { src: this.path + src });
    $img.on('load', manipulator.process.bind(manipulator));
  },
  run: function() {
    $.each(this.srcs, this.createImage.bind(this));
  }
}

var manipulator = {
  drawImage: function(img) {
    canvas.width = img.width;
    canvas.height = img.height;
    ctx.drawImage(img, 0, 0);
  },
  getData: function() {
    return ctx.getImageData(0, 0, canvas.width, canvas.height);
  },
  convertToGrayscale: function() {
    var imageData = this.getData();
    var grayData;

    for (var i = 0, len = imageData.data.length; i < len; i += 4) {
      grayData = imageData.data[i] * .3086 + imageData.data[i + 1] * .6094 + imageData.data[i + 2] * .0820;
      imageData.data[i] = grayData;
      imageData.data[i + 1] = grayData;
      imageData.data[i + 2] = grayData;
    }

    ctx.putImageData(imageData, 0, 0);
  },
  writeImage: function() {
    var img = document.createElement('img');

    img.src = canvas.toDataURL();
    $(document.body).append(img);
  },
  process: function(e) {
    var img = e.target;
    this.drawImage(img);
    this.convertToGrayscale();
    this.writeImage();
  },
}

$(preloader.run.bind(preloader));
