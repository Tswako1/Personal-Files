(function() {

  this.ProjectStakeHolderController = [
    '$scope', '$http', '$routeParams', 'notification', 'projectStakeHolder', 'projectDescription', 'organisations', 'breadcrumb', function($scope, $http, $routeParams, notification, projectStakeHolder, projectDescription, organisations, breadcrumb) {
      var fn, _ref;
      fn = function() {
        if ($scope.projectStakeHolder.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveProjectStakeHolder = function() {
        if ($scope.projectStakeHolderForm.$valid) {
          return fn()("api/projectStakeHolder/", $scope.projectStakeHolder).then(function(response) {
            $scope.projectStakeHolder = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.organisations = organisations.data;
      $scope.projectId = $routeParams.projectId;
      $scope.projectStakeHolder = (projectStakeHolder != null ? projectStakeHolder.data.projectStakeHolder : void 0) || {
        projectId: $routeParams.projectId
      };
      $scope.projectDescription = projectDescription.data;
      return breadcrumb([
        {
          description: projectDescription.data.name,
          url: "projectRegistration/" + $routeParams.projectId
        }, {
          description: 'Stake Holders',
          url: "projectRegistration/" + $routeParams.projectId + "/projectStakeHolderList"
        }, {
          description: (projectStakeHolder != null ? (_ref = projectStakeHolder.data) != null ? _ref.Name : void 0 : void 0) || "New Stake Holder",
          url: ""
        }
      ]);
    }
  ];

}).call(this);
