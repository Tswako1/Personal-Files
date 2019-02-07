# CoffeeScript
@MOPIIKPIController = ['$scope', '$http', '$routeParams', 'notification', 'mOPIIKPI', 'mISAFinancialYears','breadcrumb', ($scope, $http, $routeParams, notification, mOPIIKPI,mISAFinancialYears, breadcrumb) ->

    $scope.mISAFinancialYears = mISAFinancialYears.data

    fn=()->if $scope.mOPIIKPI.id then $http.put else $http.post
    $scope.saveMOPIIKPI =  ->
        if $scope.mOPIIKPIForm.$valid 
            fn()("api/mOPIIKPI/", $scope.mOPIIKPI).then((response) -> 
                $scope.mOPIIKPI = response.data 
                notification("Successfully saved"))

    $scope.mOPIIKPI = mOPIIKPI?.data[0]||{}
   
    breadcrumb([
        { description: 'MOP KPIs', url: "administration/mOPIIKPIList" }
    ])



]
# CoffeeScript
