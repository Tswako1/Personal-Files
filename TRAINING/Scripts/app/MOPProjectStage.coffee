# CoffeeScript
@MOPProjectStageController = ['$scope', '$http', '$routeParams', 'notification', 'mOPProjectStage', 'breadcrumb', ($scope, $http, $routeParams, notification, mOPProjectStage, breadcrumb) ->
    fn=()->if $scope.mOPProjectStage.id then $http.put else $http.post
    $scope.saveMOPProjectStage =  ->
        if $scope.mOPProjectStageForm.$valid 
            fn()("api/mOPProjectStage/", $scope.mOPProjectStage).then((response) -> 
                $scope.mOPProjectStage = response.data 
                notification("Successfully saved"))

    $scope.mOPProjectStage = mOPProjectStage?.data[0]||{}
   
    breadcrumb([
        { description: 'MOP Project Stages', url: "administration/mOPProjectStageList" }
    ])



]
