(function() {

  this.CrossCuttingProgrammeListController = [
    '$scope', '$http', 'crossCuttingProgrammes', 'breadcrumb', function($scope, $http, crossCuttingProgrammes, breadcrumb) {
      $scope.crossCuttingProgrammes = crossCuttingProgrammes.data;
      $scope.search = function() {
        return $http.get("api/crossCuttingProgramme/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.crossCuttingProgrammes = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Cross Cutting Programmes'
        }
      ]);
    }
  ];

}).call(this);
