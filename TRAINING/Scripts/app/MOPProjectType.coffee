# CoffeeScript
@MOPProjectTypeController = ['$scope', '$http', '$routeParams', 'notification', 'mOPProjectType', 'breadcrumb', ($scope, $http, $routeParams, notification, mOPProjectType, breadcrumb) ->
    fn=()->if $scope.mOPProjectType.id then $http.put else $http.post
    $scope.saveMOPProjectType =  ->
        if $scope.mOPProjectTypeForm.$valid 
            fn()("api/mOPProjectType/", $scope.mOPProjectType).then((response) -> 
                $scope.mOPProjectType = response.data 
                notification("Successfully saved"))

    $scope.mOPProjectType = mOPProjectType?.data[0]||{}
   
    breadcrumb([
        { description: 'MOP Project Types', url: "administration/mOPProjectTypeList" }
    ])



]
