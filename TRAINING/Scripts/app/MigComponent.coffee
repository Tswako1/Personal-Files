# CoffeeScript
@MigComponentController = ['$scope', '$http', '$routeParams', 'notification', 'migComponent', 'breadcrumb', ($scope, $http, $routeParams, notification, migComponent, breadcrumb) ->
    fn=()->if $scope.migComponent.id then $http.put else $http.post
    $scope.saveMigComponent =  ->
        if $scope.migComponentForm.$valid 
            fn()("api/migComponent/", $scope.migComponent).then((response) -> 
                $scope.migComponent = response.data 
                notification("Successfully saved"))

    $scope.migComponent = migComponent?.data[0]||{}
   
    breadcrumb([
        { description: 'Mig Components', url: "administration/migComponentList" }
    ])



]
