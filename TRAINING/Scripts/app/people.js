(function() {

  this.PeopleController = [
    '$scope', '$http', '$routeParams', 'notification', 'people', 'isUser', 'isAtLoadUser', 'provinces', 'districts', 'organisations', 'organisationHierarchy', 'roles', 'sectors', 'jobDescriptions', 'breadcrumb', function($scope, $http, $routeParams, notification, people, isUser, isAtLoadUser, provinces, districts, organisations, organisationHierarchy, roles, sectors, jobDescriptions, breadcrumb) {
      var fn, _ref, _ref1;
      fn = function() {
        if ($scope.people.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.savePeople = function() {
        if ($scope.peopleForm.$valid) {
          return fn()("api/people/", $scope.people).then(function(response) {
            $scope.people = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.people = (people != null ? people.data[0] : void 0) || {
        userOrganisations: []
      };
      $scope.provinces = provinces.data;
      $scope.jobDescriptions = jobDescriptions.data;
      $scope.hierarchy = organisationHierarchy.data;
      $scope.districts = districts.data;
      $scope.roles = roles.data;
      $scope.sectors = sectors.data;
      $scope.organisations = organisations.data;
      $scope.isUser = (people != null ? (_ref = people.data[0]) != null ? _ref.userName : void 0 : void 0) ? true : null;
      $scope.isAtLoadUser = (people != null ? (_ref1 = people.data[0]) != null ? _ref1.userName : void 0 : void 0) ? true : null;
      return breadcrumb([
        {
          description: 'People',
          url: "administration/peopleList"
        }
      ]);
    }
  ];

}).call(this);
