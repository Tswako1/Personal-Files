# CoffeeScript
@MOPKPIController = ['$scope', '$http', '$routeParams', 'notification', 'mOPKPI', 'breadcrumb', ($scope, $http, $routeParams, notification, mOPKPI, breadcrumb) ->
    fn=()->if $scope.mOPKPI.id then $http.put else $http.post
    $scope.saveMOPKPI =  ->
        if $scope.mOPKPIForm.$valid 
            fn()("api/mOPKPI/", $scope.mOPKPI).then((response) -> 
                $scope.mOPKPI = response.data 
                notification("Successfully saved"))

    $scope.mOPKPI = mOPKPI?.data[0]||{}
   
    breadcrumb([
        { description: 'MOP KPIs', url: "administration/mOPKPIList" }
    ])



]
