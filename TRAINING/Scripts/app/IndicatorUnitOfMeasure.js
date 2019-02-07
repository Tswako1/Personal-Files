(function() {

  this.IndicatorUnitOfMeasureController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicatorUnitOfMeasure', 'breadcrumb', function($scope, $http, $routeParams, notification, indicatorUnitOfMeasure, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.indicatorUnitOfMeasure.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveIndicatorUnitOfMeasure = function() {
        if ($scope.indicatorUnitOfMeasureForm.$valid) {
          return fn()("api/indicatorUnitOfMeasure/", $scope.indicatorUnitOfMeasure).then(function(response) {
            $scope.indicatorUnitOfMeasure = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.indicatorUnitOfMeasure = (indicatorUnitOfMeasure != null ? indicatorUnitOfMeasure.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Indicator Units of Measure',
          url: "administration/indicatorUnitOfMeasureList"
        }
      ]);
    }
  ];

}).call(this);
