@OperationalOverviewController = ['$scope','$http', '$routeParams', '$location', 'operation', 'notification','documentTypes','operationalPlan', 'operationalActuals','operationalProjects','operationPlanDocumentsQ1','operationPlanDocumentsQ2','operationPlanDocumentsQ3','operationPlanDocumentsQ4', ($scope, $http, $routeParams, $location, operation, notification, documentTypes, operationalPlan, operationalActuals,operationalProjects,operationPlanDocumentsQ1,operationPlanDocumentsQ2,operationPlanDocumentsQ3,operationPlanDocumentsQ4 ) ->
    
    $scope.operationalActuals = operationalActuals.data[0]
    $scope.operationalPlan = operationalPlan.data
    $scope.operationalProjects = operationalProjects.data
    $scope.operationPlanDocumentsQ1 = operationPlanDocumentsQ1.data
    $scope.operationPlanDocumentsQ2 = operationPlanDocumentsQ2.data
    $scope.operationPlanDocumentsQ3 = operationPlanDocumentsQ3.data
    $scope.operationPlanDocumentsQ4 = operationPlanDocumentsQ4.data
    $scope.documentTypes = documentTypes.data
    
    $scope.new_ops_plan = if $scope.operationalPlan?.id then true else false
    
    params = {}

    
    fn=()->if $scope.operationalPlan.id then $http.put else $http.post
   
    $scope.saveDocumentValidation =  ->
        if $scope.mopDocumentValidation.$valid 
            fn()("api/document/",  { mOPDocumentsQ1:$scope.operationPlanDocumentsQ1,mOPDocumentsQ2:$scope.operationPlanDocumentsQ2,mOPDocumentsQ3:$scope.operationPlanDocumentsQ3,mOPDocumentsQ4:$scope.operationPlanDocumentsQ4}).then (response)->
                notification("Successfully saved")

]# CoffeeScript
