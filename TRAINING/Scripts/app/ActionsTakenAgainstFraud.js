(function() {

  this.ActionsTakenAgainstFraudController = [
    '$scope', '$http', '$routeParams', 'notification', 'actionsTakenAgainstFraud', 'breadcrumb', function($scope, $http, $routeParams, notification, actionsTakenAgainstFraud, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.actionsTakenAgainstFraud.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveActionsTakenAgainstFraud = function() {
        if ($scope.actionsTakenAgainstFraudForm.$valid) {
          return fn()("api/actionsTakenAgainstFraud/", $scope.actionsTakenAgainstFraud).then(function(response) {
            $scope.actionsTakenAgainstFraud = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.actionsTakenAgainstFraud = (actionsTakenAgainstFraud != null ? actionsTakenAgainstFraud.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Actions Taken Against Fraud',
          url: "administration/actionsTakenAgainstFraudList"
        }
      ]);
    }
  ];

}).call(this);
