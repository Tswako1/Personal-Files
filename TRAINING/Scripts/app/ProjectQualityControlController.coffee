@ProjectQualityControlController = ['$scope', '$http', '$routeParams', 'checks', 'projectDescription', 'breadcrumb', 'notification', ($scope, $http, $routeParams, checks, projectDescription, breadcrumb, notification) -> 
    $scope.checks = checks.data
    $scope.projectDescription = projectDescription.data

    $scope.save = () -> 
        $http.put('api/ProjectQualityChecks', $scope.checks).then (response) ->
            notification 'Successfully saved'

    breadcrumb([
        { description: projectDescription.data.name, url: "projectRegistration/#{$routeParams.id}" },
        { description: 'Quality Control', url: "projectRegistration/#{$routeParams.id}/qualityControl" }
        
    ])


]