(function() {

  this.ProjectFinancialsController = [
    '$scope', '$http', 'projectFinancials', 'notification', 'breadcrumb', function($scope, $http, projectFinancials, notification, breadcrumb) {
      var actuals, dateRange, month, range, records, years, _i, _len, _ref;
      $scope.saveProjectFinancials = function() {
        if ($scope.projectFinancialsForm.$valid) {
          $http.post('api/projectFinancials', {
            projectId: projectFinancials.data[0].id,
            projectBudgets: records,
            projectActuals: actuals
          });
          return notification("Successfully saved");
        }
      };
      $scope.projectFinancials = projectFinancials.data;
      $scope.sources = projectFinancials.data[0].fundingSources;
      dateRange = function(from, to) {
        var end, range, start;
        start = new Date(from);
        end = new Date(to);
        range = [];
        while (start <= end) {
          range.push({
            year: start.getFullYear(),
            month: start.getMonth() + 1
          });
          start.setMonth(start.getMonth() + 1);
        }
        return range;
      };
      range = dateRange(projectFinancials.data[0].startDate, projectFinancials.data[0].endDate);
      records = $scope.sources.flatMap(function(source) {
        return range.map(function(period) {
          var financialYearPeriod, item;
          financialYearPeriod = finYearPeriod(period.year, period.month);
          item = projectFinancials.data[0].projectBudgets.first(function(x) {
            return x.financialYear === financialYearPeriod.finYear && x.financialPeriod === financialYearPeriod.finPeriod && x.fundingSourceId === source.id;
          });
          if (item) {
            item.fundingSource = null;
            return item;
          } else {
            return {
              financialYear: financialYearPeriod.finYear,
              financialPeriod: financialYearPeriod.finPeriod,
              fundingSourceId: source.id,
              amount: 0
            };
          }
        });
      });
      actuals = range.map(function(period) {
        var financialYearPeriod, item;
        financialYearPeriod = finYearPeriod(period.year, period.month);
        item = projectFinancials.data[0].projectActuals.first(function(x) {
          return x.financialYear === financialYearPeriod.finYear && x.financialPeriod === financialYearPeriod.finPeriod;
        });
        if (item) {
          return item;
        } else {
          return {
            financialYear: financialYearPeriod.finYear,
            financialPeriod: financialYearPeriod.finPeriod,
            amount: 0
          };
        }
      });
      $scope.getActual = function(year, period) {
        var fst;
        return fst = actuals.first(function(x) {
          return x.financialYear === parseInt(year) && x.financialPeriod === parseInt(period);
        });
      };
      $scope.isInFuture = function(date) {
        var dt, now;
        now = new Date();
        dt = date.financialPeriod < 7 ? new Date(date.financialYear - 1, date.financialPeriod + 5, 1) : new Date(date.financialYear, date.financialPeriod - 6, 1);
        dt.setMonth(dt.getMonth() + 1);
        return dt >= now;
      };
      $scope.calculatePeriodTotals = function(sources) {
        this.$watch('month.value', function(value) {
          return sources.total.amount = sources.reduce((function(xs, x) {
            return parseFloat(x.amount) + xs;
          }), 0);
        }, true);
        return sources.total = {
          amount: 0
        };
      };
      $scope.calculateAnnualTotals = function(year, source) {
        this.$watch('year.value', function(value) {
          return year.total[source.id].amount = year.value.flatMap(function(x) {
            return x.value;
          }).filter(function(x) {
            return x.fundingSourceId === source.id;
          }).reduce((function(xs, x) {
            return parseFloat(x.amount) + xs;
          }), 0);
        }, true);
        year.total = year.total || {};
        return year.total[source.id] = {
          amount: 0
        };
      };
      $scope.calculateTotalTotals = function(year) {
        this.$watch('year.value', function(value) {
          return year.budgetTotal.amount = year.value.flatMap(function(x) {
            return x.value;
          }).reduce((function(xs, x) {
            return parseFloat(x.amount) + xs;
          }), 0);
        }, true);
        return year.budgetTotal = {
          amount: 0
        };
      };
      $scope.calculateActualTotals = function(year) {
        $scope.$watch('actuals', function(actuals) {
          return year.actualsTotal.amount = actuals.filter(function(x) {
            return x.financialYear === parseInt(year.key);
          }).reduce((function(xs, x) {
            return parseFloat(x.amount) + xs;
          }), 0);
        }, true);
        return year.actualsTotal = {
          amount: 0
        };
      };
      $scope.actuals = actuals;
      years = [];
      _ref = records.groupBy(function(x) {
        return x.financialYear;
      });
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        month = _ref[_i];
        years.push({
          key: month.key,
          value: month.value.groupBy(function(x) {
            return x.financialPeriod;
          })
        });
      }
      $scope.financials = years;
      $scope.count = count;
      $scope.expandedYear = finYearPeriod(new Date().getFullYear(), new Date().getMonth() + 1).finYear;
      return breadcrumb([
        {
          description: projectFinancials.data[0].name,
          url: "/projectRegistration/" + projectFinancials.data[0].id
        }, {
          description: 'Financials'
        }
      ]);
    }
  ];

}).call(this);
