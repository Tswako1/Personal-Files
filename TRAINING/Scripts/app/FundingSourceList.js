(function() {

  this.FundingSourceListController = [
    '$scope', '$http', 'fundingSources', 'breadcrumb', function($scope, $http, fundingSources, breadcrumb) {
      $scope.fundingSources = fundingSources.data;
      $scope.search = function() {
        return $http.get("api/fundingSource/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.fundingSources = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Funding Sources'
        }
      ]);
    }
  ];

}).call(this);
