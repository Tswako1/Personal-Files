@ProjectController = ['$scope', 'project', ($scope, project) ->
    $scope.project = project.data[0]
]