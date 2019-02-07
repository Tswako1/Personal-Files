# CoffeeScript
@ActionsTakenAgainstFraudController = ['$scope', '$http', '$routeParams', 'notification', 'actionsTakenAgainstFraud', 'breadcrumb', ($scope, $http, $routeParams, notification, actionsTakenAgainstFraud, breadcrumb) ->
    fn=()->if $scope.actionsTakenAgainstFraud.id then $http.put else $http.post
    $scope.saveActionsTakenAgainstFraud =  ->
        if $scope.actionsTakenAgainstFraudForm.$valid 
            fn()("api/actionsTakenAgainstFraud/", $scope.actionsTakenAgainstFraud).then((response) -> 
                $scope.actionsTakenAgainstFraud = response.data 
                notification("Successfully saved"))

    $scope.actionsTakenAgainstFraud = actionsTakenAgainstFraud?.data[0]||{}
   
    breadcrumb([
        { description: 'Actions Taken Against Fraud', url: "administration/actionsTakenAgainstFraudList" }
    ])



]
