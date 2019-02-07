(function() {

  this.InfrastructureRiskListController = [
    '$scope', '$http', '$routeParams', 'infrastructureRisks', 'infrastructureRiskDescription', 'breadcrumb', function($scope, $http, $routeParams, infrastructureRisks, infrastructureRiskDescription, breadcrumb) {
      $scope.infrastructureRegisterId = $routeParams.id;
      $scope.infrastructureRisks = infrastructureRisks.data.risks;
      $scope.infrastructureRiskDescription = infrastructureRiskDescription.data;
      return breadcrumb([
        {
          description: infrastructureRisks.data.infrastructureRegister.description,
          url: "infrastructureRegister/" + $routeParams.id
        }, {
          description: 'Risks',
          url: "infrastructureRegister/" + infrastructureRisks.data.infrastructureRegister.id + "/infrastructureRisk"
        }
      ]);
    }
  ];

}).call(this);
