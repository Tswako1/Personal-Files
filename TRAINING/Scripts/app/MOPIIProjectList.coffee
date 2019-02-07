# CoffeeScript
@MOPIIProjectsListController = ['$scope','$http', '$routeParams','mOPIIProjects', 'organisations', 'financialYears', 'financialPeriods','operationPlanDescription','breadcrumb', ($scope, $http, $routeParams, mOPIIProjects,organisations,financialYears,financialPeriods,operationPlanDescription,breadcrumb) ->
  $scope.targetId = $routeParams.id
  $scope.mOPIIProjects = mOPIIProjects.data
  $scope.organisations = organisations.data
  $scope.financialYears = financialYears.data
  $scope.financialPeriods = financialPeriods.data
  $scope.search = ()->
    params = {}
    angular.copy $scope.filters, params  
    params.filter = $scope.filter
    $http.get("api/mOPIIProject/#{$route.current.params.id}", params:params).then((response)->
        $scope.backToBasics = response.data
        )

  $scope.$watch 'filters', (value) -> 
        if(value) then $scope.search()
    , true

  breadcrumb([
        { description: 'Operations', url: "operations/plans" }
  ])

]
# CoffeeScript
