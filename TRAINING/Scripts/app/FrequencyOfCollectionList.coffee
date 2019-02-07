# CoffeeScript
@FrequencyOfCollectionListController = ['$scope','$http', 'frequenciesOfCollection', 'breadcrumb', ($scope, $http, frequenciesOfCollection,breadcrumb) ->
  $scope.frequenciesOfCollection = frequenciesOfCollection.data
  $scope.search = ()->
    $http.get("api/frequencyOfCollection/", params:filter:$scope.filter).then((response)->
        $scope.frequenciesOfCollection = response.data
        )

  breadcrumb([
    { description: 'Frequency of Collection'}
  ])

]
# CoffeeScript
