@AssetClassListController = ['$scope','$http', 'assetClasses', 'breadcrumb', ($scope, $http, assetClasses,breadcrumb) ->
  $scope.assetClasses = assetClasses.data
  $scope.search = ()->
    $http.get("api/assetClass/", params:filter:$scope.filter).then((response)->
        $scope.assetClasses = response.data
        )

  breadcrumb([
    { description: 'Asset Classes'}
  ])

]
# CoffeeScript
