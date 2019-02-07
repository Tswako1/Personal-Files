(function() {

  this.MOPProjectTypeListController = [
    '$scope', '$http', 'mOPProjectTypes', 'breadcrumb', function($scope, $http, mOPProjectTypes, breadcrumb) {
      $scope.mOPProjectTypes = mOPProjectTypes.data;
      $scope.search = function() {
        return $http.get("api/mOPProjectType/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPProjectTypes = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'MOP Project Type'
        }
      ]);
    }
  ];

}).call(this);
