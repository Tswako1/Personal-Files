(function() {

  this.IndicatorTypeController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicatorType', 'breadcrumb', function($scope, $http, $routeParams, notification, indicatorType, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.indicatorType.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveIndicatorType = function() {
        if ($scope.indicatorTypeForm.$valid) {
          return fn()("api/indicatorType/", $scope.indicatorType).then(function(response) {
            $scope.indicatorType = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.indicatorType = (indicatorType != null ? indicatorType.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Indicator Types',
          url: "administration/indicatorTypeList"
        }
      ]);
    }
  ];

}).call(this);
