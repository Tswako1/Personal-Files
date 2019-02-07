# CoffeeScript
@FundingSourceController = ['$scope', '$http', '$routeParams', 'notification', 'fundingSource', 'fundingSourceGroups','breadcrumb', ($scope, $http, $routeParams, notification, fundingSource, fundingSourceGroups, breadcrumb) ->
    
    $scope.fundingSourceGroups = fundingSourceGroups.data

    fn=()->if $scope.fundingSource.id then $http.put else $http.post
    $scope.saveFundingSource =  ->
        if $scope.fundingSourceForm.$valid 
            fn()("api/fundingSource/", $scope.fundingSource).then((response) -> 
                $scope.fundingSource = response.data 
                notification("Successfully saved"))

    $scope.fundingSource = fundingSource?.data[0]||{}
   
    breadcrumb([
        { description: 'Funding Sources', url: "administration/fundingSourceList" }
    ])



]
