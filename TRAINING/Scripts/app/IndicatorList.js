(function() {

  this.IndicatorListController = [
    '$scope', '$http', 'indicators', 'breadcrumb', function($scope, $http, indicators, breadcrumb) {
      $scope.indicators = indicators.data;
      return breadcrumb([
        {
          description: 'Indicators'
        }
      ]);
    }
  ];

  this.IndicatorTargetsController = [
    '$scope', '$http', '$routeParams', 'targets', 'breadcrumb', 'notification', function($scope, $http, $routeParams, targets, breadcrumb, notification) {
      $scope.targets = targets.data.targets.groupBy(function(x) {
        return x.financialYear;
      });
      $scope.save = function() {
        return $http.put('api/indicatorTargets', {
          indicatorId: $routeParams.id,
          targets: targets.data
        }).then(function() {
          return notification("Successfully saved");
        });
      };
      return breadcrumb([
        {
          description: 'Indicators',
          url: '/administration/indicators'
        }, {
          description: targets.data.description
        }
      ]);
    }
  ];

}).call(this);
