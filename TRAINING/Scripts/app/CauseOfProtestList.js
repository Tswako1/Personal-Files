(function() {

  this.CauseOfProtestListController = [
    '$scope', '$http', 'causesOfProtest', 'breadcrumb', function($scope, $http, causesOfProtest, breadcrumb) {
      $scope.causesOfProtest = causesOfProtest.data;
      $scope.search = function() {
        return $http.get("api/causeOfProtest/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.causesOfProtest = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Causes of Protests'
        }
      ]);
    }
  ];

}).call(this);
