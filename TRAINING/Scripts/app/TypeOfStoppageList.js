(function() {

  this.TypeOfStoppageListController = [
    '$scope', '$http', 'typesOfStoppage', 'breadcrumb', function($scope, $http, typesOfStoppage, breadcrumb) {
      $scope.typesOfStoppage = typesOfStoppage.data;
      $scope.search = function() {
        return $http.get("api/typeOfStoppage/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.typesOfStoppage = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Types of Stoppages'
        }
      ]);
    }
  ];

}).call(this);
