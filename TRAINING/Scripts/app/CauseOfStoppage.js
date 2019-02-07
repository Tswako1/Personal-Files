(function() {

  this.CauseOfStoppageController = [
    '$scope', '$http', '$routeParams', 'notification', 'causeOfStoppage', 'breadcrumb', function($scope, $http, $routeParams, notification, causeOfStoppage, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.causeOfStoppage.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveCauseOfStoppage = function() {
        if ($scope.causeOfStoppageForm.$valid) {
          return fn()("api/causeOfStoppage/", $scope.causeOfStoppage).then(function(response) {
            $scope.causeOfStoppage = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.causeOfStoppage = (causeOfStoppage != null ? causeOfStoppage.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Cause of Stoppage',
          url: "administration/causeOfStoppageList"
        }
      ]);
    }
  ];

}).call(this);
