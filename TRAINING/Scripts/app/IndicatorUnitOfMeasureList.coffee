# CoffeeScript
@IndicatorUnitOfMeasureListController = ['$scope','$http', 'indicatorUnitOfMeasures', 'breadcrumb', ($scope, $http, indicatorUnitOfMeasures,breadcrumb) ->
  $scope.indicatorUnitOfMeasures = indicatorUnitOfMeasures.data
  $scope.search = ()->
    $http.get("api/indicatorUnitOfMeasure/", params:filter:$scope.filter).then((response)->
        $scope.indicatorUniUnittOdMeasures = response.data
        )

  breadcrumb([
    { description: 'Indicator Units of Measure'}
  ])

]
# CoffeeScript
# CoffeeScript
