jQuery.fn.reset = ->
  $(this).each( ->
    @reset()
  )

Cufon.replace('.logo-name,.brush-font', 
  fontFamily:'Brush Script Std'
)

Cufon.replace('.logo-developer,.subtitle-style,.b-counter', 
  fontFamily:'Agency FB'
)

Cufon.now()

$("#form").ajaxForm ->
  success:
    $("#form").reset()