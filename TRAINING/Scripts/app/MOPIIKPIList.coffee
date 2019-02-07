# CoffeeScript
@MOPIIKPIListController = ['$scope','$http', 'mOPIIKPIs', 'breadcrumb', ($scope, $http, mOPIIKPIs,breadcrumb) ->
  $scope.mOPIIKPIs = mOPIIKPIs.data
  $scope.search = ()->
    $http.get("api/mOPIIKPI/", params:filter:$scope.filter).then((response)->
        $scope.mOPIIKPIs = response.data
        )

  breadcrumb([
    { description: 'MOP KPIs'}
  ])

]
