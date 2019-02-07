@OperationalActualsController = ['$scope','$http', '$routeParams', '$location', 'operation', 'notification','documentTypes','operationalPlan', 'operationalActuals', 'operationalActual','organisations','financialYears','financialPeriods','operationPlanDescription', 'breadcrumb', ($scope, $http, $routeParams, $location, operation, notification, documentTypes, operationalPlan, operationalActuals, operationalActual,organisations,financialYears,financialPeriods,operationPlanDescription, breadcrumb) ->
    
    $scope.operationalActual = operationalActual?.data||{operationalPlanTargetId: $routeParams.targetId, organisationId: operationalPlan.data.organisationId, financialYearId: operationalPlan.data.financialYearId}
    $scope.operationalPlan = operationalPlan.data
    $scope.organisations = organisations.data
    $scope.financialYears = financialYears.data
    $scope.financialPeriods = financialPeriods.data
    $scope.documentTypes = documentTypes.data
    $scope.operationalActuals = operationalActuals.data[0]
    
    $scope.operationalActual.mopTargetId = $routeParams.targetId
    $scope.operationalActual.organisationId = operationalPlan.data.organisationId
    $scope.operationalActual.misaFinancialYearId = operationalPlan.data.misaFinancialYearId  

    $scope.new_ops_actual = if $scope.operationalActual?.id then  true else false
    
    fn=()->if $scope.operationalActual.id then $http.put else $http.post
   
    $scope.getDocumentCount = (documentType)->
      doc = $scope.operationalActual.projectDocuments.filter (item)->
        item.documentType == documentType
      if doc.length then doc[0].count else 0
        
    $scope.saveOperationalActual =  ->
        if $scope.operationalActualForm.$valid 
              fn()("api/operationalActual/", $scope.operationalActual).then (response)->
                  $scope.operationalActual.id = response.data.id                
                  notification("Successfully saved")
#                    $location.path "/operationalPlan/#{$routeParams.targetId}/actuals/#{if $routeParams.id then $routeParams.id else $scope.operationalActual.id}/#{if $routeParams.page then parseInt($routeParams.page) + 1 else 2}"
#            else
#                $location.path "/operationalPlan/#{$routeParams.targetId}/actuals/#{$routeParams.id}/#{parseInt($routeParams.page) + 1}"
            
      
    breadcrumb([
      { description: operationPlanDescription.data.name, url: "/operationalPlan/#{$routeParams.targetId}/1" },
      { description: 'Actuals', url: "/operationalPlan/#{$routeParams.targetId}/actuals" }
    ])
]# CoffeeScript
