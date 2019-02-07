(function() {

  this.FaultReportListController = [
    '$scope', '$http', 'faultReports', 'faultReportStatus', 'organisations', 'sectorProgrammes', 'breadcrumb', '$timeout', function($scope, $http, faultReports, faultReportStatus, organisations, sectorProgrammes, breadcrumb, $timeout) {
      var filter, refresh, timer;
      $scope.faultReports = faultReports.data;
      $scope.page = 1;
      $scope.faultReportStatus = faultReportStatus.data;
      $scope.organisations = organisations.data;
      $scope.sectorProgrammes = sectorProgrammes.data;
      filter = function(page) {
        var params;
        $scope.serverFilter = $scope.filter;
        params = {};
        angular.copy($scope.filters, params);
        return $http.get("api/faultReportInternal", {
          params: angular.extend(params, {
            filter: $scope.filter || "",
            page: page || 1,
            sort: $scope.field,
            desc: $scope.desc
          })
        }).then(function(response) {
          var i;
          $scope.page = page || 1;
          $scope.pages = (function() {
            var _i, _ref, _results;
            _results = [];
            for (i = _i = 1, _ref = Math.max(1, Math.ceil(response.data.count / 10.0)); 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
              _results.push(i);
            }
            return _results;
          })();
          return $scope.faultReports = response.data;
        });
      };
      $scope.search = function() {
        return filter();
      };
      $scope.gotoPage = function(x) {
        if (x < 1 || x > $scope.pages.length) {
          return;
        }
        $scope.page = x;
        return filter(x);
      };
      $scope.filters = {
        status: null
      };
      $scope.$watch('filters', function(value) {
        if (value) {
          return filter();
        }
      }, true);
      $scope.$on('fault', function(e, x) {
        return $scope.$apply(function() {
          return filter($scope.page);
        });
      });
      timer = null;
      refresh = function() {
        filter($scope.page);
        return timer = $timeout(refresh, 60000);
      };
      timer = $timeout(refresh, 60000);
      $scope.$on('$destroy', function() {
        return timer.cancel();
      });
      return breadcrumb([
        {
          description: 'Incident Reporting'
        }
      ]);
    }
  ];

}).call(this);
