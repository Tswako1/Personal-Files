@PeopleListController = ['$scope','$http', 'people', 'breadcrumb', ($scope, $http, people,breadcrumb) ->
  $scope.people = people.data
  $scope.search = ()->
    $http.get("api/people/", params:filter:$scope.filter).then((response)->
        $scope.people = response.data)

  breadcrumb([
    { description: 'People' }
  ])
]
# CoffeeScript
