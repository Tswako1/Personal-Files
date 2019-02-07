(function() {

  this.CauseOfStoppageListController = [
    '$scope', '$http', 'causesOfStoppage', 'breadcrumb', function($scope, $http, causesOfStoppage, breadcrumb) {
      $scope.causesOfStoppage = causesOfStoppage.data;
      $scope.search = function() {
        return $http.get("api/causeOfStoppage/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.causesOfStoppages = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Causes of Stoppages'
        }
      ]);
    }
  ];

}).call(this);
