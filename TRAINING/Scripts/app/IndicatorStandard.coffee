@IndicatorStandardController = ['$scope', '$http', '$routeParams', 'notification', 'indicatorStandard', 'breadcrumb', ($scope, $http, $routeParams, notification, indicatorStandard, breadcrumb) ->
    fn=()->if $scope.indicatorStandard.id then $http.put else $http.post
    $scope.saveIndicatorStandard =  ->
        if $scope.indicatorStandardForm.$valid 
            fn()("api/indicatorStandard/", $scope.indicatorStandard).then((response) -> 
                $scope.indicatorStandard = response.data 
                notification("Successfully saved"))

    $scope.indicatorStandard = indicatorStandard?.data[0]||{}
   
    breadcrumb([
        { description: 'Indicator Standards', url: "administration/indicatorStandardList" }
    ])



]
# CoffeeScript
# CoffeeScript
# CoffeeScript
