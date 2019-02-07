# CoffeeScript
@CrossCuttingProgrammeListController = ['$scope','$http', 'crossCuttingProgrammes', 'breadcrumb', ($scope, $http, crossCuttingProgrammes,breadcrumb) ->
  $scope.crossCuttingProgrammes = crossCuttingProgrammes.data
  $scope.search = ()->
    $http.get("api/crossCuttingProgramme/", params:filter:$scope.filter).then((response)->
        $scope.crossCuttingProgrammes = response.data
        )

  breadcrumb([
    { description: 'Cross Cutting Programmes'}
  ])

]
# CoffeeScript
