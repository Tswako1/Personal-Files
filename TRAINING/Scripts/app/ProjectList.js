(function() {

  this.projectFilters = {};

  this.ProjectListController = [
    '$scope', '$http', '$modal', 'projects', 'organisations', 'projectStatus', 'sectorProgrammes', 'fundingSources', 'breadcrumb', 'notification', 'deleteProject', function($scope, $http, $modal, projects, organisations, projectStatus, sectorProgrammes, fundingSources, breadcrumb, notification, deleteProject) {
      var filter, i;
      $scope.deleteProject = {
        value: deleteProject
      };
      $scope.projects = projects.data.items;
      $scope.organisations = organisations.data;
      $scope.projectStatus = projectStatus.data;
      $scope.sectorProgrammes = sectorProgrammes.data;
      $scope.fundingSources = fundingSources.data;
      $scope.page = 1;
      $scope.pages = (function() {
        var _i, _ref, _results;
        _results = [];
        for (i = _i = 1, _ref = Math.ceil(projects.data.count / 10.0); 1 <= _ref ? _i <= _ref : _i >= _ref; i = 1 <= _ref ? ++_i : --_i) {
          _results.push(i);
        }
        return _results;
      })();
      $scope.filters = projectFilters;
      $scope.deleteProjectRegistration = function(projectId, $index) {
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
            return $http["delete"]("api/project/" + projectId).then(function(response) {
              $scope.projects.splice($index, 1);
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
        return $http.get("api/project/", {
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
          return $scope.projects = response.data.items;
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
      if (deleteProject) {
        return breadcrumb([
          {
            description: 'Delete Projects'
          }
        ]);
      } else {
        return breadcrumb([
          {
            description: 'Project List'
          }
        ]);
      }
    }
  ];

}).call(this);
