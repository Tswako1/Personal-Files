@SectorProgrammeController = ['$scope', '$http', '$routeParams', 'notification', 'sectorProgramme', 'breadcrumb', ($scope, $http, $routeParams, notification, sectorProgramme, breadcrumb) ->
    fn=()->if $scope.sectorProgramme.id then $http.put else $http.post
    $scope.saveSectorProgramme =  ->
        if $scope.sectorProgrammeForm.$valid 
            fn()("api/sectorProgramme/", $scope.sectorProgramme).then((response) -> 
                $scope.sectorProgramme = response.data 
                notification("Successfully saved"))

    $scope.sectorProgramme = sectorProgramme?.data[0]||{}
   
    breadcrumb([
        { description: 'Sector Programmes', url: "administration/sectorProgrammeList" }
    ])



]
# CoffeeScript
