# CoffeeScript
@ProjectStakeHolderListController = ['$scope', '$http', '$routeParams', 'projectStakeHolders','projectDescription', 'breadcrumb', ($scope, $http, $routeParams, projectStakeHolders,projectDescription, breadcrumb) ->
  $scope.projectId = $routeParams.id
  $scope.projectStakeHolders = projectStakeHolders.data.projectStakeHolders
  $scope.projectDescription = projectDescription.data
  
  breadcrumb([
    { description: projectDescription.data.name, url: "projectRegistration/#{$routeParams.id}" },
    { description: 'Stake Holders', url: "projectRegistration/#{projectStakeHolders.data.project.id}/projectStakeHolderList" }
  ])

]
