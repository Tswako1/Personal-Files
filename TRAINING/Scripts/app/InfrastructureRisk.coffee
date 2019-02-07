@InfrastructureRiskController = ['$scope', '$http', '$routeParams', 'notification', 'riskTypes', 'riskConsequences', 'riskProbabilities', 'infrastructureRisk', 'infrastructureRiskDescription', 'breadcrumb', ($scope, $http, $routeParams, notification, riskTypes, riskConsequences, riskProbabilities, infrastructureRisk,infrastructureRiskDescription, breadcrumb) ->
    fn=()->if $scope.infrastructureRisk.id then $http.put else $http.post
    $scope.saveInfrastructureRisk =  ->
        if $scope.infrastructureRiskForm.$valid 
            fn()("api/infrastructureRisk/", $scope.infrastructureRisk).then((response) -> 
                $scope.infrastructureRisk = response.data 
                notification("Successfully saved"))
    $scope.infrastructureRegisterId = $routeParams.id
    $scope.infrastructureRisk = infrastructureRisk?.data.risk||{infrastructureRegisterId: $routeParams.id}
    $scope.riskTypes = riskTypes.data
    $scope.riskConsequences = riskConsequences.data
    $scope.riskProbabilities = riskProbabilities.data
    $scope.infrastructureRiskDescription = infrastructureRiskDescription.data
    
    breadcrumb([
        { description: infrastructureRiskDescription.data.description, url: "infrastructureRegister/#{$routeParams.id}" },
        { description: 'Risks', url: "infrastructureRegister/#{$routeParams.id}/infrastructureRisk" }
        { description: infrastructureRisk?.data?.risk.description||"New Risk", url: "" }
    ])

]
