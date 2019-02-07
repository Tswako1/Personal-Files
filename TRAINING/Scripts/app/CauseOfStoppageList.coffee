# CoffeeScript
@CauseOfStoppageListController = ['$scope','$http', 'causesOfStoppage', 'breadcrumb', ($scope, $http, causesOfStoppage,breadcrumb) ->
  $scope.causesOfStoppage = causesOfStoppage.data
  $scope.search = ()->
    $http.get("api/causeOfStoppage/", params:filter:$scope.filter).then((response)->
        $scope.causesOfStoppages = response.data
        )

  breadcrumb([
    { description: 'Causes of Stoppages'}
  ])

]
# CoffeeScript
# CoffeeScript
