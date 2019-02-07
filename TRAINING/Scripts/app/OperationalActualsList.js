(function() {

  this.OperationalActualsListController = [
    '$scope', '$http', '$routeParams', 'operationalActuals', 'organisations', 'financialYears', 'financialPeriods', 'operationPlanDescription', 'breadcrumb', function($scope, $http, $routeParams, operationalActuals, organisations, financialYears, financialPeriods, operationPlanDescription, breadcrumb) {
      $scope.targetId = $routeParams.id;
      $scope.operationalActuals = operationalActuals.data;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.financialPeriods = financialPeriods.data;
      $scope.search = function() {
        var params;
        params = {};
        angular.copy($scope.filters, params);
        params.filter = $scope.filter;
        return $http.get("api/operationalActuals/" + $route.current.params.id, {
          params: params
        }).then(function(response) {
          return $scope.backToBasics = response.data;
        });
      };
      $scope.$watch('filters', function(value) {
        if (value) {
          return $scope.search();
        }
      }, true);
      return breadcrumb([
        {
          description: operationPlanDescription.data.name,
          url: "/operationalPlan/" + $routeParams.id + "/1"
        }, {
          description: 'Actuals',
          url: "/operationalPlan/" + $routeParams.id + "/actuals"
        }
      ]);
    }
  ];

}).call(this);
