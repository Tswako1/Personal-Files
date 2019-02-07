(function() {

  this.MOPIIProcessController = [
    '$scope', '$http', '$routeParams', 'notification', 'mOPIIProcess', 'mOPIISections', 'breadcrumb', function($scope, $http, $routeParams, notification, mOPIIProcess, mOPIISections, breadcrumb) {
      var fn;
      $scope.mOPIISections = mOPIISections.data;
      fn = function() {
        if ($scope.mOPIIProcess.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPIIProcess = function() {
        if ($scope.mOPIIProcessForm.$valid) {
          return fn()("api/mOPIIProcess/", $scope.mOPIIProcess).then(function(response) {
            $scope.mOPIIProcess = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPIIProcess = (mOPIIProcess != null ? mOPIIProcess.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'MOP Process',
          url: "administration/mOPIIProcessList"
        }
      ]);
    }
  ];

}).call(this);
