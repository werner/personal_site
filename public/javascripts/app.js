/* DO NOT MODIFY. This file was compiled Thu, 05 Sep 2013 16:02:28 GMT from
 * /home/werner/Documentos/Proyectos/personal_site/app/coffeescripts/app.coffee
 */

(function() {

  $("#form").ajaxForm(function() {
    return {
      success: $("#form").reset()
    };
  });

}).call(this);
