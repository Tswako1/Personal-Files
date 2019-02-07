(function() {

  this.MigComponentListController = [
    '$scope', '$http', 'migComponents', 'breadcrumb', function($scope, $http, migComponents, breadcrumb) {
      $scope.migComponents = migComponents.data;
      $scope.search = function() {
        return $http.get("api/migComponent/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.migComponents = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Mig Components'
        }
      ]);
    }
  ];

}).call(this);
