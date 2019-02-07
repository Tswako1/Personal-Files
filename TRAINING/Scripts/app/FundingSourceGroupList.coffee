@FundingSourceGroupListController = ['$scope','$http', 'fundingSourceGroups', 'breadcrumb', ($scope, $http, fundingSourceGroups,breadcrumb) ->
  $scope.fundingSourceGroups = fundingSourceGroups.data
  $scope.search = ()->
    $http.get("api/fundingSourceGroup/", params:filter:$scope.filter).then((response)->
        $scope.fundingSourceGroups = response.data
        )

  breadcrumb([
    { description: 'Funding Source Groups'}
  ])

]
