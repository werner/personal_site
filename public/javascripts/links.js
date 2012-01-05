(function() {

  $("#home").click(function() {
    return $("#mybook").booklet(2);
  });

  $("#skills").click(function() {
    return $("#mybook").booklet(4);
  });

  $("#work").click(function() {
    return $("#mybook").booklet(6);
  });

  $("#contact").click(function() {
    return $("#mybook").booklet(8);
  });

  $("#spain").click(function() {
    return window.location.replace("http://localhost:3000/?locale=es");
  });

  $("#usa").click(function() {
    return window.location.replace("http://localhost:3000/?locale=en");
  });

}).call(this);
