mysite.controller('ArticleCtrl', ['$scope', '$http',($scope,$http) ->

  $scope.get_comment = (id) ->
    $http.get("/my_blog/get_comment/"+id).success((data) ->
     $scope.comments= data
  )

  $scope.return = ()->
    window.location.href="/my_blog"
  $scope.sendComment = (id, comment,name) ->
    csrfToken = $("meta[name='csrf-token']").attr("content");
    $http({method:'post',url:"/my_blog/add_comment",headers: {'X-CSRF-Token': csrfToken},data:{'id':id,'comment':comment,'name':name}}).success((data) ->
      console.log(data)
      $scope.comments= data
      $scope.comment=""
    )

]);




