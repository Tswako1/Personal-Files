@FundingSourceListController = ['$scope','$http', 'fundingSources', 'breadcrumb', ($scope, $http, fundingSources,breadcrumb) ->
  $scope.fundingSources = fundingSources.data
  $scope.search = ()->
    $http.get("api/fundingSource/", params:filter:$scope.filter).then((response)->
        $scope.fundingSources = response.data
        )

  breadcrumb([
    { description: 'Funding Sources'}
  ])

]
