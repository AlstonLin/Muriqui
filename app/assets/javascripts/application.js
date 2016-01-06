// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .
//= require codemirror
//= require codemirror/modes/clike

var ready = function(){
  $("#codemirror").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      mode: "text/x-csrc"
    });
  });

  $("#codemirror-read").each(function() {
    CodeMirror.fromTextArea($(this).get(0), {
      lineNumbers: true,
      mode: "text/x-csrc",
      readOnly: true,
      scrollbarStyle: "null"
    });
  });



  $('.motto').slideDown(1000);
};

$(document).ready(ready);
$(document).on('page:load', ready);
