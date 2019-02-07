(function() {

  this.MOPResponsiblePeopleListController = [
    '$scope', '$http', 'mOPResponsiblePeoples', 'breadcrumb', function($scope, $http, mOPResponsiblePeoples, breadcrumb) {
      $scope.mOPResponsiblePeoples = mOPResponsiblePeoples.data;
      $scope.search = function() {
        return $http.get("api/mOPResponsiblePeople/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.mOPResponsiblePeoples = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'MOP Responsible People'
        }
      ]);
    }
  ];

}).call(this);
