(function() {

  jQuery.fn.reset = function() {
    return $(this).each(function() {
      return this.reset();
    });
  };

  Cufon.replace('.logo-name,.brush-font', {
    fontFamily: 'Brush Script Std'
  });

  Cufon.replace('.logo-developer,.subtitle-style,.b-counter', {
    fontFamily: 'Agency FB'
  });

  Cufon.now();

  $("#form").ajaxForm(function() {
    return {
      success: $("#form").reset()
    };
  });

}).call(this);
