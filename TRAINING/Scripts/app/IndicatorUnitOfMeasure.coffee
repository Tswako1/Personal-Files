@IndicatorUnitOfMeasureController = ['$scope', '$http', '$routeParams', 'notification', 'indicatorUnitOfMeasure', 'breadcrumb', ($scope, $http, $routeParams, notification, indicatorUnitOfMeasure, breadcrumb) ->
    fn=()->if $scope.indicatorUnitOfMeasure.id then $http.put else $http.post
    $scope.saveIndicatorUnitOfMeasure =  ->
        if $scope.indicatorUnitOfMeasureForm.$valid 
            fn()("api/indicatorUnitOfMeasure/", $scope.indicatorUnitOfMeasure).then((response) -> 
                $scope.indicatorUnitOfMeasure = response.data 
                notification("Successfully saved"))

    $scope.indicatorUnitOfMeasure = indicatorUnitOfMeasure?.data[0]||{}
   
    breadcrumb([
        { description: 'Indicator Units of Measure', url: "administration/indicatorUnitOfMeasureList" }
    ])



]
# CoffeeScript
# CoffeeScript
# CoffeeScript
