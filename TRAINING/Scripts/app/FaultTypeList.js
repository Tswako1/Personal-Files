(function() {

  this.FaultTypeListController = [
    '$scope', '$http', 'faultTypes', 'breadcrumb', function($scope, $http, faultTypes, breadcrumb) {
      $scope.faultTypes = faultTypes.data;
      $scope.search = function() {
        return $http.get("api/faultType/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.indicatorItems = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Fault Types'
        }
      ]);
    }
  ];

}).call(this);
