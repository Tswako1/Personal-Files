# CoffeeScript
@MOPProjectStageListController = ['$scope','$http', 'mOPProjectStages', 'breadcrumb', ($scope, $http, mOPProjectStages,breadcrumb) ->
  $scope.mOPProjectStages = mOPProjectStages.data
  $scope.search = ()->
    $http.get("api/mOPProjectStage/", params:filter:$scope.filter).then((response)->
        $scope.mOPProjectStages = response.data
        )

  breadcrumb([
    { description: 'MOP Project Stages'}
  ])

]
