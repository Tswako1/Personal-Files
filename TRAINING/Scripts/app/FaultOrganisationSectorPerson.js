(function() {

  this.FaultOrganisationSectorPersonController = [
    '$scope', '$http', 'notification', 'faultOrganisationSectorPerson', 'provinces', 'sectors', 'breadcrumb', function($scope, $http, notification, faultOrganisationSectorPerson, provinces, sectors, breadcrumb) {
      var fn;
      $scope.faultOrganisationSectorPerson = faultOrganisationSectorPerson != null ? faultOrganisationSectorPerson.data[0] : void 0;
      $scope.provinces = provinces.data;
      $scope.sectors = sectors.data;
      $scope.isUpdate = faultOrganisationSectorPerson !== null;
      fn = function() {
        if ($scope.faultOrganisationSectorPerson.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.save = function() {
        if ($scope.faultOrganisationSectorPersonForm.$valid) {
          return fn()("api/faultOrganisationSectorPerson/", $scope.faultOrganisationSectorPerson).then(function(response) {
            $scope.faultOrganisationSectorPerson.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      $scope.$watch("faultOrganisationSectorPerson.provinceCode", function(id) {
        if (id && $scope.faultOrganisationSectorPerson.provinceCode) {
          return $http.get("lookup/districtsByProvince", {
            params: {
              provinceId: $scope.faultOrganisationSectorPerson.provinceCode
            }
          }).then(function($response) {
            return $scope.districts = $response.data;
          });
        }
      });
      $scope.$watch("faultOrganisationSectorPerson.districtCode", function(id) {
        if (id && $scope.faultOrganisationSectorPerson.districtCode) {
          return $http.get("lookup/organisationsWithProviceAndDistrictByDistrict", {
            params: {
              districtId: $scope.faultOrganisationSectorPerson.districtCode
            }
          }).then(function($response) {
            return $scope.organisations = $response.data;
          });
        }
      });
      $scope.$watch("faultOrganisationSectorPerson.sectorProgrammeId", function(id) {
        var _ref, _ref1;
        if (id && ((_ref = $scope.faultOrganisationSectorPerson) != null ? _ref.sectorProgrammeId : void 0) && ((_ref1 = $scope.faultOrganisationSectorPerson) != null ? _ref1.organisationId : void 0)) {
          return $http.get("lookup/peopleByOrganisationsAndSector", {
            params: {
              organisationId: $scope.faultOrganisationSectorPerson.organisationId,
              sectorProgrammeId: $scope.faultOrganisationSectorPerson.sectorProgrammeId
            }
          }).then(function($response) {
            return $scope.people = $response.data;
          });
        }
      });
      $scope.$watch("faultOrganisationSectorPerson.organisationId", function(id) {
        var _ref, _ref1;
        if (id && ((_ref = $scope.faultOrganisationSectorPerson) != null ? _ref.sectorProgrammeId : void 0) && ((_ref1 = $scope.faultOrganisationSectorPerson) != null ? _ref1.organisationId : void 0)) {
          return $http.get("lookup/peopleByOrganisationsAndSector", {
            params: {
              organisationId: $scope.faultOrganisationSectorPerson.organisationId,
              sectorProgrammeId: $scope.faultOrganisationSectorPerson.sectorProgrammeId
            }
          }).then(function($response) {
            return $scope.people = $response.data;
          });
        }
      });
      return breadcrumb([
        {
          description: 'Fault Responsible People',
          url: '/administration/faultOrganisationSectorPersonList'
        }, {
          description: 'Create'
        }
      ]);
    }
  ];

}).call(this);
