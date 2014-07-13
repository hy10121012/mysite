#mysite.controller('GalleryCtrl', ['$scope', '$http',($scope, $http) ->
#
#  $http.get("/gallery/get_pic").success((data)->
#    $scope.photos = data
#    i = 2;
#    $($scope.photos).each( ()->
#      if(i==1)
#        i=2
#      else
#        i=1
#      this.style=i;
#    console.log($scope.photos)
#    )
#  );
#]);
$(document).ready ->
  container = $('#gallery_area');
  container.waitForImages(()->
    container.masonry();
  );



  $('#album_area').waitForImages(()->
    correctSize('album_body')
    height =  Math.round($(window).height()* 0.4)
    if(height<300)
      height=300
    else if(height>600)
      height=600
    $('#album_area').height(height);
  );

#  $('#album_area').touchwipe({
#    wipeLeft: ()->
#      $('#album_area').animate {scrollLeft: $('#album_area').scrollLeft()+$('#album_area').width()*0.2 },1000
#    wipeRight: ()->
#      $('#album_area').animate {scrollLeft: $('#album_area').scrollLeft()-$('#album_area').width()*0.2 },1000
#
#    preventDefaultEvents: true
#  })


  $( "#scroll_bar_icon" ).draggable({ containment: "parent",drag: ()->
    $('#scroll_bar_icon').css('background-color','rgba(255, 255, 255, 0.9)')
  ,stop: ()->
    move_po = ($('#album_area').prop("scrollWidth")-$("#scroll_bar").width())/ $("#scroll_bar").width()
    move_px = Math.round($("#scroll_bar_icon").position().left * move_po)
    $('#album_area').animate {scrollLeft: move_px },1000
    $('#scroll_bar_icon').css('background-color','rgba(255, 255, 255, 0.6)')

  });



mysite.controller('galleryCtrl', ['$scope', '$http',($scope,$http) ->

]).directive('showDesc',() ->
  return {
  restrict: 'A',
  link: (scope, element,attrs) ->
    element.on('mouseenter',()->
      $('#album_title').html(attrs.title)
      $('#album_description').html(attrs.description)

    )

  }
);

mysite.controller('albumCtrl', ['$scope', '$http',($scope,$http) ->

])



mysite.directive('openPic', [() ->
  return {
  restrict: 'A'
  ,link: (scope, element,attrs) ->
    pic_list.push(attrs.openPic)
    element.bind("click", (e)->
      e.stopPropagation(element);
      open_img(element)
    )
  }
])
#
#adjust = ()->
#
#  container = $('#pic_center_container');
#  if  $('#img').height() >Math.floor(window.innerHeight* 0.8)
#    $('#img').css("height",Math.floor(window.innerHeight* 0.8)+'px')
#    $('#img').css("width",'')
#  if $('#img').width() >Math.floor(window.innerWidth* 0.8)
#    $('#img').css("width",Math.floor(window.innerWidth* 0.8)+'px')
#    $('#img').css("height",'')
##  alert "maxW"+Math.floor(window.innerWidth* 0.8)+", maxH"+Math.floor(window.innerHeight* 0.8)+" W"+$('#img').width()+", H"+$('#img').height()
#
#  $('#pic_center_container').waitForImages(()->
#    top_margin = Math.floor(window.innerHeight- $('#img').height())/2;
#    left_margin = Math.floor(window.innerWidth- $('#img').width())/2;
#    if left_margin<0
#      left_margin=0;
#    if top_margin<0
#      top_margin=0;
#    container.css('margin-top',top_margin+'px');
#    container.css('left',left_margin+'px');
#
#    $('.blink_c').fadeOut(->
#      $('#blink_c').remove();
#    );
#  )

#
#open_img = (element)->
#  img_url = $(element).attr('open-pic');
#  blink="<div style='z-index: 997' class='blink_c' id='blink_c'><div class='blink_c_centered'>Loading...</div></div>";
#  blink_d="<div style='z-index: 997' class='blink_u' id='blink_c'><div class='blink_c_centered'>Loading...</div></div>";
#
#  container = "<div id='pic_center_container' class='pic_center_container'>";
#  container +=  "<img style='cursor: pointer' id='img' src='"+img_url+"' >"
#  container += "</div>"
#  html = blink+"<div  class='blink' id='blink'>"+container+"</div>";
#  $('body').prepend(html)
#  $('#center_container_closer').on('click',->
#    $('#blink').fadeOut(->
#      $('#blink').remove();
#    );
#  )
#
#  $('#pic_center_container').waitForImages(()->
#    current = pic_list.indexOf img_url
#    img =$('#img');
#    $('#img').on('touchend click',(e)->
#      e.stopPropagation();
#    )
#    img.on('click',(e)->
#      offset = $(this).offset();
#      i
#      if((e.clientX - offset.left)>Math.round(img.width()*0.5))
#        i=current+1
#        if(i>=pic_list.length)
#          i-= pic_list.length
#      else
#        i=current-1
#        if(i<0)
#          i=pic_list.length-1
#      img.css('width', '')
#      img.css('height', '')
#      img.attr('src', pic_list[i])
#      $('body').prepend(blink_d)
#      img.waitForImages(()->
#        $('#blink_c').fadeOut(->
#          $('#blink_c').remove();
#        );
#      )
#      current=  i
#      adjust()
#    )
#    adjust()
#  )