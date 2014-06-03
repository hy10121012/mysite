mysite.controller('BookCtrl', ['$scope', '$http',($scope, $http) ->
  $scope.hide_tag=true;
  $scope.hide_blog=false;

  $http.get("/my_book/book_list").success((data)->
    console.log(data)
    $scope.books = data
  );
]);


mysite.directive('openBook', ($rootScope) ->
  return {
    restrict: 'A'
    ,link: (scope, element,attrs) ->
      element.append('<div class="item_cover" ><div id="show'+attrs.id+'" class="cover_text" >'+attrs.openBook+'</div></div>');
      $('#show'+attrs.id).css("line-height",element.height()+'px');
      element.on('mouseenter', ->
        $('#show'+attrs.id).css("visibility",'visible');
      );
      element.on('mouseleave', ->
        $('#show'+attrs.id).css("visibility",'hidden');
      );
      element.bind("click", ->
        $.get( '/my_book/find_book/'+attrs.openBook,(data) ->
          img = '/images/book/default.jpg';
          if data.img_url !=null
            img ='/images/book/'+data.img_url;
          lang = "Unknown"
          if data.language==1
            lang = $rootScope.lang.book_language_cn
          if data.language==2
            lang = $rootScope.lang.book_language_en
          container = "<div id='center_container' class='center_container'>";
          container += "<div id='center_container_closer' class='center_container_closer'>X</div>";

          container +=  "<div class='center_container_details'>"
          container +=  "<div class='center_container_details_img'>"
          container +=  "<img src='"+img+"' >"
          container +=  "</div>"
          container +=  "<div class='center_container_details_info'>"
          container +=  "<div class='center_container_title'>"+data.name+"</div>"
          container +=  "<div class='center_container_details_info_row'>"
          container +=   $rootScope.lang.book_language+": "+lang+''
          container +=  "</div>"
          container +=  "<div class='center_container_details_info_row'>"
          container +=   $rootScope.lang.book_author+": "+data.author
          container +=  "</div>"
          container +=  "<div class='center_container_details_info_row'>"
          container +=   $rootScope.lang.book_category+": "+data.category+''
          container +=  "</div>"
          container +=  "</div>"
          container +=  "<div class='clear'></div>"
          container +=  "</div>"
          container +=  "<div class='center_container_description'>"
          container +=  data.description
          container +=  "</div>"
          container +=  "<div class='center_container_bottom_nav'>"
          container +=   '<div class="center_container_bottom_nav_download">'+$rootScope.lang.book_download+'</div>'
          container +=  "</div>"
          container +="</div>";

          html = "<div style='display: none' class='blink' id='blink'>"+container+"</div>";
          $('body').prepend(html)
          top_margin = Math.floor(window.innerHeight- $('#center_container').height())/2;
          left_margin = Math.floor(window.innerWidth- $('#center_container').width())/2;
          if top_margin<100
            top_margin=100;
          if top_margin<0
            top_margin=0;
          $('#center_container').css('margin-top',top_margin+'px');
          $('#center_container').css('left',left_margin+'px');
          $('.blink').fadeIn();
          $('#center_container_closer').on('click',->
            $('#blink').fadeOut(->
              $('#blink').remove();
            );
          )
        )
      )
  }
)




