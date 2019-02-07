(function() {

  this.MOPIIProcessListController = [
    '$scope', '$http', 'mOPIIProcesss', 'breadcrumb', function($scope, $http, mOPIIProcesss, breadcrumb) {
      $scope.mOPIIProcesss = mOPIIProcesss.data;
      $scope.search = function() {
        return $http.get("api/mOPIIProcess/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPIIProcesss = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'MOP Processes'
        }
      ]);
    }
  ];

}).call(this);
