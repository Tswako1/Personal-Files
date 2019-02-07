(function() {

  this.CrossCuttingProgrammeController = [
    '$scope', '$http', '$routeParams', 'notification', 'crossCuttingProgramme', 'breadcrumb', function($scope, $http, $routeParams, notification, crossCuttingProgramme, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.crossCuttingProgramme.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveCrossCuttingProgramme = function() {
        if ($scope.crossCuttingProgrammeForm.$valid) {
          return fn()("api/crossCuttingProgramme/", $scope.crossCuttingProgramme).then(function(response) {
            $scope.crossCuttingProgramme = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.crossCuttingProgramme = (crossCuttingProgramme != null ? crossCuttingProgramme.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Cross Cutting Programmes',
          url: "administration/crossCuttingProgrammeList"
        }
      ]);
    }
  ];

}).call(this);
