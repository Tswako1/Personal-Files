@planFilters = {}
# CoffeeScript
@OperationalPlanListController = ['$scope','$http', 'operationalPlan', 'organisations', 'financialYears', 'breadcrumb', ($scope, $http, operationalPlan,organisations,financialYears,breadcrumb) ->
  $scope.operationalPlans = operationalPlan.data
  $scope.organisations = organisations.data
  $scope.financialYears = financialYears.data
  $scope.page = 1
  $scope.pages = (i for i in [1..(Math.ceil(operationalPlan.data.count / 10.0))])

  $scope.filters = planFilters
  
  filter = (page)->
    $scope.serverFilter = $scope.filter
    params = {}
    angular.copy $scope.filters, params
    $http.get("api/operationalPlan/", params: angular.extend(params, { filter:$scope.filter || "", page: page || 1, sort: $scope.field, desc: $scope.desc})).then (response)->
        $scope.page = page || 1
        $scope.pages = (i for i in [1..Math.max(1, Math.ceil(response.data.count / 10.0))])
        $scope.operationalPlans = response.data

  $scope.sort = (field) ->
    if($scope.field == field)
        $scope.desc = !$scope.desc
    else 
        $scope.desc = false
        $scope.field = field
    filter()
  
  $scope.search = filter
  $scope.clearSearch = () ->
    $scope.filter = null
    filter()
  
  $scope.$watch 'filters', (value) -> 
        if(value) then filter()
    , true
  
  $scope.gotoPage = (x) ->
    if x < 1 || x > ($scope.pages.length) then return
    $scope.page = x
    filter x
  

#  $scope.search = ()->
#    params = {}
#    angular.copy $scope.filters, params  
#    params.filter = $scope.filter
#    $http.get("api/operationalPlan/", params:params).then((response)->
#        $scope.backToBasics = response.data
#        )

#  $scope.$watch 'filters', (value) -> 
#        if(value) then $scope.search()
#    , true

  breadcrumb([
    { description: 'Municipal Operational Plans'}
  ])

]
# CoffeeScript
