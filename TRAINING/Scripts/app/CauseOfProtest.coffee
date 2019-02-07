@CauseOfProtestController = ['$scope', '$http', '$routeParams', 'notification', 'causeOfProtest', 'breadcrumb', ($scope, $http, $routeParams, notification, causeOfProtest, breadcrumb) ->
    fn=()->if $scope.causeOfProtest.id then $http.put else $http.post
    $scope.saveCauseOfProtest =  ->
        if $scope.causeOfProtestForm.$valid 
            fn()("api/causeOfProtest/", $scope.causeOfProtest).then((response) -> 
                $scope.causeOfProtest = response.data 
                notification("Successfully saved"))

    $scope.causeOfProtest = causeOfProtest?.data[0]||{}
   
    breadcrumb([
        { description: 'Cause of Protest', url: "administration/causeOfProtestList" }
    ])



]
