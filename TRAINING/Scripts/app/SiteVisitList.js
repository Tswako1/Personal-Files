(function() {

  this.SiteVisitListController = [
    '$scope', '$http', '$routeParams', 'siteVisits', 'projectDescription', 'breadcrumb', function($scope, $http, $routeParams, siteVisits, projectDescription, breadcrumb) {
      $scope.projectId = $routeParams.id;
      $scope.siteVisits = siteVisits.data;
      $scope.projectDescription = projectDescription.data;
      return breadcrumb([
        {
          description: projectDescription.data.name,
          url: "/projectRegistration/" + $routeParams.id
        }, {
          description: 'Activity Schedules'
        }
      ]);
    }
  ];

}).call(this);
