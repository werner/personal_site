$mybook = $ "#mybook"
$bttn_next = $ "#next_page_button"
$bttn_prev = $ "#prev_page_button"
$loading = $ "#loading"
$mybook_images = $mybook.find "img"
cnt_images = $mybook_images.length
loaded = 0

Cufon.replace('.logo-name', 
  fontFamily:'Brush Script Std'
)

Cufon.replace('.logo-developer', 
  fontFamily:'Agency FB'
)

$mybook_images.each ->
  $img = $(this)
  source = $img.attr("src")
  $("<img/>").load(->
    ++loaded
    if loaded is cnt_images
      $loading.hide()
      $bttn_next.show()
      $bttn_prev.show()
      $mybook.show().booklet
        name: null
        width: 800
        height: 500
        speed: 600
        direction: "LTR"
        startingPage: 0
        easing: "easeInOutQuad"
        easeIn: "easeInQuad"
        easeOut: "easeOutQuad"
        closed: true
        closedFrontTitle: null
        closedFrontChapter: null
        closedBackTitle: null
        closedBackChapter: null
        covers: false
        pagePadding: 10
        pageNumbers: true
        hovers: false
        overlays: false
        tabs: false
        tabWidth: 60
        tabHeight: 20
        arrows: false
        cursor: "pointer"
        hash: false
        keyboard: true
        next: $bttn_next
        prev: $bttn_prev
        menu: null
        pageSelector: false
        chapterSelector: false
        shadows: true
        shadowTopFwdWidth: 166
        shadowTopBackWidth: 166
        shadowBtmWidth: 50
        before: ->

        after: ->

      Cufon.refresh()
  ).attr "src", source