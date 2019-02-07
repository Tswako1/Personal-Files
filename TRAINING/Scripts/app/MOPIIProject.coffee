# CoffeeScript
@MOPIIProjectController = ['$scope','$http', '$routeParams', '$location', 'operation', 'notification','operationalPlan', 'mOPIIProject','organisations','financialYears','financialPeriods','mopSectors', 'mopProjectTypes', 'mopProjectStages', 'fundingSources', 'fundingSourceGroups', 'mopkpis','operationPlanDescription', 'breadcrumb', ($scope, $http, $routeParams, $location, operation, notification,  operationalPlan, mOPIIProject,organisations,financialYears,financialPeriods,mopSectors, mopProjectTypes, mopProjectStages, fundingSources, fundingSourceGroups, mopkpis, operationPlanDescription,breadcrumb) ->
    
    $scope.mOPIIProject = mOPIIProject?.data||{mopTargetId: $routeParams.targetId, organisationId: operationalPlan.data.organisationId, financialYearId: operationalPlan.data.financialYearId}
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
    
    $scope.mOPIIProject.mOPIIPlanId = $routeParams.targetId
    $scope.mOPIIProject.organisationId = operationalPlan.data.organisationId
    $scope.mOPIIProject.misaFinancialYearId = operationalPlan.data.yearId  

    $scope.new_ops_actual = if $scope.mOPIIProject?.id then  true else false
    
    fn=()->if $scope.mOPIIProject.id then $http.put else $http.post
   
        
    $scope.saveMOPIIProject =  ->
        if $scope.mOPIIProjectForm.$valid 
            if operation('CreateOperationalPlan') 
                fn()("api/mOPIIProject/", $scope.mOPIIProject).then (response)->
                    $scope.mOPIIProject.id = response.data.id                
                    notification("Successfully saved")
            
      
    breadcrumb([
        { description: 'Operations', url: "operations/plans" }
    ])
]# CoffeeScript
