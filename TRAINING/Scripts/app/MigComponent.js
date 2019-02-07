(function() {

  this.MigComponentController = [
    '$scope', '$http', '$routeParams', 'notification', 'migComponent', 'breadcrumb', function($scope, $http, $routeParams, notification, migComponent, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.migComponent.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMigComponent = function() {
        if ($scope.migComponentForm.$valid) {
          return fn()("api/migComponent/", $scope.migComponent).then(function(response) {
            $scope.migComponent = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.migComponent = (migComponent != null ? migComponent.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Mig Components',
          url: "administration/migComponentList"
        }
      ]);
    }
  ];

}).call(this);
