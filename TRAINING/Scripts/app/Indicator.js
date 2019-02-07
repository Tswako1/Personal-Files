(function() {

  this.IndicatorController = [
    '$scope', '$http', 'notification', 'indicator', 'types', 'unitOfMeasures', 'items', 'strategies', 'standards', 'breadcrumb', function($scope, $http, notification, indicator, types, unitOfMeasures, items, strategies, standards, breadcrumb) {
      var fn;
      $scope.indicator = indicator != null ? indicator.data[0] : void 0;
      $scope.types = types.data;
      $scope.unitOfMeasures = unitOfMeasures.data;
      $scope.items = items.data;
      $scope.strategies = strategies.data;
      $scope.standards = standards.data;
      $scope.isUpdate = indicator !== null;
      fn = function() {
        if ($scope.indicator.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.save = function() {
        if ($scope.indicatorForm.$valid) {
          return fn()("api/indicator/", $scope.indicator).then(function(response) {
            $scope.indicator.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      return breadcrumb([
        {
          description: 'Indicators',
          url: '/administration/indicators'
        }, {
          description: 'Create'
        }
      ]);
    }
  ];

}).call(this);
