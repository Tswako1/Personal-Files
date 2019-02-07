(function() {

  this.MopiiPlanCreateController = [
    '$scope', '$http', '$routeParams', '$location', 'notification', 'organisations', 'financialYears', 'breadcrumb', function($scope, $http, $routeParams, $location, notification, organisations, financialYears, breadcrumb) {
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.create = function() {
        if (!$scope.misaFinancialYearId || !$scope.organisationId) {
          notification("Select organisation and financial year");
          return;
        }
        return $http.post('/api/mopii/plans', {
          organisationId: $scope.organisationId,
          misaFinancialYearId: $scope.misaFinancialYearId
        }).then(function(x) {
          return $location.path("/operations/plan/" + x.data.id);
        });
      };
      return breadcrumb([
        {
          description: 'Operations',
          url: "operations/plans"
        }
      ]);
    }
  ];

}).call(this);
