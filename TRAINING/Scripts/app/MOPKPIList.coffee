# CoffeeScript
@MOPKPIListController = ['$scope','$http', 'mOPKPIs', 'breadcrumb', ($scope, $http, mOPKPIs,breadcrumb) ->
  $scope.mOPKPIs = mOPKPIs.data
  $scope.search = ()->
    $http.get("api/mOPKPI/", params:filter:$scope.filter).then((response)->
        $scope.mOPKPIs = response.data
        )

  breadcrumb([
    { description: 'MOP KPIs'}
  ])

]
