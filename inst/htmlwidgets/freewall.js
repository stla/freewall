HTMLWidgets.widget({
  name: "freewall",

  type: "output",

  factory: function (el, width, height) {

    var $el = $(el);

    return {
      renderValue: function (x) {

        var images = x.images;
        var itemsClass = el.id + "-item";
        var temp =
          "<div class='" +
          itemsClass +
          "' style='width:{width}px;'><img src='{image}' width='100%'></div>";
        var html = "";
        for(var i = 0; i < images.length; ++i) {
          html += temp.replace(/\{width\}/g, 150).replace("{image}", images[i]);
        }

        $el.html(html);

        var wall = new Freewall("#" + el.id);
        wall.reset({
          selector: "." + itemsClass,
          animate: true,
          cellW: 150,
          cellH: "auto",
          onResize: function () {
            wall.fitWidth();
          }
        });

        var $images = wall.container.find("." + itemsClass);
        $images.find("img").on("load", function() {
          wall.fitWidth();
        });
      },

      resize: function (width, height) {
        // TODO: code to re-render the widget with a new size
      }
    };
  }
});
