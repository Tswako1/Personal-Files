# CoffeeScript
@ProjectRiskListController = ['$scope', '$http', '$routeParams', 'projectRisks','projectDescription', 'breadcrumb', ($scope, $http, $routeParams, projectRisks,projectDescription, breadcrumb) ->
  $scope.projectId = $routeParams.id
  $scope.projectRisks = projectRisks.data.risks
  $scope.projectDescription = projectDescription.data
  
  breadcrumb([
    { description: projectDescription.data.name, url: "projectRegistration/#{$routeParams.id}" },
    { description: 'Risks', url: "projectRegistration/#{projectRisks.data.project.id}/riskList" }
  ])

]
