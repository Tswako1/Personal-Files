# CoffeeScript
@IndicatorStrategyListController = ['$scope','$http', 'indicatorStrategies', 'breadcrumb', ($scope, $http, indicatorStrategies,breadcrumb) ->
  $scope.indicatorStrategies = indicatorStrategies.data
  $scope.search = ()->
    $http.get("api/indicatorStrategy/", params:filter:$scope.filter).then((response)->
        $scope.indicatorStrategies = response.data
        )

  breadcrumb([
    { description: 'Indicator Strategies'}
  ])

]
# CoffeeScript
# CoffeeScript
