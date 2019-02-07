(function() {

  this.SectorProgrammeController = [
    '$scope', '$http', '$routeParams', 'notification', 'sectorProgramme', 'breadcrumb', function($scope, $http, $routeParams, notification, sectorProgramme, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.sectorProgramme.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveSectorProgramme = function() {
        if ($scope.sectorProgrammeForm.$valid) {
          return fn()("api/sectorProgramme/", $scope.sectorProgramme).then(function(response) {
            $scope.sectorProgramme = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.sectorProgramme = (sectorProgramme != null ? sectorProgramme.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Sector Programmes',
          url: "administration/sectorProgrammeList"
        }
      ]);
    }
  ];

}).call(this);
