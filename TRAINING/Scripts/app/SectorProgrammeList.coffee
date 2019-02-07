# CoffeeScript
@SectorProgrammeListController = ['$scope','$http', 'sectorProgrammes', 'breadcrumb', ($scope, $http, sectorProgrammes,breadcrumb) ->
  $scope.sectorProgrammes = sectorProgrammes.data
  $scope.search = ()->
    $http.get("api/sectorProgramme/", params:filter:$scope.filter).then((response)->
        $scope.sectorProgrammes = response.data
        )

  breadcrumb([
    { description: 'Sector Programmes'}
  ])

]
