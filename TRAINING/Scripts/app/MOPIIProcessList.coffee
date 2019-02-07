# CoffeeScript
@MOPIIProcessListController = ['$scope','$http', 'mOPIIProcesss', 'breadcrumb', ($scope, $http, mOPIIProcesss,breadcrumb) ->
  $scope.mOPIIProcesss = mOPIIProcesss.data
  $scope.search = ()->
    $http.get("api/mOPIIProcess/", params:filter:$scope.filter).then((response)->
        $scope.mOPIIProcesss = response.data
        )

  breadcrumb([
    { description: 'MOP Processes'}
  ])

]
