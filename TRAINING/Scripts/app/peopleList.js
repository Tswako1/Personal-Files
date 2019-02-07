(function() {

  this.PeopleListController = [
    '$scope', '$http', 'people', 'breadcrumb', function($scope, $http, people, breadcrumb) {
      $scope.people = people.data;
      $scope.search = function() {
        return $http.get("api/people/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.people = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'People'
        }
      ]);
    }
  ];

}).call(this);
