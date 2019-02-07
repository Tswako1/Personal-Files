(function() {

  this.FundingSourceController = [
    '$scope', '$http', '$routeParams', 'notification', 'fundingSource', 'fundingSourceGroups', 'breadcrumb', function($scope, $http, $routeParams, notification, fundingSource, fundingSourceGroups, breadcrumb) {
      var fn;
      $scope.fundingSourceGroups = fundingSourceGroups.data;
      fn = function() {
        if ($scope.fundingSource.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveFundingSource = function() {
        if ($scope.fundingSourceForm.$valid) {
          return fn()("api/fundingSource/", $scope.fundingSource).then(function(response) {
            $scope.fundingSource = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.fundingSource = (fundingSource != null ? fundingSource.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Funding Sources',
          url: "administration/fundingSourceList"
        }
      ]);
    }
  ];

}).call(this);
