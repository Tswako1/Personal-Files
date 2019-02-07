(function() {

  this.ProjectRiskController = [
    '$scope', '$http', '$routeParams', 'notification', 'projectRiskTypes', 'projectRiskCategories', 'riskConsequences', 'riskProbabilities', 'projectRisk', 'projectRiskDescription', 'projectDescription', 'people', 'breadcrumb', function($scope, $http, $routeParams, notification, projectRiskTypes, projectRiskCategories, riskConsequences, riskProbabilities, projectRisk, projectRiskDescription, projectDescription, people, breadcrumb) {
      var fn, _ref;
      fn = function() {
        if ($scope.projectRisk.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveProjectRisk = function() {
        if ($scope.projectRiskForm.$valid) {
          return fn()("api/projectRisk/", $scope.projectRisk).then(function(response) {
            $scope.projectRisk.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      $scope.projectId = $routeParams.projectId;
      $scope.projectRisk = (projectRisk != null ? projectRisk.data.risk : void 0) || {
        projectId: $routeParams.projectId
      };
      $scope.projectRiskTypes = projectRiskTypes.data;
      $scope.riskConsequences = riskConsequences.data;
      $scope.riskProbabilities = riskProbabilities.data;
      $scope.projectRiskDescription = projectRiskDescription != null ? projectRiskDescription.data : void 0;
      $scope.projectDescription = projectDescription.data;
      $scope.people = people.data;
      if (projectRisk) {
        $scope.projectRiskTypeId = projectRiskCategories.data.filter(function(x) {
          return x.id === projectRisk.data.risk.projectRiskCategoryId;
        })[0].projectRiskTypeId;
      }
      $scope.$watch('projectRiskTypeId', function(value) {
        return $scope.projectRiskCategories = projectRiskCategories.data.filter(function(x) {
          return x.projectRiskTypeId === value;
        });
      });
      return breadcrumb([
        {
          description: projectDescription.data.name,
          url: "projectRegistration/" + $routeParams.projectId
        }, {
          description: 'Risks',
          url: "projectRegistration/" + $routeParams.projectId + "/riskList"
        }, {
          description: (projectRisk != null ? (_ref = projectRisk.data) != null ? _ref.risk.description : void 0 : void 0) || "New Risk",
          url: ""
        }
      ]);
    }
  ];

}).call(this);
