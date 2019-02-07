@FaultOrganisationSectorPersonController = ['$scope','$http', 'notification', 'faultOrganisationSectorPerson','provinces','sectors', 'breadcrumb', ($scope, $http, notification, faultOrganisationSectorPerson, provinces, sectors, breadcrumb) ->
    $scope.faultOrganisationSectorPerson = faultOrganisationSectorPerson?.data[0]
    $scope.provinces = provinces.data
    $scope.sectors = sectors.data
    $scope.isUpdate = (faultOrganisationSectorPerson != null)
    
    fn=()->if $scope.faultOrganisationSectorPerson.id then $http.put else $http.post
   
    $scope.save =  ->
        if $scope.faultOrganisationSectorPersonForm.$valid 
            fn()("api/faultOrganisationSectorPerson/", $scope.faultOrganisationSectorPerson).then (response)->
                $scope.faultOrganisationSectorPerson.id = response.data.id
                notification("Successfully saved")

    $scope.$watch "faultOrganisationSectorPerson.provinceCode" , (id)->
        if id && $scope.faultOrganisationSectorPerson.provinceCode
            $http.get("lookup/districtsByProvince", params: provinceId: $scope.faultOrganisationSectorPerson.provinceCode).then ($response)->
                $scope.districts = $response.data    

    $scope.$watch "faultOrganisationSectorPerson.districtCode" , (id)->
        if id && $scope.faultOrganisationSectorPerson.districtCode
            $http.get("lookup/organisationsWithProviceAndDistrictByDistrict", params: districtId: $scope.faultOrganisationSectorPerson.districtCode).then ($response)->
                $scope.organisations = $response.data 

    $scope.$watch "faultOrganisationSectorPerson.sectorProgrammeId" , (id)->
        if id && $scope.faultOrganisationSectorPerson?.sectorProgrammeId && $scope.faultOrganisationSectorPerson?.organisationId
            $http.get("lookup/peopleByOrganisationsAndSector", params: organisationId: $scope.faultOrganisationSectorPerson.organisationId, sectorProgrammeId: $scope.faultOrganisationSectorPerson.sectorProgrammeId).then ($response) ->
                $scope.people = $response.data            

    $scope.$watch "faultOrganisationSectorPerson.organisationId" , (id)->
        if id && $scope.faultOrganisationSectorPerson?.sectorProgrammeId && $scope.faultOrganisationSectorPerson?.organisationId
            $http.get("lookup/peopleByOrganisationsAndSector", params: organisationId: $scope.faultOrganisationSectorPerson.organisationId, sectorProgrammeId: $scope.faultOrganisationSectorPerson.sectorProgrammeId).then ($response) ->
                $scope.people = $response.data            
  
    breadcrumb([
        { description: 'Fault Responsible People', url: '/administration/faultOrganisationSectorPersonList'},
        { description: 'Create'}
    ])
]# CoffeeScript
