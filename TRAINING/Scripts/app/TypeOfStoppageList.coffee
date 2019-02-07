# CoffeeScript
@TypeOfStoppageListController = ['$scope','$http', 'typesOfStoppage', 'breadcrumb', ($scope, $http, typesOfStoppage,breadcrumb) ->
  $scope.typesOfStoppage = typesOfStoppage.data
  $scope.search = ()->
    $http.get("api/typeOfStoppage/", params:filter:$scope.filter).then((response)->
        $scope.typesOfStoppage = response.data
        )

  breadcrumb([
    { description: 'Types of Stoppages'}
  ])

]
# CoffeeScript
# CoffeeScript
