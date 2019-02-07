# CoffeeScript
@BackToBasicsListController = ['$scope','$http', 'backToBasics', 'organisations', 'financialYears', 'financialPeriods', 'breadcrumb', ($scope, $http, backToBasics,organisations,financialYears,financialPeriods,breadcrumb) ->
  $scope.backToBasics = backToBasics.data
  $scope.organisations = organisations.data
  $scope.financialYears = financialYears.data
  $scope.financialPeriods = financialPeriods.data
  $scope.search = ()->
    params = {}
    angular.copy $scope.filters, params  
    params.filter = $scope.filter
    $http.get("api/backToBasics/", params:params).then((response)->
        $scope.backToBasics = response.data
        )

  $scope.$watch 'filters', (value) -> 
        if(value) then $scope.search()
    , true

  breadcrumb([
    { description: 'Back to Basics'}
  ])

]
# CoffeeScript
