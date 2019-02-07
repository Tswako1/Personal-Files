# CoffeeScript
@IndicatorTypeListController = ['$scope','$http', 'indicatorTypes', 'breadcrumb', ($scope, $http, indicatorTypes,breadcrumb) ->
  $scope.indicatorTypes = indicatorTypes.data
  $scope.search = ()->
    $http.get("api/indicatorType/", params:filter:$scope.filter).then((response)->
        $scope.indicatorTypes = response.data
        )

  breadcrumb([
    { description: 'Indicator Types'}
  ])

]
# CoffeeScript
# CoffeeScript
