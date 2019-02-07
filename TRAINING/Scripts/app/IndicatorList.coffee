# CoffeeScript
@IndicatorListController = ['$scope','$http', 'indicators', 'breadcrumb', ($scope, $http, indicators, breadcrumb) ->
    $scope.indicators = indicators.data
    breadcrumb([
        { description: 'Indicators'}
    ])
]


@IndicatorTargetsController = ['$scope','$http','$routeParams','targets', 'breadcrumb', 'notification', ($scope, $http, $routeParams, targets, breadcrumb, notification) ->
    $scope.targets = targets.data.targets.groupBy (x) -> x.financialYear

    $scope.save = -> 
        $http.put('api/indicatorTargets', indicatorId: $routeParams.id, targets: targets.data).then -> 
            notification("Successfully saved")
        
    breadcrumb([
        { description: 'Indicators', url: '/administration/indicators'},
        { description: targets.data.description }
    ])
]
