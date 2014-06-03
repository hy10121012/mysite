# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $(window).resize ->
    correctSize('body_header');
  $("#body_header").waitForImages({
    waitForAll: true,
    finished: ->
      correctSize($(this).attr("id"))  ;
  });



