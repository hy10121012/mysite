# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$j = jQuery

showElement =(ele)->
  $(ele).stop().animate {width: '16.7%',  borderRightWidth: 2},300

$j ->
  $('#enter').click ->
    body = $("#body")
    body.animate {
    opacity: 0
    }, 3000,->
      window.location.href = '/home'

  $(window).resize ->
    correctSize('home_top_1')
    correctSize('menu_area')

  $( window ).load ->
    correctSize('home_top_1')
    correctSize('menu_area')

#  showMenu($('#menu_list'))
#  $('#html_container').scroll(->
#    element = $('#html_container');
#    if(navigator.userAgent.indexOf("Mobile")> -1)
#      if  (navigator.userAgent.indexOf("Chrome")> -1)
#        if document.body.scrollTop >=$(window).height()
#          showMenu($('#menu_list'))
#      else if (navigator.userAgent.indexOf("Safari") >-1)
#        if document.body.scrollTop >= $('body').height()
#          showMenu($('#menu_list'))
#    else
#      if element.scrollTop()==element.height()
#        showMenu($('#menu_list'))
#  )


  $('#home_down_arrow').click ->
    $('.html_container').animate {scrollTop: $(document).height() },1000

  $(".menu_list_item_cover").click ->
    e = $(this)
    $url = $(e).parent().attr "id"
    window.location.href = $url;

  $('.menu_list_item_cover').mouseenter(()->
    $('#'+$(this).attr('oid')+'_').animate({backgroundColor: 'background-color:rgba(255,255,255,0.1);',},200);
  ).mouseout(()->
    $('#'+$(this).attr('oid')+'_').animate({backgroundColor: 'background-color:rgba(255,255,255,0.0)',},200);
  )



showMenu=(e) ->
  if(e.css("display")=="none")
    e.waitForImages({
      waitForAll: true,
      finished: ->
        e.show("drop",2000)
    #      elements = $(this).find('.menu_list_item');
    #      index = elements.length;
    #      showloop = setInterval ->
    #        index--;
    #        if (index<0)
    #            clearInterval(showloop);
    #        else
    #          showElement(elements[index])
    #      ,300;
    });

mysite.controller 'HomeCtrl',($scope) ->
  $scope.lan = lang
mysite.controller 'OptionCtrl',($scope) ->
  $scope.lan = lang

