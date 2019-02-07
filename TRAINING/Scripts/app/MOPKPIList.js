(function() {

  this.MOPKPIListController = [
    '$scope', '$http', 'mOPKPIs', 'breadcrumb', function($scope, $http, mOPKPIs, breadcrumb) {
      $scope.mOPKPIs = mOPKPIs.data;
      $scope.search = function() {
        return $http.get("api/mOPKPI/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPKPIs = response.data;
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
