# CoffeeScript
@FaultPriorityListController = ['$scope','$http', 'faultPriorities', 'breadcrumb', ($scope, $http, faultPriorities,breadcrumb) ->
  $scope.faultPriorities = faultPriorities.data
  $scope.search = ()->
    $http.get("api/faultPriority/", params:filter:$scope.filter).then((response)->
        $scope.faultPriorities = response.data
        )

  breadcrumb([
    { description: 'Fault Priorities'}
  ])

]
# CoffeeScript
