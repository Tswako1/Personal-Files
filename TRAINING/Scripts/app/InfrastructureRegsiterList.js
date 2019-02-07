(function() {

  this.infrastructureFilters = {};

  this.InfrastructureRegisterListController = [
    '$scope', '$http', '$modal', 'infrastructureRegisters', 'organisations', 'breadcrumb', 'deleteInfrastructure', 'assetClasses', 'notification', function($scope, $http, $modal, infrastructureRegisters, organisations, breadcrumb, deleteInfrastructure, assetClasses, notification) {
      var filter, i;
      $scope.deleteInfrastructure = {
        value: deleteInfrastructure
      };
      $scope.infrastructureRegisters = infrastructureRegisters.data.items;
      $scope.page = 1;
      $scope.pages = (function() {
        var _i, _ref, _results;
        _results = [];
        for (i = _i = 1, _ref = Math.ceil(infrastructureRegisters.data.count / 10.0); 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
          _results.push(i);
        }
        return _results;
      })();
      $scope.organisations = organisations.data;
      $scope.assetClasses = assetClasses.data;
      $scope.field = "Description";
      $scope.desc = false;
      $scope.filters = infrastructureFilters;
      $scope.deleteInfrastructureRegister = function(infrastructureId, $index) {
        var myModal;
        myModal = $modal.open({
          templateUrl: "content/views/DeleteConfirmation.html",
          controller: [
            '$scope', '$modalInstance', function($scope, $modalInstance) {
              return $scope.modal = $modalInstance;
            }
          ]
        });
        return myModal.result.then(function(result) {
          if (result) {
            return $http["delete"]("api/infrastructureRegister/" + infrastructureId).then(function(response) {
              $scope.infrastructureRegisters.splice($index, 1);
              return notification("Successfully Deleted");
            });
          }
        });
      };
      filter = function(page) {
        var params;
        $scope.serverFilter = $scope.filter;
        params = {};
        angular.copy($scope.filters, params);
        return $http.get("api/infrastructureRegister/", {
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
          return $scope.infrastructureRegisters = response.data.items;
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
      if (deleteInfrastructure) {
        return breadcrumb([
          {
            description: 'Delete Assets'
          }
        ]);
      } else {
        return breadcrumb([
          {
            description: 'Asset Register List'
          }
        ]);
      }
    }
  ];

}).call(this);
