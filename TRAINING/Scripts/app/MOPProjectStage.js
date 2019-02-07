(function() {

  this.MOPProjectStageController = [
    '$scope', '$http', '$routeParams', 'notification', 'mOPProjectStage', 'breadcrumb', function($scope, $http, $routeParams, notification, mOPProjectStage, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.mOPProjectStage.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPProjectStage = function() {
        if ($scope.mOPProjectStageForm.$valid) {
          return fn()("api/mOPProjectStage/", $scope.mOPProjectStage).then(function(response) {
            $scope.mOPProjectStage = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPProjectStage = (mOPProjectStage != null ? mOPProjectStage.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'MOP Project Stages',
          url: "administration/mOPProjectStageList"
        }
      ]);
    }
  ];

}).call(this);
