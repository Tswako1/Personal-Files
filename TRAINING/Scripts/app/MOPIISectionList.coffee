# CoffeeScript
@MOPIISectionListController = ['$scope','$http', 'mOPIISections', 'breadcrumb', ($scope, $http, mOPIISections,breadcrumb) ->
  $scope.mOPIISections = mOPIISections.data
  $scope.search = ()->
    $http.get("api/mOPIISection/", params:filter:$scope.filter).then((response)->
        $scope.mOPIISections = response.data
        )

  breadcrumb([
    { description: 'MOP Sections'}
  ])

]
