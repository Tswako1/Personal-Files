(function() {

  this.MOPIISectionController = [
    '$scope', '$http', '$routeParams', 'notification', 'mOPIISection', 'mOPIIKPIs', 'breadcrumb', function($scope, $http, $routeParams, notification, mOPIISection, mOPIIKPIs, breadcrumb) {
      var fn;
      $scope.mOPIIKPIs = mOPIIKPIs.data;
      fn = function() {
        if ($scope.mOPIISection.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPIISection = function() {
        if ($scope.mOPIISectionForm.$valid) {
          return fn()("api/mOPIISection/", $scope.mOPIISection).then(function(response) {
            $scope.mOPIISection = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPIISection = (mOPIISection != null ? mOPIISection.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'MOP Sections',
          url: "administration/mOPIISectionList"
        }
      ]);
    }
  ];

}).call(this);
