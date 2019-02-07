@IndicatorStrategyController = ['$scope', '$http', '$routeParams', 'notification', 'indicatorStrategy', 'breadcrumb', ($scope, $http, $routeParams, notification, indicatorStrategy, breadcrumb) ->
    fn=()->if $scope.indicatorStrategy.id then $http.put else $http.post
    $scope.saveIndicatorStrategy =  ->
        if $scope.indicatorStrategyForm.$valid 
            fn()("api/indicatorStrategy/", $scope.indicatorStrategy).then((response) -> 
                $scope.indicatorStrategy = response.data 
                notification("Successfully saved"))

    $scope.indicatorStrategy = indicatorStrategy?.data[0]||{}
   
    breadcrumb([
        { description: 'Indicator Strategies', url: "administration/indicatorStrategyList" }
    ])



]
# CoffeeScript
# CoffeeScript
# CoffeeScript
