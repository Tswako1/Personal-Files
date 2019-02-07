@ProjectRiskController = ['$scope', '$http', '$routeParams', 'notification', 'projectRiskTypes', 'projectRiskCategories', 'riskConsequences', 'riskProbabilities', 'projectRisk', 'projectRiskDescription', 'projectDescription','people', 'breadcrumb', ($scope, $http, $routeParams, notification, projectRiskTypes, projectRiskCategories, riskConsequences, riskProbabilities, projectRisk,projectRiskDescription, projectDescription, people, breadcrumb) ->
 
    fn=()->if $scope.projectRisk.id then $http.put else $http.post
    $scope.saveProjectRisk =  ->
        if $scope.projectRiskForm.$valid 
            fn()("api/projectRisk/", $scope.projectRisk).then((response) -> 
                $scope.projectRisk.id = response.data.id  
                notification("Successfully saved"))

    $scope.projectId = $routeParams.projectId 
    $scope.projectRisk = projectRisk?.data.risk||{projectId: $routeParams.projectId}
    $scope.projectRiskTypes = projectRiskTypes.data
    #$scope.riskCategories = riskCategories.data
    $scope.riskConsequences = riskConsequences.data
    $scope.riskProbabilities = riskProbabilities.data
    $scope.projectRiskDescription = projectRiskDescription?.data
    $scope.projectDescription = projectDescription.data
    $scope.people = people.data
    
    if projectRisk then $scope.projectRiskTypeId = projectRiskCategories.data.filter((x)->x.id == projectRisk.data.risk.projectRiskCategoryId)[0].projectRiskTypeId

    $scope.$watch('projectRiskTypeId',(value) ->
        $scope.projectRiskCategories = projectRiskCategories.data.filter((x) -> x.projectRiskTypeId == value) 
    )
         
    breadcrumb([
        { description: projectDescription.data.name, url: "projectRegistration/#{$routeParams.projectId}" },
        { description: 'Risks', url: "projectRegistration/#{$routeParams.projectId}/riskList" }
        { description: projectRisk?.data?.risk.description||"New Risk", url: "" }
    ])

]
