(function() {

  this.MOPSectorController = [
    '$scope', '$http', '$routeParams', 'notification', 'mOPSector', 'breadcrumb', function($scope, $http, $routeParams, notification, mOPSector, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.mOPSector.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPSector = function() {
        if ($scope.mOPSectorForm.$valid) {
          return fn()("api/mOPSector/", $scope.mOPSector).then(function(response) {
            $scope.mOPSector = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPSector = (mOPSector != null ? mOPSector.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'MOP Sector',
          url: "administration/mOPSectorList"
        }
      ]);
    }
  ];

}).call(this);
