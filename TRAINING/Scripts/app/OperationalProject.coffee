@OperationalProjectController = ['$scope','$http', '$routeParams', '$location', 'operation', 'notification','operationalPlan', 'operationalProject','organisations','financialYears','financialPeriods','mopSectors', 'mopProjectTypes', 'mopProjectStages', 'fundingSources', 'fundingSourceGroups', 'mopkpis','operationPlanDescription', 'breadcrumb', ($scope, $http, $routeParams, $location, operation, notification,  operationalPlan, operationalProject,organisations,financialYears,financialPeriods,mopSectors, mopProjectTypes, mopProjectStages, fundingSources, fundingSourceGroups, mopkpis, operationPlanDescription,breadcrumb) ->
    
    $scope.operationalProject = operationalProject?.data||{mopTargetId: $routeParams.targetId, organisationId: operationalPlan.data.organisationId, financialYearId: operationalPlan.data.financialYearId}
    $scope.operationalPlan = operationalPlan.data
    $scope.organisations = organisations.data
    $scope.financialYears = financialYears.data
    $scope.financialPeriods = financialPeriods.data

    $scope.mopSectors = mopSectors.data
    $scope.mopProjectTypes = mopProjectTypes.data
    $scope.mopProjectStages = mopProjectStages.data
    $scope.fundingSources = fundingSources.data
    $scope.fundingSourceGroups = fundingSourceGroups.data
    $scope.mopkpis = mopkpis.data
    
    $scope.operationalProject.mopTargetId = $routeParams.targetId
    $scope.operationalProject.organisationId = operationalPlan.data.organisationId
    $scope.operationalProject.misaFinancialYearId = operationalPlan.data.misaFinancialYearId  

    $scope.new_ops_actual = if $scope.operationalProject?.id then  true else false
    
    fn=()->if $scope.operationalProject.id then $http.put else $http.post
   
        
    $scope.saveOperationalProject =  ->
        if $scope.operationalProjectForm.$valid 
            fn()("api/operationalProject/", $scope.operationalProject).then (response)->
                $scope.operationalProject.id = response.data.id                
                notification("Successfully saved")
            
      
    breadcrumb([
      { description: operationPlanDescription.data.name, url: "/operationalPlan/#{$routeParams.targetId}/1" },
      { description: 'Actuals', url: "/operationalPlans/#{$routeParams.targetId}/projects" }
    ])
]# CoffeeScript
