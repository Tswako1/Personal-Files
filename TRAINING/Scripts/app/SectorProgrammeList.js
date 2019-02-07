(function() {

  this.SectorProgrammeListController = [
    '$scope', '$http', 'sectorProgrammes', 'breadcrumb', function($scope, $http, sectorProgrammes, breadcrumb) {
      $scope.sectorProgrammes = sectorProgrammes.data;
      $scope.search = function() {
        return $http.get("api/sectorProgramme/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.sectorProgrammes = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Sector Programmes'
        }
      ]);
    }
  ];

}).call(this);
