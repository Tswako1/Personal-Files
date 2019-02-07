@ProjectRegistrationContoller = ['$scope', '$http', '$routeParams', '$modal', 'notification', 'organisations', 'projectStatus', 'infrastructureLifeCycles', 'implementingAgents', 'misaSupportAgents', 'migComponents','sectorProgrammes', 'developmentalLocations', 'crossCuttingProgrammes', 'fundingSources','project', 'breadcrumb', ($scope, $http, $routeParams, $modal, notification, organisations, projectStatus, infrastructureLifeCycles, implementingAgents, misaSupportAgents, migComponents, sectorProgrammes, developmentalLocations, crossCuttingProgrammes, fundingSources, project, breadcrumb) ->
   fn=()->if $scope.project.id then $http.put else $http.post
   $scope.saveProjectRegistration =  ->
        if $scope.projectRegistrationForm.$valid 
            fn()("api/project/", $scope.project).then (response)->
                $scope.project.id = response.data.id
                notification("Successfully saved")

    #$scope.infrastructureRegisters = infrastructureRegisters.data
    $scope.organisations = organisations.data
    $scope.projectStatus = projectStatus.data
    $scope.infrastructureLifeCycles = infrastructureLifeCycles.data
    $scope.implementingAgents = implementingAgents.data
    $scope.misaSupportAgents = misaSupportAgents.data
    $scope.migComponents = migComponents.data
    $scope.sectorProgrammes = sectorProgrammes.data
    $scope.developmentalLocations = developmentalLocations.data
    $scope.crossCuttingProgrammes = crossCuttingProgrammes.data
    $scope.fundingSources = fundingSources.data
    $scope.autoproject = if project?.data[0]
        "PR-" + project?.data[0].sectorCode + "-" + project?.data[0].autoNumber   
    
    $scope.$watch "project.organisationId" , (id)->
        if $scope.project.organisationId 
            if !$scope.project.parentProjectNumber then $scope.project.parentProjectNumber = "Not Applicable"
            if !$scope.project.projectStatusId then $scope.project.projectStatusId = 1
            $scope.wards = $http.get "lookup/Wards", params: id: id
            if $scope.project.sectorProgrammeId
                $scope.infrastructureRegisters = $http.get "lookup/InfrastructureRegistersByOrganisationAndSector", params: organisationId: $scope.project.organisationId, sectorProgrammeId: $scope.project.sectorProgrammeId
                $scope.test = $scope.infrastructureRegisters.data                 

    $scope.$watch "project.sectorProgrammeId" , (id)->
        if $scope.project.organisationId 
            $scope.infrastructureRegisters = $http.get "lookup/InfrastructureRegistersByOrganisationAndSector", params: organisationId: $scope.project.organisationId, sectorProgrammeId: $scope.project.sectorProgrammeId
            $scope.test = $scope.infrastructureRegisters.data                 

    $scope.project = project?.data[0]||{}
    
    $scope.selectLocation = ->
        dialog = {}
        dialog.modal = $modal.open 
            templateUrl: "content/views/map.html"
            controller: mapController
            resolve:
                organisation: ['$http',($http) -> $http.get "faultReport/municipality/#{$scope.project.organisationId}"]
                location: -> lat: $scope.project.lattitude, long: $scope.project.longitude
                dialog: -> dialog
        dialog.modal.result.then (location) ->
            if location 
                $scope.project.lattitude = location.lat
                $scope.project.longitude = location.long

    breadcrumb [description: project?.data[0].name || 'New Project']
]# CoffeeScript
