(function() {

  this.MOPResponsiblePeopleController = [
    '$scope', '$http', '$routeParams', 'notification', 'organisations', 'mOPResponsiblePeople', 'breadcrumb', function($scope, $http, $routeParams, notification, organisations, mOPResponsiblePeople, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.mOPResponsiblePeople.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveMOPResponsiblePeople = function() {
        if ($scope.mOPResponsiblePeopleForm.$valid) {
          return fn()("api/mOPResponsiblePeople/", $scope.mOPResponsiblePeople).then(function(response) {
            $scope.mOPResponsiblePeople = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.mOPResponsiblePeople = (mOPResponsiblePeople != null ? mOPResponsiblePeople.data[0] : void 0) || {};
      $scope.organisations = organisations.data;
      return breadcrumb([
        {
          description: 'MOP Responsible People',
          url: "administration/mOPResponsiblePeopleList"
        }
      ]);
    }
  ];

}).call(this);
