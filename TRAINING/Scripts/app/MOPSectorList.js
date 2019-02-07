(function() {

  this.MOPSectorListController = [
    '$scope', '$http', 'mOPSectors', 'breadcrumb', function($scope, $http, mOPSectors, breadcrumb) {
      $scope.mOPSectors = mOPSectors.data;
      $scope.search = function() {
        return $http.get("api/mOPSector/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPSectors = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'MOP Sectors'
        }
      ]);
    }
  ];

}).call(this);
