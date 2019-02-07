(function() {

  this.DevelopmentalLocationListController = [
    '$scope', '$http', 'developmentalLocations', 'breadcrumb', function($scope, $http, developmentalLocations, breadcrumb) {
      $scope.developmentalLocations = developmentalLocations.data;
      $scope.search = function() {
        return $http.get("api/developmentalLocation/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.developmentalLocations = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Developmental Locations'
        }
      ]);
    }
  ];

}).call(this);
