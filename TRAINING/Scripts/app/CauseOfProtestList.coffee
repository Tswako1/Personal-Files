# CoffeeScript
@CauseOfProtestListController = ['$scope','$http', 'causesOfProtest', 'breadcrumb', ($scope, $http, causesOfProtest,breadcrumb) ->
  $scope.causesOfProtest = causesOfProtest.data
  $scope.search = ()->
    $http.get("api/causeOfProtest/", params:filter:$scope.filter).then((response)->
        $scope.causesOfProtest = response.data
        )

  breadcrumb([
    { description: 'Causes of Protests'}
  ])

]
# CoffeeScript
