(function() {

  this.IssueController = [
    '$scope', '$http', '$routeParams', function($scope, $http, $routeParams) {
      return $scope.save = function() {
        return $http.post("api/issue?projectId=" + $routeParams.id, $scope.issue);
      };
    }
  ];

}).call(this);
