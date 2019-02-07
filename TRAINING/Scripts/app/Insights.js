(function() {

  this.InsightController = [
    '$scope', '$http', 'insights', 'breadcrumb', function($scope, $http, insights, breadcrumb) {
      $scope.projectInsights = insights.data.filter(function(x) {
        return x.module === 2;
      });
      $scope.infrastructureInsights = insights.data.filter(function(x) {
        return x.module === 1;
      });
      return breadcrumb([]);
    }
  ];

}).call(this);
