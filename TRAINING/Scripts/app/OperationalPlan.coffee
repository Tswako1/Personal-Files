@OperationalPlanController = ['$scope','$http', '$routeParams', '$location', 'operation', 'notification', 'operationalPlan','organisations','financialYears', 'breadcrumb', ($scope, $http, $routeParams, $location, operation, notification, operationalPlan,organisations,financialYears, breadcrumb) ->
    
    $scope.operationalPlan = operationalPlan?.data
    $scope.organisations = organisations.data
    $scope.financialYears = financialYears.data
   
    $scope.new_ops_plan = if $scope.operationalPlan?.id then true else false
    
    fn=()->if $scope.operationalPlan.id then $http.put else $http.post
   
    $scope.saveOperationalPlan =  ->
        if $scope.operationalPlanForm.$valid 
            fn()("api/operationalPlan/", $scope.operationalPlan).then (response)->
                $scope.operationalPlan.id = response.data.id                
                notification("Successfully saved")
#                    $location.path "/operationalPlan/#{if $routeParams.id then $routeParams.id else $scope.operationalPlan.id}/#{if $routeParams.page then parseInt($routeParams.page) + 1 else 2}"
#            else
#                $location.path "/operationalPlan/#{$routeParams.id}/#{parseInt($routeParams.page) + 1}"
            
      
    breadcrumb([
        { description: 'Operations', url: '/operationalPlan'},
        { description: 'Create'}
    ])
]# CoffeeScript
