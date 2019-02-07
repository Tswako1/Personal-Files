@IndicatorController = ['$scope','$http', 'notification', 'indicator','types', 'unitOfMeasures', 'items', 'strategies', 'standards', 'breadcrumb', ($scope, $http, notification, indicator, types, unitOfMeasures, items, strategies, standards, breadcrumb) ->
    $scope.indicator = indicator?.data[0]
    $scope.types = types.data
    $scope.unitOfMeasures = unitOfMeasures.data
    $scope.items = items.data
    $scope.strategies = strategies.data
    $scope.standards = standards.data
    $scope.isUpdate = (indicator != null)
    
    fn=()->if $scope.indicator.id then $http.put else $http.post
   
    $scope.save =  ->
        if $scope.indicatorForm.$valid 
            fn()("api/indicator/", $scope.indicator).then (response)->
                $scope.indicator.id = response.data.id
                notification("Successfully saved")

      
    breadcrumb([
        { description: 'Indicators', url: '/administration/indicators'},
        { description: 'Create'}
    ])
]# CoffeeScript
