(function() {

  this.FrequencyOfCollectionListController = [
    '$scope', '$http', 'frequenciesOfCollection', 'breadcrumb', function($scope, $http, frequenciesOfCollection, breadcrumb) {
      $scope.frequenciesOfCollection = frequenciesOfCollection.data;
      $scope.search = function() {
        return $http.get("api/frequencyOfCollection/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.frequenciesOfCollection = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Frequency of Collection'
        }
      ]);
    }
  ];

}).call(this);
