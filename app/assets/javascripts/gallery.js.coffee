mysite.controller('GalleryCtrl', ['$scope', '$http',($scope, $http) ->

  $http.get("/gallery/get_pic").success((data)->
    $scope.photos = data

  );
]);