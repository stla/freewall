HTMLWidgets.widget({
  name: "freewall",

  type: "output",

  factory: function(el, width, height) {

    var $el = $(el);
    $el.css("margin-left", "auto").css("margin-right", "auto");

    return {
      renderValue: function(x) {

        $el.css("width", x.width);

        var images = x.images;
        var widths = x.widths;
        var heights = x.heights;
        var itemsClass = el.id + "-item";
        var html = "";
        if(x.display === "url") {
          var style =
            "width: {w}px; height: {h}px; background-image: url({img});";
          var temp =
            "<div class='" + itemsClass +
            "' style='" + style + "'></div>";
          for(var i = 0; i < images.length; ++i) {
            html += temp
              .replace("{w}", widths[i])
              .replace("{h}", heights[i])
              .replace("{img}", images[i]);
          }
        } else {
          if(heights) {
            var temp =
              "<div class='" + itemsClass +
              "' style='width:{width}px; height: {height}px;'>" +
              "<img src='{image}' width='100%' " +
              "style='display: block; margin: 0;'></div>";
            for(var i = 0; i < images.length; ++i) {
              html += temp
                .replace("{width}", widths[i])
                .replace("{height}", heights[i])
                .replace("{image}", images[i]);
            }
          } else {
            var temp =
              "<div class='" + itemsClass +
              "' style='width: {width}px;'>" +
              "<img src='{image}' width='100%' " +
              "style='display: block; margin: 0;'></div>";
            for(var i = 0; i < images.length; ++i) {
              html += temp
                .replace("{width}", widths[i])
                .replace("{image}", images[i]);
            }
          }
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

        if(x.display === "url") {
          wall.fitWidth();
        } else {
          var $items = wall.container.find("." + itemsClass);
          $items.find("img").on("load", function() {
            wall.fitWidth();
          });
        }

      },

      resize: function(width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
