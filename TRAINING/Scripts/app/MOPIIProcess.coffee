# CoffeeScript
@MOPIIProcessController = ['$scope', '$http', '$routeParams', 'notification', 'mOPIIProcess','mOPIISections', 'breadcrumb', ($scope, $http, $routeParams, notification, mOPIIProcess, mOPIISections, breadcrumb) ->

    $scope.mOPIISections = mOPIISections.data

    fn=()->if $scope.mOPIIProcess.id then $http.put else $http.post
    $scope.saveMOPIIProcess =  ->
        if $scope.mOPIIProcessForm.$valid 
            fn()("api/mOPIIProcess/", $scope.mOPIIProcess).then((response) -> 
                $scope.mOPIIProcess = response.data 
                notification("Successfully saved"))

    $scope.mOPIIProcess = mOPIIProcess?.data[0]||{}
   
    breadcrumb([
        { description: 'MOP Process', url: "administration/mOPIIProcessList" }
    ])



]
# CoffeeScript
# CoffeeScript
