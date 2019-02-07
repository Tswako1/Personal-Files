(function() {

  this.ProjectRiskListController = [
    '$scope', '$http', '$routeParams', 'projectRisks', 'projectDescription', 'breadcrumb', function($scope, $http, $routeParams, projectRisks, projectDescription, breadcrumb) {
      $scope.projectId = $routeParams.id;
      $scope.projectRisks = projectRisks.data.risks;
      $scope.projectDescription = projectDescription.data;
      return breadcrumb([
        {
          description: projectDescription.data.name,
          url: "projectRegistration/" + $routeParams.id
        }, {
          description: 'Risks',
          url: "projectRegistration/" + projectRisks.data.project.id + "/riskList"
        }
      ]);
    }
  ];

}).call(this);
