(function() {

  this.MopiiActualsController = [
    '$scope', '$http', '$routeParams', 'notification', 'financialPeriods', 'breadcrumb', function($scope, $http, $routeParams, notification, financialPeriods, breadcrumb) {
      $scope.save = function() {
        if ($scope.planForm.$valid) {
          return $http.put("api/mopii/actuals/" + $scope.plan.id + "/" + $scope.period, $scope.plan).then(function(response) {
            notification("Successfully saved");
            return $scope.plan = response.data;
          });
        }
      };
      $scope.$watch('period', function(value) {
        if (value) {
          return $http.get("api/mopii/actuals/" + $routeParams.id + "/" + value).then(function(x) {
            return $scope.plan = x.data || {};
          });
        }
      });
      $scope.periods = financialPeriods.data;
      return breadcrumb([
        $, {
          description: 'Operations',
          url: "operations/plans"
        }
      ]);
    }
  ];

}).call(this);
