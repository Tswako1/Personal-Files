@IndicatorStandardListController = ['$scope','$http', 'indicatorStandards', 'breadcrumb', ($scope, $http, indicatorStandards,breadcrumb) ->
  $scope.indicatorStandards = indicatorStandards.data
  $scope.search = ()->
    $http.get("api/indicatorStandard/", params:filter:$scope.filter).then((response)->
        $scope.indicatorStandards = response.data
    )
  
  breadcrumb([
    { description: 'Indicator Standards'}
  ])

]
