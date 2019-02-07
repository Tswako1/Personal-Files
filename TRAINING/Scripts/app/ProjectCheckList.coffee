@ProjectCheckListController = ['$scope', '$http', '$routeParams','notification', 'documentTypes', 'project', 'breadcrumb', ($scope, $http, $routeParams, notification, documentTypes, project, breadcrumb) ->
    $scope.saveProjectCheckList =  ->
        if $scope.projectCheckListForm.$valid 
                $http.put("api/projectCheckList/", $scope.project)
                notification("Successfully saved")

    $scope.getDocumentCount = (documentType)->
        doc = $scope.project.projectDocuments.filter (item)->
            item.documentType == documentType
        if doc.length then doc[0].count else 0

    $scope.foreignId = $routeParams.id
    $scope.documentTypes = documentTypes.data
    $scope.project = project.data[0]
    
    breadcrumb [
        {description: project.data[0].name, url: "/projectRegistration/#{project.data[0].id}"},
        {description: 'Check List'}
    ]

]
# CoffeeScript
