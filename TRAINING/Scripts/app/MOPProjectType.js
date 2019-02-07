(function() {

  this.MOPProjectTypeController = [
    '$scope', '$http', '$routeParams', 'notification', 'mOPProjectType', 'breadcrumb', function($scope, $http, $routeParams, notification, mOPProjectType, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.mOPProjectType.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPProjectType = function() {
        if ($scope.mOPProjectTypeForm.$valid) {
          return fn()("api/mOPProjectType/", $scope.mOPProjectType).then(function(response) {
            $scope.mOPProjectType = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPProjectType = (mOPProjectType != null ? mOPProjectType.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'MOP Project Types',
          url: "administration/mOPProjectTypeList"
        }
      ]);
    }
  ];

}).call(this);
