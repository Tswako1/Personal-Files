(function() {

  this.MOPIISectionListController = [
    '$scope', '$http', 'mOPIISections', 'breadcrumb', function($scope, $http, mOPIISections, breadcrumb) {
      $scope.mOPIISections = mOPIISections.data;
      $scope.search = function() {
        return $http.get("api/mOPIISection/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPIISections = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'MOP Sections'
        }
      ]);
    }
  ];

}).call(this);
