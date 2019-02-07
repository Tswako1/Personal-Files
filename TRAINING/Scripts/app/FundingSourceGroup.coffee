# CoffeeScript
@FundingSourceGroupController = ['$scope', '$http', '$routeParams', 'notification', 'fundingSourceGroup', 'breadcrumb', ($scope, $http, $routeParams, notification, fundingSourceGroup, breadcrumb) ->
    fn=()->if $scope.fundingSourceGroup.id then $http.put else $http.post
    $scope.saveFundingSourceGroup =  ->
        if $scope.fundingSourceGroupForm.$valid 
            fn()("api/fundingSourceGroup/", $scope.fundingSourceGroup).then((response) -> 
                $scope.fundingSourceGroup = response.data 
                notification("Successfully saved"))

    $scope.fundingSourceGroup = fundingSourceGroup?.data[0]||{}
   
    breadcrumb([
        { description: 'Funding Source Groups', url: "administration/fundingSourceGroupList" }
    ])



]
# CoffeeScript
