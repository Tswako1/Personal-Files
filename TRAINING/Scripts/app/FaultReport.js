(function() {

  this.FaultReportController = [
    '$scope', '$http', '$modal', '$routeParams', 'notification', 'faultReport', 'breadcrumb', function($scope, $http, $modal, $routeParams, notification, faultReport, breadcrumb) {
      var action, fault;
      fault = faultReport.data;
      $scope.faultReport = faultReport.data;
      $scope.add = function() {
        return $http.post('api/fault/comment', {
          FaultReportId: faultReport.data.id,
          comment: $scope.comment
        }).then(function(response) {
          $scope.comment = '';
          return $scope.faultReport = response.data;
        });
      };
      action = function(x) {
        return $http.post("api/fault/" + x, {
          FaultReportId: faultReport.data.id,
          comment: $scope.comment
        }).then(function(response) {
          if (response.data === "null") {
            return notification('No responsible person assigned to this organisation and sector', false, true);
          } else {
            $scope.comment = '';
            return $scope.faultReport = response.data;
          }
        });
      };
      $scope.confirm = function() {
        return action('confirm');
      };
      $scope.reject = function() {
        return action('reject');
      };
      $scope.close = function() {
        return action('close');
      };
      $scope.duplicate = function() {
        var modal;
        modal = $modal.open({
          templateUrl: "content/views/faultReportDuplicateAction.html",
          controller: [
            '$scope', '$modalInstance', 'faults', function($scope, $modalInstance, faults) {
              $scope.selected = null;
              $scope.modal = $modalInstance;
              $scope.faults = faults.data.items;
              return $scope.select = function(fault) {
                if ($scope.selected) {
                  $scope.selected.selected = false;
                }
                $scope.selected = fault;
                return fault.selected = true;
              };
            }
          ],
          resolve: {
            faults: [
              '$http', function($http) {
                return $http.get('api/faultReportInternal', {
                  params: {
                    status: 2,
                    organisation: fault.organisationId,
                    sectorProgram: fault.sectorProgramId
                  }
                });
              }
            ]
          }
        });
        return modal.result.then(function(id) {
          if (!id) {
            return;
          }
          return $http.post('api/fault/duplicate', {
            FaultReportId: faultReport.data.id,
            comment: $scope.comment,
            DuplicateFaultId: id
          }).then(function(response) {
            $scope.comment = '';
            return $scope.faultReport = response.data;
          });
        });
      };
      return breadcrumb([]);
    }
  ];

}).call(this);
