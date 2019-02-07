(function() {

  this.ProjectActivitiesController = [
    '$scope', '$http', '$routeParams', 'notification', 'project', 'breadcrumb', function($scope, $http, $routeParams, notification, project, breadcrumb) {
      var end, now, start, validate;
      $scope.saveProjectActivities = function() {
        if ($scope.projectActivitiesForm.$valid) {
          $http.put("api/projectActivities/", $scope.project);
          return notification("Successfully saved");
        }
      };
      $scope.project = project.data[0];
      start = Date.parse($scope.project.startDate);
      end = Date.parse($scope.project.endDate);
      now = new Date();
      validate = function(startName, endName, completeName) {
        var double, validateEnd, validateStart;
        double = false;
        validateStart = function(x) {
          var date, to, valid;
          date = Date.parse(x);
          valid = !x || (date >= start && date <= end);
          $scope.projectActivitiesForm[startName].$setValidity("min", valid);
          if (!$scope.project[endName] || double) {
            return;
          }
          to = Date.parse($scope.project[endName]);
          $scope.projectActivitiesForm[startName].$setValidity("min", valid && date <= to);
          double = true;
          validateEnd($scope.project[endName]);
          return double = false;
        };
        validateEnd = function(x) {
          var date, from, valid;
          date = Date.parse(x);
          valid = !x || (date >= start && date <= end);
          $scope.projectActivitiesForm[endName].$setValidity("min", valid);
          if (!$scope.project[startName] || double) {
            return;
          }
          from = Date.parse($scope.project[startName]);
          $scope.projectActivitiesForm[endName].$setValidity("min", valid && date >= from);
          double = true;
          validateStart($scope.project[startName]);
          return double = false;
        };
        $scope.$watch('project.' + startName, validateStart);
        $scope.$watch('project.' + endName, validateEnd);
        return $scope.$watch('project.' + completeName, function(x) {
          var date;
          date = Date.parse(x);
          return $scope.projectActivitiesForm[completeName].$setValidity("min", !x || date <= now);
        });
      };
      validate('activityEstablishSteeringCommitteeStartDate', 'activityEstablishSteeringCommitteeEndDate', 'activityEstablishSteeringCommitteeCompleteDate');
      validate('activityDesignStartDate', 'activityDesignEndDate', 'activityDesignCompleteDate');
      validate('activityTenderStartDate', 'activityTenderEndDate', 'activityTenderCompleteDate');
      validate('activityConstructionStartDate', 'activityConstructionEndDate', 'activityConstructionCompleteDate');
      validate('activityCompletionStartDate', 'activityCompletionEndDate', 'activityCompletionCompleteDate');
      return breadcrumb([
        {
          description: project.data[0].name,
          url: "/projectRegistration/" + project.data[0].id
        }, {
          description: 'Project Gantt Chart'
        }
      ]);
    }
  ];

}).call(this);
