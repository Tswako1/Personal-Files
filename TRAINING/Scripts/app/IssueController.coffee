@IssueController = ['$scope', '$http', '$routeParams', ($scope, $http, $routeParams) ->
    $scope.save = ->
        $http.post "api/issue?projectId=#{$routeParams.id}", $scope.issue
]