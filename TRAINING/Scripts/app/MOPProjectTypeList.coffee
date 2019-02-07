# CoffeeScript
@MOPProjectTypeListController = ['$scope','$http', 'mOPProjectTypes', 'breadcrumb', ($scope, $http, mOPProjectTypes,breadcrumb) ->
  $scope.mOPProjectTypes = mOPProjectTypes.data
  $scope.search = ()->
    $http.get("api/mOPProjectType/", params:filter:$scope.filter).then((response)->
        $scope.mOPProjectTypes = response.data
        )

  breadcrumb([
    { description: 'MOP Project Type'}
  ])

]
