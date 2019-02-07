# CoffeeScript
@MOPResponsiblePeopleListController = ['$scope','$http', 'mOPResponsiblePeoples', 'breadcrumb', ($scope, $http, mOPResponsiblePeoples,breadcrumb) ->
  $scope.mOPResponsiblePeoples = mOPResponsiblePeoples.data
  $scope.search = ()->
    $http.get("api/mOPResponsiblePeople/", params:filter:$scope.filter).then((response)->
        $scope.mOPResponsiblePeoples = response.data
        )

  breadcrumb([
    { description: 'MOP Responsible People'}
  ])

]
