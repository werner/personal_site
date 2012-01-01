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

$("#form").ajaxForm ->
  success:
    $("#form").reset()
