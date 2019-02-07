# CoffeeScript
@OperationalActualsListController = ['$scope','$http', '$routeParams','operationalActuals', 'organisations', 'financialYears', 'financialPeriods','operationPlanDescription','breadcrumb', ($scope, $http, $routeParams, operationalActuals,organisations,financialYears,financialPeriods,operationPlanDescription,breadcrumb) ->
  $scope.targetId = $routeParams.id
  $scope.operationalActuals = operationalActuals.data
  $scope.organisations = organisations.data
  $scope.financialYears = financialYears.data
  $scope.financialPeriods = financialPeriods.data
  $scope.search = ()->
    params = {}
    angular.copy $scope.filters, params  
    params.filter = $scope.filter
    $http.get("api/operationalActuals/#{$route.current.params.id}", params:params).then((response)->
        $scope.backToBasics = response.data
        )

  $scope.$watch 'filters', (value) -> 
        if(value) then $scope.search()
    , true

  breadcrumb([
    { description: operationPlanDescription.data.name, url: "/operationalPlan/#{$routeParams.id}/1" },
    { description: 'Actuals', url: "/operationalPlan/#{$routeParams.id}/actuals" }
  ])

 # breadcrumb([
 #   { description: 'Operations Achieved'}
 # ])

]
# CoffeeScript
