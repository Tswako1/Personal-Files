(function() {

  this.IndicatorItemListController = [
    '$scope', '$http', 'indicatorItems', 'breadcrumb', function($scope, $http, indicatorItems, breadcrumb) {
      $scope.indicatorItems = indicatorItems.data;
      $scope.search = function() {
        return $http.get("api/indicatorItem/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.indicatorItems = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Indicator Items'
        }
      ]);
    }
  ];

}).call(this);
