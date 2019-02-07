(function() {

  this.OperationalPlanController = [
    '$scope', '$http', '$routeParams', '$location', 'operation', 'notification', 'operationalPlan', 'organisations', 'financialYears', 'breadcrumb', function($scope, $http, $routeParams, $location, operation, notification, operationalPlan, organisations, financialYears, breadcrumb) {
      var fn, _ref;
      $scope.operationalPlan = operationalPlan != null ? operationalPlan.data : void 0;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.new_ops_plan = ((_ref = $scope.operationalPlan) != null ? _ref.id : void 0) ? true : false;
      fn = function() {
        if ($scope.operationalPlan.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveOperationalPlan = function() {
        if ($scope.operationalPlanForm.$valid) {
          return fn()("api/operationalPlan/", $scope.operationalPlan).then(function(response) {
            $scope.operationalPlan.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      return breadcrumb([
        {
          description: 'Operations',
          url: '/operationalPlan'
        }, {
          description: 'Create'
        }
      ]);
    }
  ];

}).call(this);
