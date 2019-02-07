@ProjectStakeHolderController = ['$scope', '$http', '$routeParams', 'notification',  'projectStakeHolder', 'projectDescription','organisations', 'breadcrumb', ($scope, $http, $routeParams, notification, projectStakeHolder, projectDescription, organisations,breadcrumb) ->

    fn=()->if $scope.projectStakeHolder.id then $http.put else $http.post
    $scope.saveProjectStakeHolder =  ->
        if $scope.projectStakeHolderForm.$valid 
            fn()("api/projectStakeHolder/", $scope.projectStakeHolder).then((response) -> 
                $scope.projectStakeHolder = response.data 
                notification("Successfully saved"))

    $scope.organisations = organisations.data
    $scope.projectId = $routeParams.projectId
    $scope.projectStakeHolder = projectStakeHolder?.data.projectStakeHolder||{projectId: $routeParams.projectId}
    $scope.projectDescription = projectDescription.data
    
         
    breadcrumb([
        { description: projectDescription.data.name, url: "projectRegistration/#{$routeParams.projectId}" },
        { description: 'Stake Holders', url: "projectRegistration/#{$routeParams.projectId}/projectStakeHolderList" }
        { description: projectStakeHolder?.data?.Name||"New Stake Holder", url: "" }
    ])

]
