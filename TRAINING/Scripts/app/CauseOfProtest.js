(function() {

  this.CauseOfProtestController = [
    '$scope', '$http', '$routeParams', 'notification', 'causeOfProtest', 'breadcrumb', function($scope, $http, $routeParams, notification, causeOfProtest, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.causeOfProtest.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveCauseOfProtest = function() {
        if ($scope.causeOfProtestForm.$valid) {
          return fn()("api/causeOfProtest/", $scope.causeOfProtest).then(function(response) {
            $scope.causeOfProtest = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.causeOfProtest = (causeOfProtest != null ? causeOfProtest.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Cause of Protest',
          url: "administration/causeOfProtestList"
        }
      ]);
    }
  ];

}).call(this);
