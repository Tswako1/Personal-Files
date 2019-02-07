# CoffeeScript
@MOPIISectionController = ['$scope', '$http', '$routeParams', 'notification', 'mOPIISection', 'mOPIIKPIs','breadcrumb', ($scope, $http, $routeParams, notification, mOPIISection, mOPIIKPIs,breadcrumb) ->

    $scope.mOPIIKPIs = mOPIIKPIs.data

    fn=()->if $scope.mOPIISection.id then $http.put else $http.post
    $scope.saveMOPIISection =  ->
        if $scope.mOPIISectionForm.$valid 
            fn()("api/mOPIISection/", $scope.mOPIISection).then((response) -> 
                $scope.mOPIISection = response.data 
                notification("Successfully saved"))

    $scope.mOPIISection = mOPIISection?.data[0]||{}
   
    breadcrumb([
        { description: 'MOP Sections', url: "administration/mOPIISectionList" }
    ])



]
# CoffeeScript
