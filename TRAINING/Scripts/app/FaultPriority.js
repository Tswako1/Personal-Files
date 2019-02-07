(function() {

  this.FaultPriorityController = [
    '$scope', '$http', 'notification', 'faultPriority', 'faultEscalationTimes', 'breadcrumb', function($scope, $http, notification, faultPriority, faultEscalationTimes, breadcrumb) {
      var fn;
      $scope.faultPriority = faultPriority != null ? faultPriority.data[0] : void 0;
      $scope.faultEscalationTimes = faultEscalationTimes.data;
      $scope.isUpdate = faultPriority !== null;
      fn = function() {
        if ($scope.faultPriority.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.save = function() {
        if ($scope.faultPriorityForm.$valid) {
          return fn()("api/faultPriority/", $scope.faultPriority).then(function(response) {
            $scope.faultPriority.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      return breadcrumb([
        {
          description: 'Fault Priorities',
          url: '/administration/faultPriorityList'
        }, {
          description: 'Create'
        }
      ]);
    }
  ];

}).call(this);
