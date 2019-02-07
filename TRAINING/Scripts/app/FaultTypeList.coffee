# CoffeeScript
@FaultTypeListController = ['$scope','$http', 'faultTypes', 'breadcrumb', ($scope, $http, faultTypes,breadcrumb) ->
  $scope.faultTypes = faultTypes.data
  $scope.search = ()->
    $http.get("api/faultType/", params:filter:$scope.filter).then((response)->
        $scope.indicatorItems = response.data
        )

  breadcrumb([
    { description: 'Fault Types'}
  ])

]
# CoffeeScript
