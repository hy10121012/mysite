# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#work_page_1").waitForImages({
    waitForAll: true,
    finished: ->
      correctSize($(this).attr("id"))  ;
  });
  $("#work_page_3").waitForImages({
    waitForAll: true,
    finished: ->
      correctSize($(this).attr("id"))  ;
  });
  $("#work_page_5").waitForImages({
    waitForAll: true,
    finished: ->
      correctSize($(this).attr("id"))  ;
  });
  $(window).resize ->
    correctSize('work_page_1')  ;
    correctSize('work_page_3')  ;
    correctSize('work_page_5')  ;



mysite.controller('WorkCtrl', ['$scope', '$http',($scope) ->
  $scope.redirect = ($event) ->
    window.location.href=$event.currentTarget.id
]);