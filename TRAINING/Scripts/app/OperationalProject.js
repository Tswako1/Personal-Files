(function() {

  this.OperationalProjectController = [
    '$scope', '$http', '$routeParams', '$location', 'operation', 'notification', 'operationalPlan', 'operationalProject', 'organisations', 'financialYears', 'financialPeriods', 'mopSectors', 'mopProjectTypes', 'mopProjectStages', 'fundingSources', 'fundingSourceGroups', 'mopkpis', 'operationPlanDescription', 'breadcrumb', function($scope, $http, $routeParams, $location, operation, notification, operationalPlan, operationalProject, organisations, financialYears, financialPeriods, mopSectors, mopProjectTypes, mopProjectStages, fundingSources, fundingSourceGroups, mopkpis, operationPlanDescription, breadcrumb) {
      var fn, _ref;
      $scope.operationalProject = (operationalProject != null ? operationalProject.data : void 0) || {
        mopTargetId: $routeParams.targetId,
        organisationId: operationalPlan.data.organisationId,
        financialYearId: operationalPlan.data.financialYearId
      };
      $scope.operationalPlan = operationalPlan.data;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.financialPeriods = financialPeriods.data;
      $scope.mopSectors = mopSectors.data;
      $scope.mopProjectTypes = mopProjectTypes.data;
      $scope.mopProjectStages = mopProjectStages.data;
      $scope.fundingSources = fundingSources.data;
      $scope.fundingSourceGroups = fundingSourceGroups.data;
      $scope.mopkpis = mopkpis.data;
      $scope.operationalProject.mopTargetId = $routeParams.targetId;
      $scope.operationalProject.organisationId = operationalPlan.data.organisationId;
      $scope.operationalProject.misaFinancialYearId = operationalPlan.data.misaFinancialYearId;
      $scope.new_ops_actual = ((_ref = $scope.operationalProject) != null ? _ref.id : void 0) ? true : false;
      fn = function() {
        if ($scope.operationalProject.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveOperationalProject = function() {
        if ($scope.operationalProjectForm.$valid) {
          return fn()("api/operationalProject/", $scope.operationalProject).then(function(response) {
            $scope.operationalProject.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      return breadcrumb([
        {
          description: operationPlanDescription.data.name,
          url: "/operationalPlan/" + $routeParams.targetId + "/1"
        }, {
          description: 'Actuals',
          url: "/operationalPlans/" + $routeParams.targetId + "/projects"
        }
      ]);
    }
  ];

}).call(this);
