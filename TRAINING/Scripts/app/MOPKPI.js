(function() {

  this.MOPKPIController = [
    '$scope', '$http', '$routeParams', 'notification', 'mOPKPI', 'breadcrumb', function($scope, $http, $routeParams, notification, mOPKPI, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.mOPKPI.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPKPI = function() {
        if ($scope.mOPKPIForm.$valid) {
          return fn()("api/mOPKPI/", $scope.mOPKPI).then(function(response) {
            $scope.mOPKPI = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPKPI = (mOPKPI != null ? mOPKPI.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'MOP KPIs',
          url: "administration/mOPKPIList"
        }
      ]);
    }
  ];

}).call(this);
