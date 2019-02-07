@TypeOfStoppageController = ['$scope', '$http', '$routeParams', 'notification', 'typeOfStoppage', 'breadcrumb', ($scope, $http, $routeParams, notification, typeOfStoppage, breadcrumb) ->
    fn=()->if $scope.typeOfStoppage.id then $http.put else $http.post
    $scope.saveTypeOfStoppage =  ->
        if $scope.typeOfStoppageForm.$valid 
            fn()("api/typeOfStoppage/", $scope.typeOfStoppage).then((response) -> 
                $scope.typeOfStoppage = response.data 
                notification("Successfully saved"))

    $scope.typeOfStoppage = typeOfStoppage?.data[0]||{}
   
    breadcrumb([
        { description: 'Types of Stoppage', url: "administration/typeOfStoppageList" }
    ])



]
