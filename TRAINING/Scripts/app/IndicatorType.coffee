@IndicatorTypeController = ['$scope', '$http', '$routeParams', 'notification', 'indicatorType', 'breadcrumb', ($scope, $http, $routeParams, notification, indicatorType, breadcrumb) ->
    fn=()->if $scope.indicatorType.id then $http.put else $http.post
    $scope.saveIndicatorType =  ->
        if $scope.indicatorTypeForm.$valid 
            fn()("api/indicatorType/", $scope.indicatorType).then((response) -> 
                $scope.indicatorType = response.data 
                notification("Successfully saved"))

    $scope.indicatorType = indicatorType?.data[0]||{}
   
    breadcrumb([
        { description: 'Indicator Types', url: "administration/indicatorTypeList" }
    ])



]
# CoffeeScript
# CoffeeScript
# CoffeeScript
