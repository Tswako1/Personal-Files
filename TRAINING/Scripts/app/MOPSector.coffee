# CoffeeScript
@MOPSectorController = ['$scope', '$http', '$routeParams', 'notification', 'mOPSector', 'breadcrumb', ($scope, $http, $routeParams, notification, mOPSector, breadcrumb) ->
    fn=()->if $scope.mOPSector.id then $http.put else $http.post
    $scope.saveMOPSector =  ->
        if $scope.mOPSectorForm.$valid 
            fn()("api/mOPSector/", $scope.mOPSector).then((response) -> 
                $scope.mOPSector = response.data 
                notification("Successfully saved"))

    $scope.mOPSector = mOPSector?.data[0]||{}
   
    breadcrumb([
        { description: 'MOP Sector', url: "administration/mOPSectorList" }
    ])



]
