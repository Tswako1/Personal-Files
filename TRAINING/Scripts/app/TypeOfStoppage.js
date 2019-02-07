(function() {

  this.TypeOfStoppageController = [
    '$scope', '$http', '$routeParams', 'notification', 'typeOfStoppage', 'breadcrumb', function($scope, $http, $routeParams, notification, typeOfStoppage, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.typeOfStoppage.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveTypeOfStoppage = function() {
        if ($scope.typeOfStoppageForm.$valid) {
          return fn()("api/typeOfStoppage/", $scope.typeOfStoppage).then(function(response) {
            $scope.typeOfStoppage = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.typeOfStoppage = (typeOfStoppage != null ? typeOfStoppage.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Types of Stoppage',
          url: "administration/typeOfStoppageList"
        }
      ]);
    }
  ];

}).call(this);
