(function() {

  this.ActionsTakenAgainstFraudListController = [
    '$scope', '$http', 'actionsTakenAgainstFraud', 'breadcrumb', function($scope, $http, actionsTakenAgainstFraud, breadcrumb) {
      $scope.actionsTakenAgainstFraud = actionsTakenAgainstFraud.data;
      $scope.search = function() {
        return $http.get("api/actionsTakenAgainstFraud/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.faultPriorities = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Actions Taken Against Fraud'
        }
      ]);
    }
  ];

}).call(this);
