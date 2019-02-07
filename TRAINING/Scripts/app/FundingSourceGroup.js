(function() {

  this.FundingSourceGroupController = [
    '$scope', '$http', '$routeParams', 'notification', 'fundingSourceGroup', 'breadcrumb', function($scope, $http, $routeParams, notification, fundingSourceGroup, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.fundingSourceGroup.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveFundingSourceGroup = function() {
        if ($scope.fundingSourceGroupForm.$valid) {
          return fn()("api/fundingSourceGroup/", $scope.fundingSourceGroup).then(function(response) {
            $scope.fundingSourceGroup = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.fundingSourceGroup = (fundingSourceGroup != null ? fundingSourceGroup.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Funding Source Groups',
          url: "administration/fundingSourceGroupList"
        }
      ]);
    }
  ];

}).call(this);
