(function() {

  this.MisaSupportAgentListController = [
    '$scope', '$http', 'misaSupportAgents', 'breadcrumb', function($scope, $http, misaSupportAgents, breadcrumb) {
      $scope.misaSupportAgents = misaSupportAgents.data;
      $scope.search = function() {
        return $http.get("api/misaSupportAgent/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.misaSupportAgents = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Misa Support Agents'
        }
      ]);
    }
  ];

}).call(this);
