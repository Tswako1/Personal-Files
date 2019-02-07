(function() {

  this.AssetClassController = [
    '$scope', '$http', '$routeParams', 'notification', 'assetClass', 'breadcrumb', function($scope, $http, $routeParams, notification, assetClass, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.assetClass.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveAssetClass = function() {
        if ($scope.assetClassForm.$valid) {
          return fn()("api/assetClass/", $scope.assetClass).then(function(response) {
            $scope.assetClass = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.assetClass = (assetClass != null ? assetClass.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Asset Classes',
          url: "administration/assetClassList"
        }
      ]);
    }
  ];

}).call(this);
