(function() {
  var $bttn_next, $bttn_prev, $loading, $mybook, $mybook_images, cnt_images, loaded;

  $mybook = $("#mybook");

  $bttn_next = $("#next_page_button");

  $bttn_prev = $("#prev_page_button");

  $loading = $("#loading");

  $mybook_images = $mybook.find("img");

  cnt_images = $mybook_images.length;

  loaded = 0;

  $mybook_images.each(function() {
    var $img, source;
    $img = $(this);
    source = $img.attr("src");
    return $("<img/>").load(function() {
      ++loaded;
      if (loaded === cnt_images) {
        $loading.hide();
        $bttn_next.show();
        $bttn_prev.show();
        return $mybook.show().booklet({
          name: null,
          width: 800,
          height: 500,
          speed: 600,
          direction: "LTR",
          startingPage: 0,
          easing: "easeInOutQuad",
          easeIn: "easeInQuad",
          easeOut: "easeOutQuad",
          closed: true,
          closedFrontTitle: null,
          closedFrontChapter: null,
          closedBackTitle: null,
          closedBackChapter: null,
          covers: false,
          pagePadding: 10,
          pageNumbers: true,
          hovers: false,
          overlays: false,
          tabs: false,
          tabWidth: 60,
          tabHeight: 20,
          arrows: false,
          cursor: "pointer",
          hash: false,
          keyboard: true,
          next: $bttn_next,
          prev: $bttn_prev,
          menu: null,
          pageSelector: false,
          chapterSelector: false,
          shadows: true,
          shadowTopFwdWidth: 166,
          shadowTopBackWidth: 166,
          shadowBtmWidth: 50,
          before: function() {},
          after: function() {}
        });
      }
    }).attr("src", source);
  });

}).call(this);
