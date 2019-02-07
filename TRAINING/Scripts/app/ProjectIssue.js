(function() {

  this.ProjectIssueController = [
    '$scope', '$http', '$routeParams', 'notification', 'issueSeverity', 'issueProbability', 'projectIssue', 'projectIssueDescription', 'projectDescription', 'people', 'breadcrumb', function($scope, $http, $routeParams, notification, issueSeverity, issueProbability, projectIssue, projectIssueDescription, projectDescription, people, breadcrumb) {
      var fn, _ref;
      fn = function() {
        if ($scope.projectIssue.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveProjectIssue = function() {
        if ($scope.projectIssueForm.$valid) {
          return fn()("api/projectIssue/", $scope.projectIssue).then(function(response) {
            $scope.projectIssue.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      $scope.projectId = $routeParams.projectId;
      $scope.projectIssue = (projectIssue != null ? projectIssue.data.issue : void 0) || {
        projectId: $routeParams.projectId
      };
      $scope.issueSeverities = issueSeverity.data;
      $scope.issueProbabilities = issueProbability.data;
      $scope.projectIssueDescription = projectIssueDescription != null ? projectIssueDescription.data : void 0;
      $scope.projectDescription = projectDescription.data;
      $scope.people = people.data;
      return breadcrumb([
        {
          description: projectDescription.data.name,
          url: "projectRegistration/" + $routeParams.projectId
        }, {
          description: 'Issues',
          url: "projectRegistration/" + $routeParams.projectId + "/issueList"
        }, {
          description: (projectIssue != null ? (_ref = projectIssue.data) != null ? _ref.issue.description : void 0 : void 0) || "New Issue",
          url: ""
        }
      ]);
    }
  ];

}).call(this);
