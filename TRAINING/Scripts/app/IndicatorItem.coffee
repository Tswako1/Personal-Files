@IndicatorItemController = ['$scope', '$http', '$routeParams', 'notification', 'indicatorItem', 'breadcrumb', ($scope, $http, $routeParams, notification, indicatorItem, breadcrumb) ->
    fn=()->if $scope.indicatorItem.id then $http.put else $http.post
    $scope.saveIndicatorItem =  ->
        if $scope.indicatorItemForm.$valid 
            fn()("api/indicatorItem/", $scope.indicatorItem).then((response) -> 
                $scope.indicatorItem = response.data 
                notification("Successfully saved"))

    $scope.indicatorItem = indicatorItem?.data[0]||{}
   
    breadcrumb([
        { description: 'Indicator Items', url: "administration/indicatorItemList" }
    ])



]
# CoffeeScript
# CoffeeScript
