(function() {

  this.MopiiPlanListController = [
    '$scope', '$http', '$routeParams', 'notification', 'organisations', 'financialYears', 'plans', 'breadcrumb', function($scope, $http, $routeParams, notification, organisations, financialYears, plans, breadcrumb) {
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.operationalPlans = {
        items: plans.data || []
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
