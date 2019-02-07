(function() {

  this.ProjectController = [
    '$scope', 'project', function($scope, project) {
      return $scope.project = project.data[0];
    }
  ];

}).call(this);
