(function() {

  this.AssetClassListController = [
    '$scope', '$http', 'assetClasses', 'breadcrumb', function($scope, $http, assetClasses, breadcrumb) {
      $scope.assetClasses = assetClasses.data;
      $scope.search = function() {
        return $http.get("api/assetClass/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.assetClasses = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Asset Classes'
        }
      ]);
    }
  ];

}).call(this);
