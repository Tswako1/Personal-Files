# CoffeeScript
@FaultOrganisationSectorPersonListController = ['$scope','$http', 'faultOrganisationSectorPersonList', 'breadcrumb', ($scope, $http, faultOrganisationSectorPersonList,breadcrumb) ->
  $scope.faultOrganisationSectorPersonList = faultOrganisationSectorPersonList.data
  $scope.search = ()->
    $http.get("api/FaultOrganisationSectorPerson/", params:filter:$scope.filter).then((response)->
        $scope.faultOrganisationSectorPersonList = response.data
        )

  breadcrumb([
    { description: 'Fault Responsible People'}
  ])

]
# CoffeeScript
