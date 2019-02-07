(function() {

  this.IndicatorItemController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicatorItem', 'breadcrumb', function($scope, $http, $routeParams, notification, indicatorItem, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.indicatorItem.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveIndicatorItem = function() {
        if ($scope.indicatorItemForm.$valid) {
          return fn()("api/indicatorItem/", $scope.indicatorItem).then(function(response) {
            $scope.indicatorItem = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.indicatorItem = (indicatorItem != null ? indicatorItem.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Indicator Items',
          url: "administration/indicatorItemList"
        }
      ]);
    }
  ];

}).call(this);
