(function() {

  this.IndicatorUnitOfMeasureListController = [
    '$scope', '$http', 'indicatorUnitOfMeasures', 'breadcrumb', function($scope, $http, indicatorUnitOfMeasures, breadcrumb) {
      $scope.indicatorUnitOfMeasures = indicatorUnitOfMeasures.data;
      $scope.search = function() {
        return $http.get("api/indicatorUnitOfMeasure/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.indicatorUniUnittOdMeasures = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Indicator Units of Measure'
        }
      ]);
    }
  ];

}).call(this);
