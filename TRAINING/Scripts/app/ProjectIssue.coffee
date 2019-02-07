@ProjectIssueController = ['$scope', '$http', '$routeParams', 'notification', 'issueSeverity', 'issueProbability', 'projectIssue', 'projectIssueDescription', 'projectDescription','people', 'breadcrumb', ($scope, $http, $routeParams, notification, issueSeverity, issueProbability, projectIssue,projectIssueDescription, projectDescription, people, breadcrumb) ->
    fn=()->if $scope.projectIssue.id then $http.put else $http.post
    $scope.saveProjectIssue =  ->
        if $scope.projectIssueForm.$valid 
            fn()("api/projectIssue/", $scope.projectIssue).then((response) -> 
                $scope.projectIssue.id = response.data.id 
                notification("Successfully saved"))

    $scope.projectId = $routeParams.projectId
    $scope.projectIssue = projectIssue?.data.issue||{projectId: $routeParams.projectId}
    $scope.issueSeverities = issueSeverity.data
    $scope.issueProbabilities = issueProbability.data
    $scope.projectIssueDescription = projectIssueDescription?.data
    $scope.projectDescription = projectDescription.data
    $scope.people = people.data
    
    breadcrumb([
        { description: projectDescription.data.name, url: "projectRegistration/#{$routeParams.projectId}" },
        { description: 'Issues', url: "projectRegistration/#{$routeParams.projectId}/issueList" }
        { description: projectIssue?.data?.issue.description||"New Issue", url: "" }
    ])

]
