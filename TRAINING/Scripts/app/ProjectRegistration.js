(function() {

  this.ProjectRegistrationContoller = [
    '$scope', '$http', '$routeParams', '$modal', 'notification', 'organisations', 'projectStatus', 'infrastructureLifeCycles', 'implementingAgents', 'misaSupportAgents', 'migComponents', 'sectorProgrammes', 'developmentalLocations', 'crossCuttingProgrammes', 'fundingSources', 'project', 'breadcrumb', function($scope, $http, $routeParams, $modal, notification, organisations, projectStatus, infrastructureLifeCycles, implementingAgents, misaSupportAgents, migComponents, sectorProgrammes, developmentalLocations, crossCuttingProgrammes, fundingSources, project, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.project.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveProjectRegistration = function() {
        if ($scope.projectRegistrationForm.$valid) {
          return fn()("api/project/", $scope.project).then(function(response) {
            $scope.project.id = response.data.id;
            return notification("Successfully saved");
          });
        }
      };
      $scope.organisations = organisations.data;
      $scope.projectStatus = projectStatus.data;
      $scope.infrastructureLifeCycles = infrastructureLifeCycles.data;
      $scope.implementingAgents = implementingAgents.data;
      $scope.misaSupportAgents = misaSupportAgents.data;
      $scope.migComponents = migComponents.data;
      $scope.sectorProgrammes = sectorProgrammes.data;
      $scope.developmentalLocations = developmentalLocations.data;
      $scope.crossCuttingProgrammes = crossCuttingProgrammes.data;
      $scope.fundingSources = fundingSources.data;
      $scope.autoproject = (project != null ? project.data[0] : void 0) ? "PR-" + (project != null ? project.data[0].sectorCode : void 0) + "-" + (project != null ? project.data[0].autoNumber : void 0) : void 0;
      $scope.$watch("project.organisationId", function(id) {
        if ($scope.project.organisationId) {
          if (!$scope.project.parentProjectNumber) {
            $scope.project.parentProjectNumber = "Not Applicable";
          }
          if (!$scope.project.projectStatusId) {
            $scope.project.projectStatusId = 1;
          }
          $scope.wards = $http.get("lookup/Wards", {
            params: {
              id: id
            }
          });
          if ($scope.project.sectorProgrammeId) {
            $scope.infrastructureRegisters = $http.get("lookup/InfrastructureRegistersByOrganisationAndSector", {
              params: {
                organisationId: $scope.project.organisationId,
                sectorProgrammeId: $scope.project.sectorProgrammeId
              }
            });
            return $scope.test = $scope.infrastructureRegisters.data;
          }
        }
      });
      $scope.$watch("project.sectorProgrammeId", function(id) {
        if ($scope.project.organisationId) {
          $scope.infrastructureRegisters = $http.get("lookup/InfrastructureRegistersByOrganisationAndSector", {
            params: {
              organisationId: $scope.project.organisationId,
              sectorProgrammeId: $scope.project.sectorProgrammeId
            }
          });
          return $scope.test = $scope.infrastructureRegisters.data;
        }
      });
      $scope.project = (project != null ? project.data[0] : void 0) || {};
      $scope.selectLocation = function() {
        var dialog;
        dialog = {};
        dialog.modal = $modal.open({
          templateUrl: "content/views/map.html",
          controller: mapController,
          resolve: {
            organisation: [
              '$http', function($http) {
                return $http.get("faultReport/municipality/" + $scope.project.organisationId);
              }
            ],
            location: function() {
              return {
                lat: $scope.project.lattitude,
                long: $scope.project.longitude
              };
            },
            dialog: function() {
              return dialog;
            }
          }
        });
        return dialog.modal.result.then(function(location) {
          if (location) {
            $scope.project.lattitude = location.lat;
            return $scope.project.longitude = location.long;
          }
        });
      };
      return breadcrumb([
        {
          description: (project != null ? project.data[0].name : void 0) || 'New Project'
        }
      ]);
    }
  ];

}).call(this);
