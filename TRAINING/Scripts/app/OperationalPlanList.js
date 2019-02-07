(function() {

  this.planFilters = {};

  this.OperationalPlanListController = [
    '$scope', '$http', 'operationalPlan', 'organisations', 'financialYears', 'breadcrumb', function($scope, $http, operationalPlan, organisations, financialYears, breadcrumb) {
      var filter, i;
      $scope.operationalPlans = operationalPlan.data;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.page = 1;
      $scope.pages = (function() {
        var _i, _ref, _results;
        _results = [];
        for (i = _i = 1, _ref = Math.ceil(operationalPlan.data.count / 10.0); 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
          _results.push(i);
        }
        return _results;
      })();
      $scope.filters = planFilters;
      filter = function(page) {
        var params;
        $scope.serverFilter = $scope.filter;
        params = {};
        angular.copy($scope.filters, params);
        return $http.get("api/operationalPlan/", {
          params: angular.extend(params, {
            filter: $scope.filter || "",
            page: page || 1,
            sort: $scope.field,
            desc: $scope.desc
          })
        }).then(function(response) {
          $scope.page = page || 1;
          $scope.pages = (function() {
            var _i, _ref, _results;
            _results = [];
            for (i = _i = 1, _ref = Math.max(1, Math.ceil(response.data.count / 10.0)); 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
              _results.push(i);
            }
            return _results;
          })();
          return $scope.operationalPlans = response.data;
        });
      };
      $scope.sort = function(field) {
        if ($scope.field === field) {
          $scope.desc = !$scope.desc;
        } else {
          $scope.desc = false;
          $scope.field = field;
        }
        return filter();
      };
      $scope.search = filter;
      $scope.clearSearch = function() {
        $scope.filter = null;
        return filter();
      };
      $scope.$watch('filters', function(value) {
        if (value) {
          return filter();
        }
      }, true);
      $scope.gotoPage = function(x) {
        if (x < 1 || x > $scope.pages.length) {
          return;
        }
        $scope.page = x;
        return filter(x);
      };
      return breadcrumb([
        {
          description: 'Municipal Operational Plans'
        }
      ]);
    }
  ];

}).call(this);
