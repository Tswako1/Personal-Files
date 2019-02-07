(function() {

  this.FaultTypeController = [
    '$scope', '$http', 'notification', 'faultType', 'sectors', 'priorities', 'breadcrumb', function($scope, $http, notification, faultType, sectors, priorities, breadcrumb) {
      var fn;
      $scope.faultType = faultType != null ? faultType.data[0] : void 0;
      $scope.sectors = sectors.data;
      $scope.priorities = priorities.data;
      $scope.isUpdate = faultType !== null;
      fn = function() {
        if ($scope.faultType.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.save = function() {
        if ($scope.faultTypeForm.$valid) {
          return fn()("api/FaultType/", $scope.faultType).then(function(response) {
            $scope.faultType.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      return breadcrumb([
        {
          description: 'Fault Types',
          url: '/administration/faultTypeList'
        }, {
          description: 'Create'
        }
      ]);
    }
  ];

}).call(this);
