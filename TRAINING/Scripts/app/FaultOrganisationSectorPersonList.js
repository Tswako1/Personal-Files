(function() {

  this.FaultOrganisationSectorPersonListController = [
    '$scope', '$http', 'faultOrganisationSectorPersonList', 'breadcrumb', function($scope, $http, faultOrganisationSectorPersonList, breadcrumb) {
      $scope.faultOrganisationSectorPersonList = faultOrganisationSectorPersonList.data;
      $scope.search = function() {
        return $http.get("api/FaultOrganisationSectorPerson/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.faultOrganisationSectorPersonList = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Fault Responsible People'
        }
      ]);
    }
  ];

}).call(this);
