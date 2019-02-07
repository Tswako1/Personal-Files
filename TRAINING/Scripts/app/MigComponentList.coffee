# CoffeeScript
@MigComponentListController = ['$scope','$http', 'migComponents', 'breadcrumb', ($scope, $http, migComponents,breadcrumb) ->
  $scope.migComponents = migComponents.data
  $scope.search = ()->
    $http.get("api/migComponent/", params:filter:$scope.filter).then((response)->
        $scope.migComponents = response.data
        )

  breadcrumb([
    { description: 'Mig Components'}
  ])

]
