(function() {

  this.IndicatorTypeListController = [
    '$scope', '$http', 'indicatorTypes', 'breadcrumb', function($scope, $http, indicatorTypes, breadcrumb) {
      $scope.indicatorTypes = indicatorTypes.data;
      $scope.search = function() {
        return $http.get("api/indicatorType/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.indicatorTypes = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Indicator Types'
        }
      ]);
    }
  ];

}).call(this);
