# CoffeeScript
@MOPSectorListController = ['$scope','$http', 'mOPSectors', 'breadcrumb', ($scope, $http, mOPSectors,breadcrumb) ->
  $scope.mOPSectors = mOPSectors.data
  $scope.search = ()->
    $http.get("api/mOPSector/", params:filter:$scope.filter).then((response)->
        $scope.mOPSectors = response.data
        )

  breadcrumb([
    { description: 'MOP Sectors'}
  ])

]
