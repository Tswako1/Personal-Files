(function() {

  this.MOPIIKPIController = [
    '$scope', '$http', '$routeParams', 'notification', 'mOPIIKPI', 'mISAFinancialYears', 'breadcrumb', function($scope, $http, $routeParams, notification, mOPIIKPI, mISAFinancialYears, breadcrumb) {
      var fn;
      $scope.mISAFinancialYears = mISAFinancialYears.data;
      fn = function() {
        if ($scope.mOPIIKPI.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPIIKPI = function() {
        if ($scope.mOPIIKPIForm.$valid) {
          return fn()("api/mOPIIKPI/", $scope.mOPIIKPI).then(function(response) {
            $scope.mOPIIKPI = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPIIKPI = (mOPIIKPI != null ? mOPIIKPI.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'MOP KPIs',
          url: "administration/mOPIIKPIList"
        }
      ]);
    }
  ];

}).call(this);
