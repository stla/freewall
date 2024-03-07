HTMLWidgets.widget({
  name: "freewall",

  type: "output",

  factory: function(el, width, height) {

    var $el = $(el);

    return {
      renderValue: function(x) {

        $el.css("width", x.width).css("margin", "auto");

        var images = x.images;
        var widths = x.widths;
        var itemsClass = el.id + "-item";
        var temp =
          "<div class='" +
          itemsClass +
          "' style='width:{width}px;'>" +
          "<img src='{image}' width='100%' " +
          "style='display: block; margin: 0;'></div>";
        var html = "";
        for(var i = 0; i < images.length; ++i) {
          html += temp
            .replace(/\{width\}/g, widths[i])
            .replace("{image}", images[i]);
        }

        $el.html(html);

        var wall = new Freewall("#" + el.id);
        wall.reset({
          selector: "." + itemsClass,
          draggable: x.draggable,
          animate: x.animate,
          cellW: x.cellW,
          cellH: x.cellH,
          delay: x.delay,
          fixSize: x.fixSize,
          gutterX: x.gutterX,
          gutterY: x.gutterY,
          keepOrder: x.keepOrder,
          rightToLeft: x.rightToLeft,
          bottomToTop: x.bottomToTop,
          onResize: function() {
            wall.fitWidth();
          }
        });

        var $images = wall.container.find("." + itemsClass);
        $images.find("img").on("load", function() {
          wall.fitWidth();
        });

      },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
