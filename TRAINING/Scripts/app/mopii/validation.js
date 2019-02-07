(function() {

  this.MopiiValidationController = [
    '$scope', '$http', '$routeParams', 'notification', 'plan', 'breadcrumb', function($scope, $http, $routeParams, notification, plan, breadcrumb) {
      $scope.save = function() {
        if ($scope.planForm.$valid) {
          return $http.put("api/mopii/validation", $scope.plan).then(function(response) {
            return notification("Successfully saved");
          });
        }
      };
      $scope.savenational = function() {
        if ($scope.planForm.$valid) {
          return $http.put("api/mopii/nationalvalidation", $scope.plan).then(function(response) {
            return notification("Successfully saved");
          });
        }
      };
      $scope.plan = (plan != null ? plan.data : void 0) || {};
      return breadcrumb([
        {
          description: 'Operations',
          url: "operations/plans"
        }
      ]);
    }
  ];

}).call(this);
