# CoffeeScript
@DevelopmentalLocationController = ['$scope', '$http', '$routeParams', 'notification', 'developmentalLocation', 'breadcrumb', ($scope, $http, $routeParams, notification, developmentalLocation, breadcrumb) ->
    fn=()->if $scope.developmentalLocation.id then $http.put else $http.post
    $scope.saveDevelopmentalLocation =  ->
        if $scope.developmentalLocationForm.$valid 
            fn()("api/developmentalLocation/", $scope.developmentalLocation).then((response) -> 
                $scope.developmentalLocation = response.data 
                notification("Successfully saved"))

    $scope.developmentalLocation = developmentalLocation?.data[0]||{}
   
    breadcrumb([
        { description: 'Developmental Locations', url: "administration/developmentalLocationList" }
    ])



]
