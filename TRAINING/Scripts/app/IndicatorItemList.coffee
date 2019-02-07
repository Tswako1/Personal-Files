# CoffeeScript
@IndicatorItemListController = ['$scope','$http', 'indicatorItems', 'breadcrumb', ($scope, $http, indicatorItems,breadcrumb) ->
  $scope.indicatorItems = indicatorItems.data
  $scope.search = ()->
    $http.get("api/indicatorItem/", params:filter:$scope.filter).then((response)->
        $scope.indicatorItems = response.data
        )

  breadcrumb([
    { description: 'Indicator Items'}
  ])

]
# CoffeeScript
