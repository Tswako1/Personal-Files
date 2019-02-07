@MisaSupportAgentController = ['$scope', '$http', '$routeParams', 'notification', 'misaSupportAgent', 'breadcrumb', ($scope, $http, $routeParams, notification, misaSupportAgent, breadcrumb) ->
    fn=()->if $scope.misaSupportAgent.id then $http.put else $http.post
    $scope.saveMisaSupportAgent =  ->
        if $scope.misaSupportAgentForm.$valid 
            fn()("api/misaSupportAgent/", $scope.misaSupportAgent).then((response) -> 
                $scope.misaSupportAgent = response.data 
                notification("Successfully saved"))

    $scope.misaSupportAgent = misaSupportAgent?.data[0]||{}
   
    breadcrumb([
        { description: 'Misa Support Agents', url: "administration/misaSupportAgentList" }
    ])



]
# CoffeeScript
