(function() {

  this.FaultPriorityListController = [
    '$scope', '$http', 'faultPriorities', 'breadcrumb', function($scope, $http, faultPriorities, breadcrumb) {
      $scope.faultPriorities = faultPriorities.data;
      $scope.search = function() {
        return $http.get("api/faultPriority/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.faultPriorities = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Fault Priorities'
        }
      ]);
    }
  ];

}).call(this);
