(function() {

  this.InfrastructureRiskController = [
    '$scope', '$http', '$routeParams', 'notification', 'riskTypes', 'riskConsequences', 'riskProbabilities', 'infrastructureRisk', 'infrastructureRiskDescription', 'breadcrumb', function($scope, $http, $routeParams, notification, riskTypes, riskConsequences, riskProbabilities, infrastructureRisk, infrastructureRiskDescription, breadcrumb) {
      var fn, _ref;
      fn = function() {
        if ($scope.infrastructureRisk.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveInfrastructureRisk = function() {
        if ($scope.infrastructureRiskForm.$valid) {
          return fn()("api/infrastructureRisk/", $scope.infrastructureRisk).then(function(response) {
            $scope.infrastructureRisk = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.infrastructureRegisterId = $routeParams.id;
      $scope.infrastructureRisk = (infrastructureRisk != null ? infrastructureRisk.data.risk : void 0) || {
        infrastructureRegisterId: $routeParams.id
      };
      $scope.riskTypes = riskTypes.data;
      $scope.riskConsequences = riskConsequences.data;
      $scope.riskProbabilities = riskProbabilities.data;
      $scope.infrastructureRiskDescription = infrastructureRiskDescription.data;
      return breadcrumb([
        {
          description: infrastructureRiskDescription.data.description,
          url: "infrastructureRegister/" + $routeParams.id
        }, {
          description: 'Risks',
          url: "infrastructureRegister/" + $routeParams.id + "/infrastructureRisk"
        }, {
          description: (infrastructureRisk != null ? (_ref = infrastructureRisk.data) != null ? _ref.risk.description : void 0 : void 0) || "New Risk",
          url: ""
        }
      ]);
    }
  ];

}).call(this);
