(function() {

  this.FundingSourceGroupListController = [
    '$scope', '$http', 'fundingSourceGroups', 'breadcrumb', function($scope, $http, fundingSourceGroups, breadcrumb) {
      $scope.fundingSourceGroups = fundingSourceGroups.data;
      $scope.search = function() {
        return $http.get("api/fundingSourceGroup/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.fundingSourceGroups = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Funding Source Groups'
        }
      ]);
    }
  ];

}).call(this);
