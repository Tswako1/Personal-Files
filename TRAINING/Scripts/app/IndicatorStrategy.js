(function() {

  this.IndicatorStrategyController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicatorStrategy', 'breadcrumb', function($scope, $http, $routeParams, notification, indicatorStrategy, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.indicatorStrategy.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveIndicatorStrategy = function() {
        if ($scope.indicatorStrategyForm.$valid) {
          return fn()("api/indicatorStrategy/", $scope.indicatorStrategy).then(function(response) {
            $scope.indicatorStrategy = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.indicatorStrategy = (indicatorStrategy != null ? indicatorStrategy.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Indicator Strategies',
          url: "administration/indicatorStrategyList"
        }
      ]);
    }
  ];

}).call(this);
