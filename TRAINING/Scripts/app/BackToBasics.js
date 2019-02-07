(function() {

  this.BackToBasicsController = [
    '$scope', '$http', '$routeParams', '$location', 'operation', 'notification', 'backToBasics', 'organisations', 'financialYears', 'financialPeriods', 'causesOfProtest', 'causesOfStoppage', 'typesOfStoppage', 'actionsAgainstFraud', 'frequenciesOfCollection', 'breadcrumb', function($scope, $http, $routeParams, $location, operation, notification, backToBasics, organisations, financialYears, financialPeriods, causesOfProtest, causesOfStoppage, typesOfStoppage, actionsAgainstFraud, frequenciesOfCollection, breadcrumb) {
      var fn;
      $scope.backToBasics = backToBasics != null ? backToBasics.data : void 0;
      $scope.organisations = organisations.data;
      $scope.financialYears = financialYears.data;
      $scope.financialPeriods = financialPeriods.data;
      $scope.causesOfProtest = causesOfProtest.data;
      $scope.causesOfStoppage = causesOfStoppage.data;
      $scope.typesOfStoppage = typesOfStoppage.data;
      $scope.actionsAgainstFraud = actionsAgainstFraud.data;
      $scope.frequenciesOfCollection = frequenciesOfCollection.data;
      fn = function() {
        if ($scope.backToBasics.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveBackToBasics = function() {
        if ($scope.backToBasicsForm.$valid) {
          if (operation('CreateBackToBasics')) {
            return fn()("api/backToBasics/", $scope.backToBasics).then(function(response) {
              $scope.backToBasics.id = response.data.id;
              notification("Successfully saved");
              return $location.path("/backToBasics/" + ($routeParams.id ? $routeParams.id : $scope.backToBasics.id) + "/" + ($routeParams.page ? parseInt($routeParams.page) + 1 : 2));
            });
          } else {
            return $location.path("/backToBasics/" + $routeParams.id + "/" + (parseInt($routeParams.page) + 1));
          }
        }
      };
      return breadcrumb([
        {
          description: 'Back To Basics',
          url: '/backToBasics'
        }, {
          description: 'Create'
        }
      ]);
    }
  ];

}).call(this);
