(function() {

  this.FrequencyOfCollectionController = [
    '$scope', '$http', '$routeParams', 'notification', 'frequencyOfCollection', 'breadcrumb', function($scope, $http, $routeParams, notification, frequencyOfCollection, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.frequencyOfCollection.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveFrequencyOfCollection = function() {
        if ($scope.frequencyOfCollectionForm.$valid) {
          return fn()("api/frequencyOfCollection/", $scope.frequencyOfCollection).then(function(response) {
            $scope.frequencyOfCollection = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.frequencyOfCollection = (frequencyOfCollection != null ? frequencyOfCollection.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Frequency Of Collection',
          url: "administration/frequencyOfCollectionList"
        }
      ]);
    }
  ];

}).call(this);
