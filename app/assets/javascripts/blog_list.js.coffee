mysite.controller('BlogCtrl', ['$scope', '$http','$filter',($scope, $http,$filter) ->
  $scope.hide_tag=true;
  $scope.hide_blog=false;

  $http.get("/my_blog/find_by_offset/0").success((data)->
    console.log(data)
    current_date = null;
    $(data).each(->
      item_date = $filter('date') this.created_at,'dd.MMM.yyyy, EEE';
      if(current_date==null || current_date!=item_date)
        this.created_date = item_date;
        current_date =  item_date
    )
    $scope.blogs = data
  )
  $http.get("/tags").success((data)->
    console.log(data)
    $scope.tags = data
  )

  $scope.loadTags = () ->
    $scope.hide_tag=false;
    $scope.hide_blog=true;

  $scope.loadBlogs = () ->
    $scope.hide_tag=true;
    $scope.hide_blog=false;

  $scope.goto = (id) ->
    window.location.href = "/tags/"+id;
]);

