(function() {

  this.SiteVisitController = [
    '$scope', '$route', '$http', 'notification', 'siteVisit', 'people', 'breadcrumb', '$routeParams', function($scope, $route, $http, notification, siteVisit, people, breadcrumb, $routeParams) {
      var fn, _ref, _ref1;
      $scope.siteVisit = siteVisit.data[0];
      $scope.people = people.data;
      fn = function() {
        if ($scope.siteVisit.siteVisit.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveSiteVisitSchedule = function() {
        if ($scope.siteVisitScheduleForm.$valid) {
          $scope.siteVisit.siteVisit.projectId = $scope.siteVisit.projectId;
          return fn()("api/siteVisit/", $scope.siteVisit.siteVisit).then(function(response) {
            $scope.siteVisit.siteVisit = response.data;
            $scope.siteVisit.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      return breadcrumb([
        {
          description: siteVisit.data[0].projectName,
          url: "/projectRegistration/" + siteVisit.data[0].projectId
        }, {
          description: 'Activity Schedules',
          url: "/projectRegistration/" + siteVisit.data[0].projectId + "/siteVisitList"
        }, {
          description: ((_ref = $scope.siteVisit) != null ? (_ref1 = _ref.siteVisit) != null ? _ref1.description : void 0 : void 0) || "New Activity Schedule"
        }
      ]);
    }
  ];

}).call(this);
