(function() {

  this.IndicatorStandardListController = [
    '$scope', '$http', 'indicatorStandards', 'breadcrumb', function($scope, $http, indicatorStandards, breadcrumb) {
      $scope.indicatorStandards = indicatorStandards.data;
      $scope.search = function() {
        return $http.get("api/indicatorStandard/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.indicatorStandards = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Indicator Standards'
        }
      ]);
    }
  ];

}).call(this);
