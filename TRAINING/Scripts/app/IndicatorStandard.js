(function() {

  this.IndicatorStandardController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicatorStandard', 'breadcrumb', function($scope, $http, $routeParams, notification, indicatorStandard, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.indicatorStandard.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveIndicatorStandard = function() {
        if ($scope.indicatorStandardForm.$valid) {
          return fn()("api/indicatorStandard/", $scope.indicatorStandard).then(function(response) {
            $scope.indicatorStandard = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.indicatorStandard = (indicatorStandard != null ? indicatorStandard.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Indicator Standards',
          url: "administration/indicatorStandardList"
        }
      ]);
    }
  ];

}).call(this);
