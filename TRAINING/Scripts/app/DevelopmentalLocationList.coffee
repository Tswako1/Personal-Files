# CoffeeScript
@DevelopmentalLocationListController = ['$scope','$http', 'developmentalLocations', 'breadcrumb', ($scope, $http, developmentalLocations,breadcrumb) ->
  $scope.developmentalLocations = developmentalLocations.data
  $scope.search = ()->
    $http.get("api/developmentalLocation/", params:filter:$scope.filter).then((response)->
        $scope.developmentalLocations = response.data
        )

  breadcrumb([
    { description: 'Developmental Locations'}
  ])

]
# CoffeeScript
