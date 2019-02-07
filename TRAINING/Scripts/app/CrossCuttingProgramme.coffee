@CrossCuttingProgrammeController = ['$scope', '$http', '$routeParams', 'notification', 'crossCuttingProgramme', 'breadcrumb', ($scope, $http, $routeParams, notification, crossCuttingProgramme, breadcrumb) ->
    fn=()->if $scope.crossCuttingProgramme.id then $http.put else $http.post
    $scope.saveCrossCuttingProgramme =  ->
        if $scope.crossCuttingProgrammeForm.$valid 
            fn()("api/crossCuttingProgramme/", $scope.crossCuttingProgramme).then((response) -> 
                $scope.crossCuttingProgramme = response.data 
                notification("Successfully saved"))

    $scope.crossCuttingProgramme = crossCuttingProgramme?.data[0]||{}
   
    breadcrumb([
        { description: 'Cross Cutting Programmes', url: "administration/crossCuttingProgrammeList" }
    ])



]
# CoffeeScript
