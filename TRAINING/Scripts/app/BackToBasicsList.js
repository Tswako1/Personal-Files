(function() {

  this.BackToBasicsListController = [
    '$scope', '$http', 'backToBasics', 'organisations', 'financialYears', 'financialPeriods', 'breadcrumb', function($scope, $http, backToBasics, organisations, financialYears, financialPeriods, breadcrumb) {
      $scope.backToBasics = backToBasics.data;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.financialPeriods = financialPeriods.data;
      $scope.search = function() {
        var params;
        params = {};
        angular.copy($scope.filters, params);
        params.filter = $scope.filter;
        return $http.get("api/backToBasics/", {
          params: params
        }).then(function(response) {
          return $scope.backToBasics = response.data;
        });
      };
      $scope.$watch('filters', function(value) {
        if (value) {
          return $scope.search();
        }
      }, true);
      return breadcrumb([
        {
          description: 'Back to Basics'
        }
      ]);
    }
  ];

}).call(this);
