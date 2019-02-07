(function() {

  this.MOPIIKPIListController = [
    '$scope', '$http', 'mOPIIKPIs', 'breadcrumb', function($scope, $http, mOPIIKPIs, breadcrumb) {
      $scope.mOPIIKPIs = mOPIIKPIs.data;
      $scope.search = function() {
        return $http.get("api/mOPIIKPI/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPIIKPIs = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'MOP KPIs'
        }
      ]);
    }
  ];

}).call(this);
