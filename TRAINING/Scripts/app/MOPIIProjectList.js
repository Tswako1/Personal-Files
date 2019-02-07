(function() {

  this.MOPIIProjectsListController = [
    '$scope', '$http', '$routeParams', 'mOPIIProjects', 'organisations', 'financialYears', 'financialPeriods', 'operationPlanDescription', 'breadcrumb', function($scope, $http, $routeParams, mOPIIProjects, organisations, financialYears, financialPeriods, operationPlanDescription, breadcrumb) {
      $scope.targetId = $routeParams.id;
      $scope.mOPIIProjects = mOPIIProjects.data;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.financialPeriods = financialPeriods.data;
      $scope.search = function() {
        var params;
        params = {};
        angular.copy($scope.filters, params);
        params.filter = $scope.filter;
        return $http.get("api/mOPIIProject/" + $route.current.params.id, {
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
          description: 'Operations',
          url: "operations/plans"
        }
      ]);
    }
  ];

}).call(this);
