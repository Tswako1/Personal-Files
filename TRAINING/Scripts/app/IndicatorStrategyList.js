(function() {

  this.IndicatorStrategyListController = [
    '$scope', '$http', 'indicatorStrategies', 'breadcrumb', function($scope, $http, indicatorStrategies, breadcrumb) {
      $scope.indicatorStrategies = indicatorStrategies.data;
      $scope.search = function() {
        return $http.get("api/indicatorStrategy/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.indicatorStrategies = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Indicator Strategies'
        }
      ]);
    }
  ];

}).call(this);
