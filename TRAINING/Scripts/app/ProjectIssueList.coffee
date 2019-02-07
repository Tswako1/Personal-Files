﻿# CoffeeScript
@ProjectIssueListController = ['$scope', '$http', '$routeParams', 'projectIssues','projectDescription', 'breadcrumb', ($scope, $http, $routeParams, projectIssues, projectDescription, breadcrumb) ->
  $scope.projectId = $routeParams.id
  $scope.projectIssues = projectIssues.data.issues
  $scope.projectDescription = projectDescription.data
  
  breadcrumb([
    { description: projectDescription.data.name, url: "projectRegistration/#{$routeParams.id}" },
    { description: 'Issues', url: "projectRegistration/#{projectIssues.data.project.id}/issueList" }
  ])

]
