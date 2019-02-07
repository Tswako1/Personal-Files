(function() {

  this.DevelopmentalLocationController = [
    '$scope', '$http', '$routeParams', 'notification', 'developmentalLocation', 'breadcrumb', function($scope, $http, $routeParams, notification, developmentalLocation, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.developmentalLocation.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveDevelopmentalLocation = function() {
        if ($scope.developmentalLocationForm.$valid) {
          return fn()("api/developmentalLocation/", $scope.developmentalLocation).then(function(response) {
            $scope.developmentalLocation = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.developmentalLocation = (developmentalLocation != null ? developmentalLocation.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Developmental Locations',
          url: "administration/developmentalLocationList"
        }
      ]);
    }
  ];

}).call(this);
