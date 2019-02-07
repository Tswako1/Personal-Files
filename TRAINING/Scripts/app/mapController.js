(function() {

  this.mapController = [
    '$scope', '$http', 'organisation', 'location', 'dialog', function($scope, $http, organisation, location, dialog) {
      $scope.organisation = organisation.data;
      $scope.location = location;
      $scope.modal = dialog.modal;
      return $scope.OK = function() {
        return dialog.modal.close(location);
      };
    }
  ];

}).call(this);
