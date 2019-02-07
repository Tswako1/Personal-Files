# CoffeeScript
@OperationalProjectsListController = ['$scope','$http', '$routeParams','operationalProjects', 'organisations', 'financialYears', 'financialPeriods','operationPlanDescription','breadcrumb', ($scope, $http, $routeParams, operationalProjects,organisations,financialYears,financialPeriods,operationPlanDescription,breadcrumb) ->
  $scope.targetId = $routeParams.id
  $scope.operationalProjects = operationalProjects.data
  $scope.organisations = organisations.data
  $scope.financialYears = financialYears.data
  $scope.financialPeriods = financialPeriods.data
  $scope.search = ()->
    params = {}
    angular.copy $scope.filters, params  
    params.filter = $scope.filter
    $http.get("api/operationalProject/#{$route.current.params.id}", params:params).then((response)->
        $scope.backToBasics = response.data
        )

  $scope.$watch 'filters', (value) -> 
        if(value) then $scope.search()
    , true

  breadcrumb([
    { description: operationPlanDescription.data.name, url: "/operationalPlan/#{$routeParams.id}/1" },
    { description: 'Projects', url: "/operationalPlans/#{$routeParams.id}/projects" }
  ])

]
# CoffeeScript
