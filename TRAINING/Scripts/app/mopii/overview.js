(function() {

  this.MopiiOverviewController = [
    '$scope', '$http', '$routeParams', 'notification', 'plan', 'docs', 'mOPIIProjects', 'breadcrumb', function($scope, $http, $routeParams, notification, plan, docs, mOPIIProjects, breadcrumb) {
      $scope.plan = (plan != null ? plan.data : void 0) || {};
      $scope.docs = (docs != null ? docs.data : void 0) || {};
      $scope.mOPIIProjects = (mOPIIProjects != null ? mOPIIProjects.data : void 0) || {};
      return breadcrumb([
        {
          description: 'Operations',
          url: "operations/plans"
        }
      ]);
    }
  ];

}).call(this);
