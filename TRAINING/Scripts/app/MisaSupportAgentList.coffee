# CoffeeScript
@MisaSupportAgentListController = ['$scope','$http', 'misaSupportAgents', 'breadcrumb', ($scope, $http, misaSupportAgents,breadcrumb) ->
  $scope.misaSupportAgents = misaSupportAgents.data
  $scope.search = ()->
    $http.get("api/misaSupportAgent/", params:filter:$scope.filter).then((response)->
        $scope.misaSupportAgents = response.data
        )

  breadcrumb([
    { description: 'Misa Support Agents'}
  ])

]
