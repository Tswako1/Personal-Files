(function() {

  this.ProjectIndicatorsController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicators', 'project', 'breadcrumb', function($scope, $http, $routeParams, notification, indicators, project, breadcrumb) {
      $scope.indicators = indicators.data;
      $scope.project = project.data;
      return breadcrumb([
        {
          description: project.data.name,
          url: "/projectRegistration/" + project.data.id
        }, {
          description: 'Indicators'
        }
      ]);
    }
  ];

  this.ProjectIndicatorsCreateController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicators', 'project', 'breadcrumb', function($scope, $http, $routeParams, notification, indicators, project, breadcrumb) {
      var end, start;
      $scope.indicators = indicators.data;
      $scope.project = project.data;
      $scope.save = function() {
        return $http.post('api/ProjectIndicators', {
          projectId: project.data.id,
          indicatorId: $scope.selected.id,
          start: $scope.selected.start,
          end: $scope.selected.end
        }).then(function() {
          notification("Successfully saved");
          return $scope.saved = true;
        });
      };
      start = Date.parse(project.data.startDate);
      end = Date.parse(project.data.endDate);
      $scope.$watch('selected.id', function(x) {
        if (!$scope.selected) {
          return;
        }
        if (!$scope.selected.start) {
          $scope.selected.start = project.data.startDate;
        }
        if (!$scope.selected.end) {
          return $scope.selected.end = project.data.endDate;
        }
      });
      $scope.$watch('selected.start', function(x) {
        var date, to, valid;
        date = Date.parse(x);
        valid = !x || (date >= start - 7200000 && date <= end);
        $scope.siteVisitScheduleForm.start.$setValidity("min", valid);
        if (!$scope.selected || !$scope.selected.end) {
          return;
        }
        to = Date.parse($scope.selected.end);
        return $scope.siteVisitScheduleForm.start.$setValidity("min", valid && to >= date);
      });
      $scope.$watch('selected.end', function(x) {
        var date, from, valid;
        date = Date.parse(x);
        valid = !x || (date >= start + 7200000 && date <= end);
        $scope.siteVisitScheduleForm.end.$setValidity("min", valid);
        if (!$scope.selected || !$scope.selected.start) {
          return;
        }
        from = Date.parse($scope.selected.start);
        return $scope.siteVisitScheduleForm.end.$setValidity("min", valid && date >= from);
      });
      return breadcrumb([
        {
          description: project.data.name,
          url: "/projectRegistration/" + project.data.id
        }, {
          description: 'Indicators',
          url: "/projectRegistration/" + project.data.id + "/indicators"
        }, {
          description: 'Create'
        }
      ]);
    }
  ];

  this.ProjectIndicatorValuesController = [
    '$scope', '$http', '$routeParams', 'notification', 'indicator', 'project', 'breadcrumb', function($scope, $http, $routeParams, notification, indicator, project, breadcrumb) {
      $scope.project = project.data;
      $scope.values = indicator.data.values.groupBy(function(x) {
        return x.financialYear;
      });
      $scope.save = function() {
        return $http.put('api/ProjectIndicators', {
          indicatorId: $routeParams.indicatorId,
          values: indicator.data
        }).then(function() {
          return notification("Successfully saved");
        });
      };
      $scope.isInFuture = function(financialYear, financialPeriod) {
        var dt, now;
        now = new Date();
        dt = financialPeriod < 7 ? new Date(financialYear - 1, financialPeriod + 5, 1) : new Date(financialYear, financialPeriod - 6, 1);
        dt.setMonth(dt.getMonth() + 1);
        return dt >= now;
      };
      return breadcrumb([
        {
          description: project.data.name,
          url: "/projectRegistration/" + project.data.id
        }, {
          description: 'Indicators',
          url: "/projectRegistration/" + project.data.id + "/indicators"
        }, {
          description: indicator.data.description
        }
      ]);
    }
  ];

}).call(this);
