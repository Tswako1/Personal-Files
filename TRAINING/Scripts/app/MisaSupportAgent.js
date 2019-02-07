(function() {

  this.MisaSupportAgentController = [
    '$scope', '$http', '$routeParams', 'notification', 'misaSupportAgent', 'breadcrumb', function($scope, $http, $routeParams, notification, misaSupportAgent, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.misaSupportAgent.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMisaSupportAgent = function() {
        if ($scope.misaSupportAgentForm.$valid) {
          return fn()("api/misaSupportAgent/", $scope.misaSupportAgent).then(function(response) {
            $scope.misaSupportAgent = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.misaSupportAgent = (misaSupportAgent != null ? misaSupportAgent.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Misa Support Agents',
          url: "administration/misaSupportAgentList"
        }
      ]);
    }
  ];

}).call(this);
