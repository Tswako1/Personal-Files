(function() {

  this.InfrastructureRegisterController = [
    '$scope', '$http', '$modal', '$routeParams', 'notification', 'organisations', 'criticalityGrades', 'conditions', 'assetClasses', 'sectorProgrammes', 'documentTypes', 'infrastructureRegister', 'breadcrumb', function($scope, $http, $modal, $routeParams, notification, organisations, criticalityGrades, conditions, assetClasses, sectorProgrammes, documentTypes, infrastructureRegister, breadcrumb) {
      var fn, getinfrastructureRegister, now;
      fn = function() {
        if ($scope.infrastructureRegister.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveInfrastructureRegister = function() {
        if ($scope.infrastructureRegisterForm.$valid) {
          $scope.infrastructureRegister.purchasePrice = parseInt($scope.priceOption) === 0 ? $scope.price : 0;
          $scope.infrastructureRegister.deemedCost = parseInt($scope.priceOption) === 1 ? $scope.price : 0;
          return fn()("api/infrastructureRegister/", $scope.infrastructureRegister).then(function(response) {
            $scope.infrastructureRegister = response.data[0];
            return notification("Successfully saved");
          });
        }
      };
      $scope.autoir = (infrastructureRegister != null ? infrastructureRegister.data[0] : void 0) ? "IR-" + (infrastructureRegister != null ? infrastructureRegister.data[0].assetClass.code : void 0) + "-" + (infrastructureRegister != null ? infrastructureRegister.data[0].autoNumber : void 0) : void 0;
      $scope.LookupSpatialData = function() {
        return $http.get("api/spatial", {
          params: {
            longitude: $scope.infrastructureRegister.locationX,
            latitude: $scope.infrastructureRegister.locationY
          }
        }).then(function($response) {
          return $scope.position = $response.data;
        });
      };
      $scope.getDocumentCount = function(documentType) {
        var doc;
        doc = $scope.infrastructureRegister.projectDocuments.filter(function(item) {
          return item.documentType === documentType;
        });
        if (doc.length) {
          return doc[0].count;
        } else {
          return 0;
        }
      };
      getinfrastructureRegister = function() {
        $scope.priceOption = $scope.infrastructureRegister.purchasePrice !== 0 ? 0 : 1;
        return $scope.price = $scope.priceOption === 0 ? $scope.infrastructureRegister.purchasePrice : $scope.infrastructureRegister.deemedCost;
      };
      $scope.organisations = organisations.data;
      $scope.criticalityGrades = criticalityGrades.data;
      $scope.conditions = conditions.data;
      $scope.assetClasses = assetClasses.data;
      $scope.sectorProgrammes = sectorProgrammes.data;
      $scope.documentTypes = documentTypes.data;
      breadcrumb([
        {
          description: infrastructureRegister != null ? infrastructureRegister.data[0].description : void 0
        }
      ]);
      $scope.infrastructureRegister = (infrastructureRegister != null ? infrastructureRegister.data[0] : void 0) || {};
      if ($scope.organisations.length === 1 && !$scope.infrastructureRegister.organisationId) {
        $scope.infrastructureRegister.organisationId = $scope.organisations[0].id;
      }
      $scope.iswardselected = function(ward) {
        if ($scope.infrastructureRegister.wards.filter(function(x) {
          return x.id === ward.id;
        }).length > 0) {
          return "selected";
        }
      };
      $scope.$watch("selected", function(selected) {
        return $scope.infrastructureRegister.conditionId = selected != null ? selected.id : void 0;
      });
      $scope.$watch("infrastructureRegister.organisationId", function(id) {
        if ($scope.infrastructureRegister.organisationId) {
          $scope.wards = $http.get("lookup/Wards", {
            params: {
              id: id
            }
          });
        }
        if ($scope.infrastructureRegister.sectorProgrammeId) {
          return $scope.parentInfrastructureRegisters = $http.get("lookup/InfrastructureRegistersByOrganisationAndSector", {
            params: {
              organisationId: $scope.infrastructureRegister.organisationId,
              sectorProgrammeId: $scope.infrastructureRegister.sectorProgrammeId
            }
          });
        }
      });
      $scope.$watch("infrastructureRegister.sectorProgrammeId", function(id) {
        if ($scope.infrastructureRegister.organisationId) {
          return $scope.parentInfrastructureRegisters = $http.get("lookup/InfrastructureRegistersByOrganisationAndSector", {
            params: {
              organisationId: $scope.infrastructureRegister.organisationId,
              sectorProgrammeId: $scope.infrastructureRegister.sectorProgrammeId
            }
          });
        }
      });
      now = new Date();
      $scope.$watch('infrastructureRegister.yearConstructedPurchaseDate', function(x) {
        var date;
        date = Date.parse(x);
        return $scope.infrastructureRegisterForm['yearConstructedPurchaseDate'].$setValidity("min", !x || date <= now);
      });
      $scope.selectLocation = function() {
        var dialog;
        dialog = {};
        dialog.modal = $modal.open({
          templateUrl: "content/views/map.html",
          controller: mapController,
          resolve: {
            organisation: [
              '$http', function($http) {
                return $http.get("faultReport/municipality/" + $scope.infrastructureRegister.organisationId);
              }
            ],
            location: function() {
              return {
                lat: $scope.infrastructureRegister.locationY,
                long: $scope.infrastructureRegister.locationX
              };
            },
            dialog: function() {
              return dialog;
            }
          }
        });
        return dialog.modal.result.then(function(location) {
          if (location) {
            $scope.infrastructureRegister.locationX = location.long;
            return $scope.infrastructureRegister.locationY = location.lat;
          }
        });
      };
      if ($scope.infrastructureRegister) {
        $scope.selected = conditions.data.filter((function(x) {
          return x.id === $scope.infrastructureRegister.conditionId;
        }));
        $scope.selected = $scope.selected[0];
      }
      return getinfrastructureRegister();
    }
  ];

}).call(this);
