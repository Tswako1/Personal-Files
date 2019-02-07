(function() {

  this.OperationalActualsController = [
    '$scope', '$http', '$routeParams', '$location', 'operation', 'notification', 'documentTypes', 'operationalPlan', 'operationalActuals', 'operationalActual', 'organisations', 'financialYears', 'financialPeriods', 'operationPlanDescription', 'breadcrumb', function($scope, $http, $routeParams, $location, operation, notification, documentTypes, operationalPlan, operationalActuals, operationalActual, organisations, financialYears, financialPeriods, operationPlanDescription, breadcrumb) {
      var fn, _ref;
      $scope.operationalActual = (operationalActual != null ? operationalActual.data : void 0) || {
        operationalPlanTargetId: $routeParams.targetId,
        organisationId: operationalPlan.data.organisationId,
        financialYearId: operationalPlan.data.financialYearId
      };
      $scope.operationalPlan = operationalPlan.data;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.financialPeriods = financialPeriods.data;
      $scope.documentTypes = documentTypes.data;
      $scope.operationalActuals = operationalActuals.data[0];
      $scope.operationalActual.mopTargetId = $routeParams.targetId;
      $scope.operationalActual.organisationId = operationalPlan.data.organisationId;
      $scope.operationalActual.misaFinancialYearId = operationalPlan.data.misaFinancialYearId;
      $scope.new_ops_actual = ((_ref = $scope.operationalActual) != null ? _ref.id : void 0) ? true : false;
      fn = function() {
        if ($scope.operationalActual.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.getDocumentCount = function(documentType) {
        var doc;
        doc = $scope.operationalActual.projectDocuments.filter(function(item) {
          return item.documentType === documentType;
        });
        if (doc.length) {
          return doc[0].count;
        } else {
          return 0;
        }
      };
      $scope.saveOperationalActual = function() {
        if ($scope.operationalActualForm.$valid) {
          return fn()("api/operationalActual/", $scope.operationalActual).then(function(response) {
            $scope.operationalActual.id = response.data.id;
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
          url: "/operationalPlan/" + $routeParams.targetId + "/actuals"
        }
      ]);
    }
  ];

}).call(this);
