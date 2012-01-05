$("#home").click ->
  $("#mybook").booklet 2

$("#skills").click ->
  $("#mybook").booklet 4

$("#work").click ->
  $("#mybook").booklet 6

$("#contact").click ->
  $("#mybook").booklet 8
  
$("#spain").click ->
  window.location.replace("http://werner.heroku.com/?locale=es")
  
$("#usa").click ->
  window.location.replace("http://werner.heroku.com/?locale=en")