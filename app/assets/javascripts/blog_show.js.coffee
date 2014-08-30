mysite.controller('ArticleCtrl', ['$scope', '$http',($scope,$http) ->
  $scope.csrfToken = $("meta[name='csrf-token']").attr("content");
  $scope.get_comment = (id) ->
    $http.get("/my_blog/get_comment/"+id).success((data) ->
     $scope.comments= data
  )
  $scope.like = (id) ->
      $http({method:'post',url:"/blogs/"+id+"/like",headers: {'X-CSRF-Token': $scope.csrfToken}}).success((count) ->
        $('#like_count').text(count)
  )
  $scope.dislike = (id) ->
    $http({method:'post',url:"/blogs/"+id+"/dislike",headers: {'X-CSRF-Token': $scope.csrfToken}}).success((count) ->
      $('#dislike_count').text(count)
    )
  $scope.return = ()->
    window.location.href="/my_blog"
  $scope.sendComment = (id, comment,name) ->
    $http({method:'post',url:"/my_blog/add_comment",headers: {'X-CSRF-Token': $scope.csrfToken},data:{'id':id,'comment':comment,'name':name}}).success((data) ->
      console.log(data)
      $scope.comments= data
      $scope.comment=""
    )

]);




