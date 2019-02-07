@InfrastructureRegisterController = ['$scope', '$http', '$modal', '$routeParams', 'notification', 'organisations', 'criticalityGrades','conditions', 'assetClasses','sectorProgrammes', 'documentTypes', 'infrastructureRegister', 'breadcrumb', ($scope, $http, $modal, $routeParams, notification, organisations, criticalityGrades, conditions , assetClasses, sectorProgrammes, documentTypes, infrastructureRegister, breadcrumb) ->
   fn=()->if $scope.infrastructureRegister.id then $http.put else $http.post
   $scope.saveInfrastructureRegister =  ->
        if $scope.infrastructureRegisterForm.$valid 
            $scope.infrastructureRegister.purchasePrice=if parseInt($scope.priceOption) == 0 then $scope.price else 0
            $scope.infrastructureRegister.deemedCost=if parseInt($scope.priceOption) == 1 then $scope.price else 0
            fn()("api/infrastructureRegister/", $scope.infrastructureRegister).then (response)->
                $scope.infrastructureRegister = response.data[0]
                notification("Successfully saved")
  
   $scope.autoir = if infrastructureRegister?.data[0]
        "IR-" + infrastructureRegister?.data[0].assetClass.code + "-" + infrastructureRegister?.data[0].autoNumber   
        
   $scope.LookupSpatialData = ->
            $http.get("api/spatial", params: longitude: $scope.infrastructureRegister.locationX, latitude: $scope.infrastructureRegister.locationY ).then ($response)->
                $scope.position = $response.data 
    
   $scope.getDocumentCount = (documentType)->
      doc = $scope.infrastructureRegister.projectDocuments.filter (item)->
        item.documentType == documentType
      if doc.length then doc[0].count else 0

    getinfrastructureRegister = ->
          $scope.priceOption  = if $scope.infrastructureRegister.purchasePrice != 0 then 0 else 1
          $scope.price = if $scope.priceOption == 0 then $scope.infrastructureRegister.purchasePrice else $scope.infrastructureRegister.deemedCost
    $scope.organisations = organisations.data
    $scope.criticalityGrades = criticalityGrades.data
    $scope.conditions = conditions.data
    $scope.assetClasses = assetClasses.data
    $scope.sectorProgrammes = sectorProgrammes.data
    $scope.documentTypes = documentTypes.data

    breadcrumb([description: infrastructureRegister?.data[0].description])
            
    $scope.infrastructureRegister = infrastructureRegister?.data[0]||{}

    if($scope.organisations.length == 1 && !$scope.infrastructureRegister.organisationId)
        $scope.infrastructureRegister.organisationId = $scope.organisations[0].id

    $scope.iswardselected = (ward)-> if $scope.infrastructureRegister.wards.filter((x)->x.id == ward.id).length > 0 then "selected"

    $scope.$watch "selected" , (selected)->$scope.infrastructureRegister.conditionId  = selected?.id
    
    $scope.$watch "infrastructureRegister.organisationId" ,  (id)->
        if ($scope.infrastructureRegister.organisationId) 
            $scope.wards = $http.get "lookup/Wards", params: id: id
        if $scope.infrastructureRegister.sectorProgrammeId
            $scope.parentInfrastructureRegisters = $http.get "lookup/InfrastructureRegistersByOrganisationAndSector", params: organisationId: $scope.infrastructureRegister.organisationId, sectorProgrammeId: $scope.infrastructureRegister.sectorProgrammeId

    $scope.$watch "infrastructureRegister.sectorProgrammeId" , (id)->
        if $scope.infrastructureRegister.organisationId 
            $scope.parentInfrastructureRegisters = $http.get "lookup/InfrastructureRegistersByOrganisationAndSector", params: organisationId: $scope.infrastructureRegister.organisationId, sectorProgrammeId: $scope.infrastructureRegister.sectorProgrammeId

    now = new Date();

    $scope.$watch 'infrastructureRegister.yearConstructedPurchaseDate', (x) ->
        date = Date.parse(x)
        $scope.infrastructureRegisterForm['yearConstructedPurchaseDate'].$setValidity "min", !x || date <= now

                
    $scope.selectLocation = ->
        dialog = {}
        dialog.modal = $modal.open 
            templateUrl: "content/views/map.html"
            controller: mapController
            resolve:
                organisation: ['$http',($http) -> $http.get "faultReport/municipality/#{$scope.infrastructureRegister.organisationId}"]
                location: -> lat: $scope.infrastructureRegister.locationY, long: $scope.infrastructureRegister.locationX
                dialog: -> dialog
        dialog.modal.result.then (location) ->
            if location 
                $scope.infrastructureRegister.locationX = location.long
                $scope.infrastructureRegister.locationY = location.lat
                                                
    if $scope.infrastructureRegister 
       $scope.selected = conditions.data.filter ((x) -> x.id == $scope.infrastructureRegister.conditionId)
       $scope.selected = $scope.selected[0]
    getinfrastructureRegister()
]# CoffeeScript
