@InfrastructureRegisterOverviewController = ['$scope', '$http', '$routeParams', 'infrastructureRisks','infrastructureRegister', 'breadcrumb', ($scope, $http, $routeParams, infrastructureRisks,infrastructureRegister,breadcrumb) ->
  $scope.infrastructureRegisterId = $routeParams.id
  $scope.infrastructureRisks = infrastructureRisks.data.risks
  $scope.infrastructureRegister = infrastructureRegister.data[0]
  $scope.autoir = if infrastructureRegister?.data[0]
        "IR-" + infrastructureRegister?.data[0].assetClass.code + "-" + infrastructureRegister?.data[0].autoNumber   

  breadcrumb([description: infrastructureRegister.data[0].description])


]
# CoffeeScript
