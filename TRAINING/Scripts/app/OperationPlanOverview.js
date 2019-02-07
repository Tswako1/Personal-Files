(function() {

  this.OperationalOverviewController = [
    '$scope', '$http', '$routeParams', '$location', 'operation', 'notification', 'documentTypes', 'operationalPlan', 'operationalActuals', 'operationalProjects', 'operationPlanDocumentsQ1', 'operationPlanDocumentsQ2', 'operationPlanDocumentsQ3', 'operationPlanDocumentsQ4', function($scope, $http, $routeParams, $location, operation, notification, documentTypes, operationalPlan, operationalActuals, operationalProjects, operationPlanDocumentsQ1, operationPlanDocumentsQ2, operationPlanDocumentsQ3, operationPlanDocumentsQ4) {
      var fn, params, _ref;
      $scope.operationalActuals = operationalActuals.data[0];
      $scope.operationalPlan = operationalPlan.data;
      $scope.operationalProjects = operationalProjects.data;
      $scope.operationPlanDocumentsQ1 = operationPlanDocumentsQ1.data;
      $scope.operationPlanDocumentsQ2 = operationPlanDocumentsQ2.data;
      $scope.operationPlanDocumentsQ3 = operationPlanDocumentsQ3.data;
      $scope.operationPlanDocumentsQ4 = operationPlanDocumentsQ4.data;
      $scope.documentTypes = documentTypes.data;
      $scope.new_ops_plan = ((_ref = $scope.operationalPlan) != null ? _ref.id : void 0) ? true : false;
      params = {};
      fn = function() {
        if ($scope.operationalPlan.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      return $scope.saveDocumentValidation = function() {
        if ($scope.mopDocumentValidation.$valid) {
          return fn()("api/document/", {
            mOPDocumentsQ1: $scope.operationPlanDocumentsQ1,
            mOPDocumentsQ2: $scope.operationPlanDocumentsQ2,
            mOPDocumentsQ3: $scope.operationPlanDocumentsQ3,
            mOPDocumentsQ4: $scope.operationPlanDocumentsQ4
          }).then(function(response) {
            return notification("Successfully saved");
          });
        }
      };
    }
  ];

}).call(this);
