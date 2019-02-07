@CauseOfStoppageController = ['$scope', '$http', '$routeParams', 'notification', 'causeOfStoppage', 'breadcrumb', ($scope, $http, $routeParams, notification, causeOfStoppage, breadcrumb) ->
    fn=()->if $scope.causeOfStoppage.id then $http.put else $http.post
    $scope.saveCauseOfStoppage =  ->
        if $scope.causeOfStoppageForm.$valid 
            fn()("api/causeOfStoppage/", $scope.causeOfStoppage).then((response) -> 
                $scope.causeOfStoppage = response.data 
                notification("Successfully saved"))

    $scope.causeOfStoppage = causeOfStoppage?.data[0]||{}
   
    breadcrumb([
        { description: 'Cause of Stoppage', url: "administration/causeOfStoppageList" }
    ])



]
