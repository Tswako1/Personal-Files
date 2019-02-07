(function() {

  this.MOPIIProjectController = [
    '$scope', '$http', '$routeParams', '$location', 'operation', 'notification', 'operationalPlan', 'mOPIIProject', 'organisations', 'financialYears', 'financialPeriods', 'mopSectors', 'mopProjectTypes', 'mopProjectStages', 'fundingSources', 'fundingSourceGroups', 'mopkpis', 'operationPlanDescription', 'breadcrumb', function($scope, $http, $routeParams, $location, operation, notification, operationalPlan, mOPIIProject, organisations, financialYears, financialPeriods, mopSectors, mopProjectTypes, mopProjectStages, fundingSources, fundingSourceGroups, mopkpis, operationPlanDescription, breadcrumb) {
      var fn, _ref;
      $scope.mOPIIProject = (mOPIIProject != null ? mOPIIProject.data : void 0) || {
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
      $scope.mOPIIProject.mOPIIPlanId = $routeParams.targetId;
      $scope.mOPIIProject.organisationId = operationalPlan.data.organisationId;
      $scope.mOPIIProject.misaFinancialYearId = operationalPlan.data.yearId;
      $scope.new_ops_actual = ((_ref = $scope.mOPIIProject) != null ? _ref.id : void 0) ? true : false;
      fn = function() {
        if ($scope.mOPIIProject.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPIIProject = function() {
        if ($scope.mOPIIProjectForm.$valid) {
          if (operation('CreateOperationalPlan')) {
            return fn()("api/mOPIIProject/", $scope.mOPIIProject).then(function(response) {
              $scope.mOPIIProject.id = response.data.id;
              return notification("Successfully saved");
            });
          }
        }
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
