(function() {

  this.MOPProjectStageListController = [
    '$scope', '$http', 'mOPProjectStages', 'breadcrumb', function($scope, $http, mOPProjectStages, breadcrumb) {
      $scope.mOPProjectStages = mOPProjectStages.data;
      $scope.search = function() {
        return $http.get("api/mOPProjectStage/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPProjectStages = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'MOP Project Stages'
        }
      ]);
    }
  ];

}).call(this);
