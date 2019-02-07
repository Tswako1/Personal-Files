(function() {

  this.InfrastructureRegisterOverviewController = [
    '$scope', '$http', '$routeParams', 'infrastructureRisks', 'infrastructureRegister', 'breadcrumb', function($scope, $http, $routeParams, infrastructureRisks, infrastructureRegister, breadcrumb) {
      $scope.infrastructureRegisterId = $routeParams.id;
      $scope.infrastructureRisks = infrastructureRisks.data.risks;
      $scope.infrastructureRegister = infrastructureRegister.data[0];
      $scope.autoir = (infrastructureRegister != null ? infrastructureRegister.data[0] : void 0) ? "IR-" + (infrastructureRegister != null ? infrastructureRegister.data[0].assetClass.code : void 0) + "-" + (infrastructureRegister != null ? infrastructureRegister.data[0].autoNumber : void 0) : void 0;
      return breadcrumb([
        {
          description: infrastructureRegister.data[0].description
        }
      ]);
    }
  ];

}).call(this);
