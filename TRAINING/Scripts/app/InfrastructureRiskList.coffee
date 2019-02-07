# CoffeeScript
@InfrastructureRiskListController = ['$scope', '$http', '$routeParams', 'infrastructureRisks','infrastructureRiskDescription', 'breadcrumb', ($scope, $http, $routeParams, infrastructureRisks,infrastructureRiskDescription, breadcrumb) ->
  $scope.infrastructureRegisterId = $routeParams.id
  $scope.infrastructureRisks = infrastructureRisks.data.risks
  $scope.infrastructureRiskDescription = infrastructureRiskDescription.data
  
  breadcrumb([
    { description: infrastructureRisks.data.infrastructureRegister.description, url: "infrastructureRegister/#{$routeParams.id}" },
    { description: 'Risks', url: "infrastructureRegister/#{infrastructureRisks.data.infrastructureRegister.id}/infrastructureRisk" }
  ])

]
