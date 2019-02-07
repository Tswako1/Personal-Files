(function() {

  this.ProjectQualityControlController = [
    '$scope', '$http', '$routeParams', 'checks', 'projectDescription', 'breadcrumb', 'notification', function($scope, $http, $routeParams, checks, projectDescription, breadcrumb, notification) {
      $scope.checks = checks.data;
      $scope.projectDescription = projectDescription.data;
      $scope.save = function() {
        return $http.put('api/ProjectQualityChecks', $scope.checks).then(function(response) {
          return notification('Successfully saved');
        });
      };
      return breadcrumb([
        {
          description: projectDescription.data.name,
          url: "projectRegistration/" + $routeParams.id
        }, {
          description: 'Quality Control',
          url: "projectRegistration/" + $routeParams.id + "/qualityControl"
        }
      ]);
    }
  ];

}).call(this);
