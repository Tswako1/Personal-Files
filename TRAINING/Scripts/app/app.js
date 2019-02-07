(function() {
  var app;

  app = angular.module('mipmis', ['ui.map', 'ui.bootstrap', 'blueimp.fileupload', 'LocalStorageModule']);

  app.config([
    '$routeProvider', '$httpProvider', function($routeProvider, $httpProvider) {
      $routeProvider.when('/', {
        templateUrl: 'content/views/home.html',
        controller: HomeController,
        caseInsensitiveMatch: true,
        resolve: {
          projects: [
            '$http', 'operation', function($http, operation) {
              if (operation('ViewProject')) {
                return $http.get('api/project');
              }
            }
          ],
          tasks: [
            '$http', function($http) {
              return $http.get('api/task');
            }
          ],
          infrastructures: [
            '$http', 'operation', function($http, operation) {
              if (operation('ViewInfrastructure')) {
                return $http.get('api/infrastructureRegister');
              }
            }
          ]
        }
      }).when('/administration', {
        templateUrl: 'content/views/administration.html',
        resolve: {
          breadcrumb: [
            'breadcrumb', function(breadcrumb) {
              return breadcrumb({});
            }
          ]
        }
      }).when('/administration/peopleList', {
        templateUrl: 'content/views/peopleList.html',
        controller: PeopleListController,
        resolve: {
          people: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/people");
            }
          ]
        }
      }).when('/administration/people/:id', {
        templateUrl: 'content/views/people.html',
        controller: PeopleController,
        resolve: {
          people: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/people/" + $route.current.params.id);
              }
            }
          ],
          provinces: [
            '$http', function($http) {
              return $http.get("lookup/provinces");
            }
          ],
          districts: [
            '$http', function($http) {
              return $http.get("lookup/districts");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/organisationsWithProviceAndDistrict");
            }
          ],
          jobDescriptions: [
            '$http', function($http) {
              return $http.get("lookup/jobDescriptions");
            }
          ],
          organisationHierarchy: [
            '$http', function($http) {
              return $http.get("lookup/organisationHierarchy");
            }
          ],
          roles: [
            '$http', function($http) {
              return $http.get("lookup/roles");
            }
          ],
          sectors: [
            '$http', function($http) {
              return $http.get("lookup/SectorProgrammesAll");
            }
          ],
          isUser: function() {
            return false;
          },
          isAtLoadUser: function() {
            return false;
          }
        }
      }).when('/administration/faultTypeList', {
        templateUrl: 'content/views/faultTypeList.html',
        controller: FaultTypeListController,
        resolve: {
          faultTypes: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/faultType");
            }
          ]
        }
      }).when('/administration/faultType/:id', {
        templateUrl: 'content/views/faultType.html',
        controller: FaultTypeController,
        resolve: {
          faultType: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/faultType/" + $route.current.params.id);
              }
            }
          ],
          sectors: [
            '$http', function($http) {
              return $http.get("lookup/sectorProgrammes");
            }
          ],
          priorities: [
            '$http', function($http) {
              return $http.get("lookup/faultPriorities");
            }
          ]
        }
      }).when('/administration/faultOrganisationSectorPersonList', {
        templateUrl: 'content/views/faultOrganisationSectorPersonList.html',
        controller: FaultOrganisationSectorPersonListController,
        resolve: {
          faultOrganisationSectorPersonList: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/faultOrganisationSectorPerson");
            }
          ]
        }
      }).when('/administration/faultOrganisationSectorPerson/:id', {
        templateUrl: 'content/views/faultOrganisationSectorPerson.html',
        controller: FaultOrganisationSectorPersonController,
        resolve: {
          faultOrganisationSectorPerson: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/faultOrganisationSectorPerson/" + $route.current.params.id);
              }
            }
          ],
          provinces: [
            '$http', function($http) {
              return $http.get("lookup/provinces");
            }
          ],
          sectors: [
            '$http', function($http) {
              return $http.get("lookup/sectorProgrammes");
            }
          ]
        }
      }).when('/administration/faultPriorityList', {
        templateUrl: 'content/views/faultPriorityList.html',
        controller: FaultPriorityListController,
        resolve: {
          faultPriorities: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/faultPriority");
            }
          ]
        }
      }).when('/administration/faultPriority/:id', {
        templateUrl: 'content/views/faultPriority.html',
        controller: FaultPriorityController,
        resolve: {
          faultPriority: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/faultPriority/" + $route.current.params.id);
              }
            }
          ],
          faultEscalationTimes: [
            '$http', function($http) {
              return $http.get("lookup/faultEscalationTime");
            }
          ]
        }
      }).when('/faultReport/:id', {
        templateUrl: 'content/views/faultReporting.html',
        controller: FaultReportController,
        resolve: {
          faultReport: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/faultReportInternal/" + $route.current.params.id);
            }
          ]
        }
      }).when('/faultReportList', {
        templateUrl: 'content/views/faultReportList.html',
        controller: FaultReportListController,
        resolve: {
          faultReports: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/faultReportInternal");
            }
          ],
          faultReportStatus: [
            '$http', function($http) {
              return $http.get("lookup/faultStatus");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/organisationsWithProviceAndDistrict");
            }
          ],
          sectorProgrammes: [
            '$http', function($http) {
              return $http.get("lookup/sectorProgrammes");
            }
          ]
        }
      }).when('/administration/assetClassList', {
        templateUrl: 'content/views/assetClassList.html',
        controller: AssetClassListController,
        resolve: {
          assetClasses: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/assetClass");
            }
          ]
        }
      }).when('/administration/assetClass/:id', {
        templateUrl: 'content/views/assetClass.html',
        controller: AssetClassController,
        resolve: {
          assetClass: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/assetClass/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/actionsTakenAgainstFraudList', {
        templateUrl: 'content/views/actionsTakenAgainstFraudList.html',
        controller: ActionsTakenAgainstFraudListController,
        resolve: {
          actionsTakenAgainstFraud: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/actionsTakenAgainstFraud");
            }
          ]
        }
      }).when('/administration/actionsTakenAgainstFraud/:id', {
        templateUrl: 'content/views/actionsTakenAgainstFraud.html',
        controller: ActionsTakenAgainstFraudController,
        resolve: {
          actionsTakenAgainstFraud: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/actionsTakenAgainstFraud/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/causeOfProtestList', {
        templateUrl: 'content/views/causeOfProtestList.html',
        controller: CauseOfProtestListController,
        resolve: {
          causesOfProtest: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/causeOfProtest");
            }
          ]
        }
      }).when('/administration/causeOfProtest/:id', {
        templateUrl: 'content/views/causeOfProtest.html',
        controller: CauseOfProtestController,
        resolve: {
          causeOfProtest: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/causeOfProtest/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/causeOfStoppageList', {
        templateUrl: 'content/views/causeOfStoppageList.html',
        controller: CauseOfStoppageListController,
        resolve: {
          causesOfStoppage: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/causeOfStoppage");
            }
          ]
        }
      }).when('/administration/causeOfStoppage/:id', {
        templateUrl: 'content/views/causeOfStoppage.html',
        controller: CauseOfStoppageController,
        resolve: {
          causeOfStoppage: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/causeOfStoppage/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/typeOfStoppageList', {
        templateUrl: 'content/views/typeOfStoppageList.html',
        controller: TypeOfStoppageListController,
        resolve: {
          typesOfStoppage: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/typeOfStoppage");
            }
          ]
        }
      }).when('/administration/typeOfStoppage/:id', {
        templateUrl: 'content/views/typeOfStoppage.html',
        controller: TypeOfStoppageController,
        resolve: {
          typeOfStoppage: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/typeOfStoppage/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/frequencyOfCollectionList', {
        templateUrl: 'content/views/frequencyOfCollectionList.html',
        controller: FrequencyOfCollectionListController,
        resolve: {
          frequenciesOfCollection: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/frequencyOfCollection");
            }
          ]
        }
      }).when('/administration/frequencyOfCollection/:id', {
        templateUrl: 'content/views/frequencyOfCollection.html',
        controller: FrequencyOfCollectionController,
        resolve: {
          frequencyOfCollection: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/frequencyOfCollection/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/crossCuttingProgrammeList', {
        templateUrl: 'content/views/crossCuttingProgrammeList.html',
        controller: CrossCuttingProgrammeListController,
        resolve: {
          crossCuttingProgrammes: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/crossCuttingProgramme");
            }
          ]
        }
      }).when('/administration/crossCuttingProgramme/:id', {
        templateUrl: 'content/views/crossCuttingProgramme.html',
        controller: CrossCuttingProgrammeController,
        resolve: {
          crossCuttingProgramme: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/crossCuttingProgramme/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/developmentalLocationList', {
        templateUrl: 'content/views/developmentalLocationList.html',
        controller: DevelopmentalLocationListController,
        resolve: {
          developmentalLocations: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/developmentalLocation");
            }
          ]
        }
      }).when('/administration/developmentalLocation/:id', {
        templateUrl: 'content/views/developmentalLocation.html',
        controller: DevelopmentalLocationController,
        resolve: {
          developmentalLocation: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/developmentalLocation/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/fundingSourceGroupList', {
        templateUrl: 'content/views/fundingSourceGroupList.html',
        controller: FundingSourceGroupListController,
        resolve: {
          fundingSourceGroups: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/fundingSourceGroup");
            }
          ]
        }
      }).when('/administration/fundingSourceGroup/:id', {
        templateUrl: 'content/views/fundingSourceGroup.html',
        controller: FundingSourceGroupController,
        resolve: {
          fundingSourceGroup: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/fundingSourceGroup/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/fundingSourceList', {
        templateUrl: 'content/views/fundingSourceList.html',
        controller: FundingSourceListController,
        resolve: {
          fundingSources: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/fundingSource");
            }
          ]
        }
      }).when('/administration/fundingSource/:id', {
        templateUrl: 'content/views/fundingSource.html',
        controller: FundingSourceController,
        resolve: {
          fundingSourceGroups: [
            '$http', function($http) {
              return $http.get("lookup/fundingSourceGroups");
            }
          ],
          fundingSource: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/fundingSource/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/jobDescriptionList', {
        templateUrl: 'content/views/jobDescriptionList.html',
        controller: JobDescriptionListController,
        resolve: {
          jobDescriptions: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/jobDescription");
            }
          ]
        }
      }).when('/administration/jobDescription/:id', {
        templateUrl: 'content/views/jobDescription.html',
        controller: JobDescriptionController,
        resolve: {
          jobDescription: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/jobDescription/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/migComponentList', {
        templateUrl: 'content/views/migComponentList.html',
        controller: MigComponentListController,
        resolve: {
          migComponents: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/migComponent");
            }
          ]
        }
      }).when('/administration/migComponent/:id', {
        templateUrl: 'content/views/migComponent.html',
        controller: MigComponentController,
        resolve: {
          migComponent: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/migComponent/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPProjectTypeList', {
        templateUrl: 'content/views/mOPProjectTypeList.html',
        controller: MOPProjectTypeListController,
        resolve: {
          mOPProjectTypes: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPProjectType");
            }
          ]
        }
      }).when('/administration/mOPProjectType/:id', {
        templateUrl: 'content/views/mOPProjectType.html',
        controller: MOPProjectTypeController,
        resolve: {
          mOPProjectType: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPProjectType/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPProjectStageList', {
        templateUrl: 'content/views/mOPProjectStageList.html',
        controller: MOPProjectStageListController,
        resolve: {
          mOPProjectStages: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPProjectStage");
            }
          ]
        }
      }).when('/administration/mOPProjectStage/:id', {
        templateUrl: 'content/views/mOPProjectStage.html',
        controller: MOPProjectStageController,
        resolve: {
          mOPProjectStage: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPProjectStage/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPKPIList', {
        templateUrl: 'content/views/mOPKPIList.html',
        controller: MOPKPIListController,
        resolve: {
          mOPKPIs: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPKPI");
            }
          ]
        }
      }).when('/administration/mOPKPI/:id', {
        templateUrl: 'content/views/mOPKPI.html',
        controller: MOPKPIController,
        resolve: {
          mOPKPI: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPKPI/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPIIKPIList', {
        templateUrl: 'content/views/mOPIIKPIList.html',
        controller: MOPIIKPIListController,
        resolve: {
          mOPIIKPIs: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPIIKPI");
            }
          ]
        }
      }).when('/administration/mOPIIKPI/:id', {
        templateUrl: 'content/views/mOPIIKPI.html',
        controller: MOPIIKPIController,
        resolve: {
          mISAFinancialYears: [
            '$http', function($http) {
              return $http.get("lookup/misaFinancialYears");
            }
          ],
          mOPIIKPI: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPIIKPI/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPIISectionList', {
        templateUrl: 'content/views/mOPIISectionList.html',
        controller: MOPIISectionListController,
        resolve: {
          mOPIISections: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPIISection");
            }
          ]
        }
      }).when('/administration/mOPIISection/:id', {
        templateUrl: 'content/views/mOPIISection.html',
        controller: MOPIISectionController,
        resolve: {
          mOPIIKPIs: [
            '$http', function($http) {
              return $http.get("lookup/mOPIIKPIs");
            }
          ],
          mOPIISection: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPIISection/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPIIProcessList', {
        templateUrl: 'content/views/mOPIIProcessList.html',
        controller: MOPIIProcessListController,
        resolve: {
          mOPIIProcesss: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPIIProcess");
            }
          ]
        }
      }).when('/administration/mOPIIProcess/:id', {
        templateUrl: 'content/views/mOPIIProcess.html',
        controller: MOPIIProcessController,
        resolve: {
          mOPIISections: [
            '$http', function($http) {
              return $http.get("lookup/mOPIISections");
            }
          ],
          mOPIIProcess: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPIIProcess/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPSectorList', {
        templateUrl: 'content/views/mOPSectorList.html',
        controller: MOPSectorListController,
        resolve: {
          mOPSectors: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPSector");
            }
          ]
        }
      }).when('/administration/mOPSector/:id', {
        templateUrl: 'content/views/mOPSector.html',
        controller: MOPSectorController,
        resolve: {
          mOPSector: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPSector/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/misaSupportAgentList', {
        templateUrl: 'content/views/misaSupportAgentList.html',
        controller: MisaSupportAgentListController,
        resolve: {
          misaSupportAgents: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/misaSupportAgent");
            }
          ]
        }
      }).when('/administration/misaSupportAgent/:id', {
        templateUrl: 'content/views/misaSupportAgent.html',
        controller: MisaSupportAgentController,
        resolve: {
          misaSupportAgent: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/misaSupportAgent/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/mOPResponsiblePeopleList', {
        templateUrl: 'content/views/MOPResponsiblePeopleList.html',
        controller: MOPResponsiblePeopleListController,
        resolve: {
          mOPResponsiblePeoples: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPResponsiblePeople");
            }
          ]
        }
      }).when('/administration/mOPResponsiblePeople/:id', {
        templateUrl: 'content/views/MOPResponsiblePeople.html',
        controller: MOPResponsiblePeopleController,
        resolve: {
          mOPResponsiblePeople: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/mOPResponsiblePeople/" + $route.current.params.id);
              }
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ]
        }
      }).when('/administration/sectorProgrammeList', {
        templateUrl: 'content/views/sectorProgrammeList.html',
        controller: SectorProgrammeListController,
        resolve: {
          sectorProgrammes: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/sectorProgramme");
            }
          ]
        }
      }).when('/administration/sectorProgramme/:id', {
        templateUrl: 'content/views/sectorProgramme.html',
        controller: SectorProgrammeController,
        resolve: {
          sectorProgramme: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/sectorProgramme/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/indicatorItemList', {
        templateUrl: 'content/views/indicatorItemList.html',
        controller: IndicatorItemListController,
        resolve: {
          indicatorItems: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorItem");
            }
          ]
        }
      }).when('/administration/indicatorItem/:id', {
        templateUrl: 'content/views/indicatorItem.html',
        controller: IndicatorItemController,
        resolve: {
          indicatorItem: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/indicatorItem/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/indicatorStandardList', {
        templateUrl: 'content/views/indicatorStandardList.html',
        controller: IndicatorStandardListController,
        resolve: {
          indicatorStandards: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorStandard");
            }
          ]
        }
      }).when('/administration/indicatorStandard/:id', {
        templateUrl: 'content/views/indicatorStandard.html',
        controller: IndicatorStandardController,
        resolve: {
          indicatorStandard: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/indicatorStandard/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/indicatorStrategyList', {
        templateUrl: 'content/views/indicatorStrategyList.html',
        controller: IndicatorStrategyListController,
        resolve: {
          indicatorStrategies: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorStrategy");
            }
          ]
        }
      }).when('/administration/indicatorStrategy/:id', {
        templateUrl: 'content/views/indicatorStrategy.html',
        controller: IndicatorStrategyController,
        resolve: {
          indicatorStrategy: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/indicatorStrategy/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/indicatorTypeList', {
        templateUrl: 'content/views/indicatorTypeList.html',
        controller: IndicatorTypeListController,
        resolve: {
          indicatorTypes: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorType");
            }
          ]
        }
      }).when('/administration/indicatorType/:id', {
        templateUrl: 'content/views/indicatorType.html',
        controller: IndicatorTypeController,
        resolve: {
          indicatorType: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/indicatorType/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/indicatorUnitOfMeasureList', {
        templateUrl: 'content/views/indicatorUnitOfMeasureList.html',
        controller: IndicatorUnitOfMeasureListController,
        resolve: {
          indicatorUnitOfMeasures: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorUnitOfMeasure");
            }
          ]
        }
      }).when('/administration/indicatorUnitOfMeasure/:id', {
        templateUrl: 'content/views/indicatorUnitOfMeasure.html',
        controller: IndicatorUnitOfMeasureController,
        resolve: {
          indicatorUnitOfMeasure: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/indicatorUnitOfMeasure/" + $route.current.params.id);
              }
            }
          ]
        }
      }).when('/administration/indicators', {
        templateUrl: 'content/views/indicatorList.html',
        controller: IndicatorListController,
        resolve: {
          indicators: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicator");
            }
          ]
        }
      }).when('/administration/indicator/:id', {
        templateUrl: 'content/views/indicator.html',
        controller: IndicatorController,
        resolve: {
          indicator: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/indicator/" + $route.current.params.id);
              }
            }
          ],
          types: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorType");
            }
          ],
          unitOfMeasures: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorUnitOfMeasure");
            }
          ],
          standards: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorStandard");
            }
          ],
          items: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorItem");
            }
          ],
          strategies: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorStrategy");
            }
          ]
        }
      }).when('/administration/indicatorTargets/:id', {
        templateUrl: 'content/views/indicatorTargets.html',
        controller: IndicatorTargetsController,
        resolve: {
          targets: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicatorTargets/" + $route.current.params.id);
            }
          ]
        }
      }).when('/project/:id', {
        templateUrl: 'content/views/project.html',
        controller: ProjectController,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/project/" + $route.current.params.id);
            }
          ]
        }
      }).when('/project', {
        templateUrl: 'content/views/projectList.html',
        caseInsensitiveMatch: true,
        controller: ProjectListController,
        resolve: {
          projects: [
            '$http', function($http) {
              return $http.get("api/project?filter=");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/organisations");
            }
          ],
          projectStatus: [
            '$http', function($http) {
              return $http.get("lookup/projectStatus");
            }
          ],
          sectorProgrammes: [
            '$http', function($http) {
              return $http.get("lookup/sectorProgrammes");
            }
          ],
          fundingSources: [
            '$http', function($http) {
              return $http.get("lookup/fundingSources");
            }
          ],
          deleteProject: function() {
            return false;
          }
        }
      }).when('/administration/deleteProject', {
        templateUrl: 'content/views/projectList.html',
        caseInsensitiveMatch: true,
        controller: ProjectListController,
        resolve: {
          projects: [
            '$http', function($http) {
              return $http.get("api/project?filter=");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/organisations");
            }
          ],
          projectStatus: [
            '$http', function($http) {
              return $http.get("lookup/projectStatus");
            }
          ],
          sectorProgrammes: [
            '$http', function($http) {
              return $http.get("lookup/sectorProgrammes");
            }
          ],
          fundingSources: [
            '$http', function($http) {
              return $http.get("lookup/fundingSources");
            }
          ],
          deleteProject: function() {
            return true;
          }
        }
      }).when('/insights', {
        templateUrl: 'content/views/insights.html',
        controller: InsightController,
        resolve: {
          insights: [
            '$http', function($http) {
              return $http.get("lookup/insights");
            }
          ]
        }
      }).when('/projectRegistration/:id', {
        templateUrl: 'content/views/projectregistration.html',
        controller: ProjectRegistrationContoller,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/project/" + $route.current.params.id);
              }
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/organisations");
            }
          ],
          projectStatus: [
            '$http', function($http) {
              return $http.get("lookup/projectStatus");
            }
          ],
          infrastructureLifeCycles: [
            '$http', function($http) {
              return $http.get("lookup/infrastructureLifeCycles");
            }
          ],
          implementingAgents: [
            '$http', function($http) {
              return $http.get("lookup/implementingAgents");
            }
          ],
          migComponents: [
            '$http', function($http) {
              return $http.get("lookup/migComponents");
            }
          ],
          misaSupportAgents: [
            '$http', function($http) {
              return $http.get("lookup/misaSupportAgents");
            }
          ],
          sectorProgrammes: [
            '$http', function($http) {
              return $http.get("lookup/sectorProgrammes");
            }
          ],
          crossCuttingProgrammes: [
            '$http', function($http) {
              return $http.get("lookup/crossCuttingProgrammes");
            }
          ],
          developmentalLocations: [
            '$http', function($http) {
              return $http.get("lookup/developmentalLocations");
            }
          ],
          fundingSources: [
            '$http', function($http) {
              return $http.get("lookup/fundingSources");
            }
          ]
        }
      }).when('/projectRegistration/:id/financials', {
        templateUrl: 'content/views/projectFinancials.html',
        controller: ProjectFinancialsController,
        resolve: {
          projectFinancials: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectFinancials/" + $route.current.params.id);
            }
          ]
        }
      }).when('/projectRegistration/:id/projectStakeHolderList', {
        templateUrl: 'content/views/projectStakeHolderList.html',
        controller: ProjectStakeHolderListController,
        resolve: {
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ],
          projectStakeHolders: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectStakeHolder/", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ]
        }
      }).when('/projectRegistration/:projectId/projectStakeHolder/:id', {
        templateUrl: 'content/views/projectStakeHolder.html',
        controller: ProjectStakeHolderController,
        resolve: {
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.projectId);
            }
          ],
          projectStakeHolder: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/projectStakeHolder/" + $route.current.params.id);
              }
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ]
        }
      }).when('/projectRegistration/:id/siteVisitList', {
        templateUrl: 'content/views/siteVisitList.html',
        caseInsensitiveMatch: true,
        controller: SiteVisitListController,
        resolve: {
          siteVisits: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/siteVisit/", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/projectRegistration/:projectId/siteVisitSchedule/:id', {
        templateUrl: 'content/views/siteVisitSchedule.html',
        controller: SiteVisitController,
        resolve: {
          siteVisit: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return $http.get("api/siteVisit?project=" + $route.current.params.projectId + "&id=");
              } else {
                return $http.get("api/siteVisit/" + $route.current.params.id + "?project=" + $route.current.params.projectId);
              }
            }
          ],
          people: [
            '$http', '$route', function($http, $route) {
              return $http.get("lookup/PeopleByProjectId", {
                params: {
                  projectId: $route.current.params.projectId
                }
              });
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.projectId);
            }
          ]
        }
      }).when('/projectRegistration/:projectId/siteVisitUpdate/:id', {
        templateUrl: 'content/views/siteVisitUpdate.html',
        controller: SiteVisitController,
        resolve: {
          siteVisit: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/siteVisit/" + $route.current.params.id + "?project=" + $route.current.params.projectId);
            }
          ],
          people: [
            '$http', '$route', function($http, $route) {
              return $http.get("lookup/PeopleBySiteVisitId", {
                params: {
                  siteVisitId: $route.current.params.id
                }
              });
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.projectId);
            }
          ]
        }
      }).when('/siteVisitUpdate/:id', {
        templateUrl: 'content/views/siteVisitUpdate.html',
        controller: SiteVisitController,
        resolve: {
          siteVisit: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/siteVisit/" + $route.current.params.id);
            }
          ],
          people: [
            '$http', '$route', function($http, $route) {
              return $http.get("lookup/PeopleBySiteVisitId", {
                params: {
                  siteVisitId: $route.current.params.id
                }
              });
            }
          ]
        }
      }).when('/projectRegistration/:id/riskList', {
        templateUrl: 'content/views/projectRiskList.html',
        caseInsensitiveMatch: true,
        controller: ProjectRiskListController,
        resolve: {
          projectRisks: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectRisk/", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/projectRegistration/:projectId/projectRisk/:id', {
        templateUrl: 'content/views/projectRisk.html',
        controller: ProjectRiskController,
        resolve: {
          projectRiskTypes: [
            '$http', function($http) {
              return $http.get("lookup/ProjectRiskTypes");
            }
          ],
          projectRiskCategories: [
            '$http', function($http) {
              return $http.get("lookup/ProjectRiskCategories");
            }
          ],
          riskConsequences: [
            '$http', function($http) {
              return $http.get("lookup/RiskConsequences");
            }
          ],
          riskProbabilities: [
            '$http', function($http) {
              return $http.get("lookup/RiskProbabilities");
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.projectId);
            }
          ],
          projectRiskDescription: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("breadCrumb/GetProjectRiskDescription/" + $route.current.params.id);
              }
            }
          ],
          projectRisk: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/ProjectRisk/" + $route.current.params.id);
              }
            }
          ],
          people: [
            '$http', function($http) {
              return $http.get("lookup/people");
            }
          ]
        }
      }).when('/projectRegistration/:id/issueList', {
        templateUrl: 'content/views/projectIssueList.html',
        controller: ProjectIssueListController,
        resolve: {
          projectIssues: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectIssue/", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/projectRegistration/:id/qualityControl', {
        templateUrl: 'content/views/projectQualityControl.html',
        caseInsensitiveMatch: true,
        controller: ProjectQualityControlController,
        resolve: {
          checks: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/ProjectQualityChecks", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/projectRegistration/:projectId/projectIssue/:id', {
        templateUrl: 'content/views/projectIssue.html',
        controller: ProjectIssueController,
        resolve: {
          issueSeverity: [
            '$http', function($http) {
              return $http.get("lookup/RiskConsequences");
            }
          ],
          issueProbability: [
            '$http', function($http) {
              return $http.get("lookup/RiskProbabilities");
            }
          ],
          projectDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.projectId);
            }
          ],
          projectIssueDescription: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("breadCrumb/GetProjectIssueDescription/" + $route.current.params.id);
              }
            }
          ],
          projectIssue: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/ProjectIssue/" + $route.current.params.id);
              }
            }
          ],
          people: [
            '$http', function($http) {
              return $http.get("lookup/people");
            }
          ]
        }
      }).when('/projectRegistration/:id/projectCheckList', {
        templateUrl: 'content/views/projectCheckList.html',
        controller: ProjectCheckListController,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectCheckList/" + $route.current.params.id);
            }
          ],
          documentTypes: [
            '$http', function($http) {
              return $http.get("lookup/documentTypes");
            }
          ]
        }
      }).when('/projectRegistration/:id/projectActivities', {
        templateUrl: 'content/views/projectActivities.html',
        controller: ProjectActivitiesController,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectActivities/" + $route.current.params.id);
            }
          ]
        }
      }).when('/projectRegistration/:id/indicators', {
        templateUrl: 'content/views/projectIndicatorList.html',
        controller: ProjectIndicatorsController,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ],
          indicators: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectIndicators?projectId=" + $route.current.params.id);
            }
          ]
        }
      }).when('/projectRegistration/:id/indicator/:indicatorId', {
        templateUrl: 'content/views/projectIndicatorValues.html',
        controller: ProjectIndicatorValuesController,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ],
          indicator: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectIndicators/" + $route.current.params.indicatorId);
            }
          ]
        }
      }).when('/projectRegistration/:id/indicators/create', {
        templateUrl: 'content/views/projectIndicatorCreate.html',
        controller: ProjectIndicatorsCreateController,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetProjectDescription/" + $route.current.params.id);
            }
          ],
          indicators: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/indicator");
            }
          ]
        }
      }).when('/projectOverview/:id', {
        templateUrl: 'content/views/projectOverview.html',
        caseInsensitiveMatch: true,
        controller: ProjectOverviewController,
        resolve: {
          project: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/project/" + $route.current.params.id);
            }
          ],
          financials: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectFinancials/" + $route.current.params.id);
            }
          ],
          activities: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectActivities/" + $route.current.params.id);
            }
          ],
          risks: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectRisk/", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ],
          issues: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectIssue/", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ],
          siteVisits: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/siteVisit/", {
                params: {
                  projectId: $route.current.params.id
                }
              });
            }
          ],
          indicators: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/projectIndicators?projectId=" + $route.current.params.id);
            }
          ]
        }
      }).when('/project/:id/issue/create', {
        templateUrl: 'content/views/issue.html',
        caseInsensitiveMatch: true,
        controller: IssueController
      }).when('/project/:id/notes', {
        templateUrl: 'content/views/notes.html',
        caseInsensitiveMatch: true,
        controller: NotesController
      }).when('/sitevisit/:id', {
        templateUrl: 'content/views/sitevisit.html',
        caseInsensitiveMatch: true,
        controller: SiteVisitController,
        resolve: {
          siteVisit: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/siteVisit/" + $route.current.params.id);
            }
          ]
        }
      }).when('/infrastructureRegister/:id', {
        templateUrl: 'content/views/infrastructureRegister.html',
        caseInsensitiveMatch: true,
        controller: InfrastructureRegisterController,
        resolve: {
          infrastructureRegister: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/infrastructureRegister/" + $route.current.params.id);
              }
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          criticalityGrades: [
            '$http', function($http) {
              return $http.get("lookup/CriticalityGrades");
            }
          ],
          conditions: [
            '$http', function($http) {
              return $http.get("lookup/Conditions");
            }
          ],
          assetClasses: [
            '$http', function($http) {
              return $http.get("lookup/assetClasses");
            }
          ],
          sectorProgrammes: [
            '$http', function($http) {
              return $http.get("lookup/sectorProgrammes");
            }
          ],
          documentTypes: [
            '$http', function($http) {
              return $http.get("lookup/documentTypes");
            }
          ]
        }
      }).when('/infrastructureRegisterOverview/:id', {
        templateUrl: 'content/views/infrastructureRegisterOverview.html',
        caseInsensitiveMatch: true,
        controller: InfrastructureRegisterOverviewController,
        resolve: {
          infrastructureRegister: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/infrastructureRegister/" + $route.current.params.id);
            }
          ],
          infrastructureRisks: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/infrastructureRisk/", {
                params: {
                  infrastructureRegisterId: $route.current.params.id
                }
              });
            }
          ]
        }
      }).when('/infrastructureRegister', {
        templateUrl: 'content/views/infrastructureRegisterList.html',
        caseInsensitiveMatch: true,
        controller: InfrastructureRegisterListController,
        resolve: {
          infrastructureRegisters: [
            '$http', function($http) {
              return $http.get("api/infrastructureRegister?filter=");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/organisations");
            }
          ],
          assetClasses: [
            '$http', function($http) {
              return $http.get("lookup/assetClasses");
            }
          ],
          deleteInfrastructure: function() {
            return false;
          }
        }
      }).when('/administration/deleteInfrastructureRegister', {
        templateUrl: 'content/views/infrastructureRegisterList.html',
        caseInsensitiveMatch: true,
        controller: InfrastructureRegisterListController,
        resolve: {
          infrastructureRegisters: [
            '$http', function($http) {
              return $http.get("api/infrastructureRegister?filter=");
            }
          ],
          assetClasses: [
            '$http', function($http) {
              return $http.get("lookup/assetClasses");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/organisations");
            }
          ],
          deleteInfrastructure: function() {
            return true;
          }
        }
      }).when('/infrastructureRegister/:id/infrastructureRisk', {
        templateUrl: 'content/views/infrastructureRiskList.html',
        caseInsensitiveMatch: true,
        controller: InfrastructureRiskListController,
        resolve: {
          infrastructureRisks: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/infrastructureRisk/", {
                params: {
                  infrastructureRegisterId: $route.current.params.id
                }
              });
            }
          ],
          insights: [
            '$http', function($http) {
              return $http.get("lookup/Insights");
            }
          ],
          infrastructureRiskDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetInfrastructureRegisterDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/infrastructureRegister/:id/infrastructureRisk/:riskId', {
        templateUrl: 'content/views/infrastructureRisk.html',
        caseInsensitiveMatch: true,
        controller: InfrastructureRiskController,
        resolve: {
          infrastructureRisk: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.riskId === "Create") {
                return null;
              } else {
                return $http.get("api/infrastructureRisk/" + $route.current.params.riskId);
              }
            }
          ],
          riskTypes: [
            '$http', function($http) {
              return $http.get("lookup/RiskTypes");
            }
          ],
          riskConsequences: [
            '$http', function($http) {
              return $http.get("lookup/RiskConsequences");
            }
          ],
          riskProbabilities: [
            '$http', function($http) {
              return $http.get("lookup/RiskProbabilities");
            }
          ],
          infrastructureRiskDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetInfrastructureRegisterDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/backToBasics', {
        templateUrl: 'content/views/backToBasicsList.html',
        controller: BackToBasicsListController,
        resolve: {
          backToBasics: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/backToBasics");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/FinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/FinancialPeriods");
            }
          ]
        }
      }).when('/backToBasics/Create', {
        templateUrl: "content/views/backToBasics1.html",
        caseInsensitiveMatch: true,
        controller: BackToBasicsController,
        resolve: {
          backToBasics: function() {
            return null;
          },
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          actionsAgainstFraud: [
            '$http', function($http) {
              return $http.get("lookup/ActionsAgainstFraud");
            }
          ],
          causesOfProtest: [
            '$http', function($http) {
              return $http.get("lookup/CauseOfProtest");
            }
          ],
          causesOfStoppage: [
            '$http', function($http) {
              return $http.get("lookup/CauseOfStoppage");
            }
          ],
          typesOfStoppage: [
            '$http', function($http) {
              return $http.get("lookup/TypeOfStoppage");
            }
          ],
          frequenciesOfCollection: [
            '$http', function($http) {
              return $http.get("lookup/FrequencyOfCollection");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/FinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/FinancialPeriods");
            }
          ]
        }
      }).when('/backToBasics/:id/:page', {
        templateUrl: function(params) {
          return "content/views/backToBasics" + params.page + ".html";
        },
        caseInsensitiveMatch: true,
        controller: BackToBasicsController,
        resolve: {
          backToBasics: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/backToBasics/" + $route.current.params.id);
              }
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          actionsAgainstFraud: [
            '$http', function($http) {
              return $http.get("lookup/ActionsAgainstFraud");
            }
          ],
          causesOfProtest: [
            '$http', function($http) {
              return $http.get("lookup/CauseOfProtest");
            }
          ],
          causesOfStoppage: [
            '$http', function($http) {
              return $http.get("lookup/CauseOfStoppage");
            }
          ],
          typesOfStoppage: [
            '$http', function($http) {
              return $http.get("lookup/TypeOfStoppage");
            }
          ],
          frequenciesOfCollection: [
            '$http', function($http) {
              return $http.get("lookup/FrequencyOfCollection");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/FinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/FinancialPeriods");
            }
          ]
        }
      }).when('/operationalPlanOverview/:id', {
        templateUrl: 'content/views/operationalPlanOverview.html',
        caseInsensitiveMatch: true,
        controller: OperationalOverviewController,
        resolve: {
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalPlan/" + $route.current.params.id);
            }
          ],
          operationalActuals: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalActual/", {
                params: {
                  theTargetId: $route.current.params.id
                }
              });
            }
          ],
          documentTypes: [
            '$http', function($http) {
              return $http.get("lookup/documentTypes");
            }
          ],
          operationalProjects: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalProject/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ1: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ2: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId1: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ3: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId2: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ4: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId3: $route.current.params.id
                }
              });
            }
          ]
        }
      }).when('/operationalPlanDocuments/:id', {
        templateUrl: 'content/views/mopDocumentValidation.html',
        caseInsensitiveMatch: true,
        controller: OperationalOverviewController,
        resolve: {
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalPlan/" + $route.current.params.id);
            }
          ],
          operationalActuals: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalActual/", {
                params: {
                  theTargetId: $route.current.params.id
                }
              });
            }
          ],
          documentTypes: [
            '$http', function($http) {
              return $http.get("lookup/documentTypes");
            }
          ],
          operationalProjects: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalProject/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ1: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ2: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId1: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ3: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId2: $route.current.params.id
                }
              });
            }
          ],
          operationPlanDocumentsQ4: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/document/", {
                params: {
                  targetId3: $route.current.params.id
                }
              });
            }
          ]
        }
      }).when('/operationalPlan', {
        templateUrl: 'content/views/operationalPlanList.html',
        controller: OperationalPlanListController,
        resolve: {
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalPlan");
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ]
        }
      }).when('/operationalPlan/Create', {
        templateUrl: "content/views/operationalPlan1.html",
        caseInsensitiveMatch: true,
        controller: OperationalPlanController,
        resolve: {
          operationalPlan: function() {
            return null;
          },
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ]
        }
      }).when('/operationalPlan/:id/actuals', {
        templateUrl: 'content/views/operationalActualsList.html',
        caseInsensitiveMatch: true,
        controller: OperationalActualsListController,
        resolve: {
          operationalActuals: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalActual/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetOperationalPlanDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/operationalPlan/:targetId/actuals/Create', {
        templateUrl: "content/views/operationalActual1.html",
        caseInsensitiveMatch: true,
        controller: OperationalActualsController,
        resolve: {
          operationalActual: function() {
            return null;
          },
          operationalActuals: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalActual/", {
                params: {
                  theTargetId: $route.current.params.targetId
                }
              });
            }
          ],
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalPlan/" + $route.current.params.targetId);
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          documentTypes: [
            '$http', function($http) {
              return $http.get("lookup/documentTypes");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetOperationalPlanDescription/" + $route.current.params.targetId);
            }
          ]
        }
      }).when('/operationalPlan/:id/:page', {
        templateUrl: function(params) {
          return "content/views/operationalPlan" + params.page + ".html";
        },
        caseInsensitiveMatch: true,
        controller: OperationalPlanController,
        resolve: {
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              if ($route.current.params.id === "Create") {
                return null;
              } else {
                return $http.get("api/operationalPlan/" + $route.current.params.id);
              }
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ]
        }
      }).when('/operationalPlan/:targetId/actuals/:id/:page', {
        templateUrl: function(params) {
          return "content/views/operationalActual" + params.page + ".html";
        },
        caseInsensitiveMatch: true,
        controller: OperationalActualsController,
        resolve: {
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalPlan/" + $route.current.params.targetId);
            }
          ],
          operationalActual: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalActual/" + $route.current.params.id);
            }
          ],
          operationalActuals: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalActual/", {
                params: {
                  theTargetId: $route.current.params.targetId
                }
              });
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          documentTypes: [
            '$http', function($http) {
              return $http.get("lookup/documentTypes");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetOperationalPlanDescription/" + $route.current.params.targetId);
            }
          ]
        }
      }).when('/operationalPlans/:id/projects', {
        templateUrl: 'content/views/operationalProjectsList.html',
        caseInsensitiveMatch: true,
        controller: OperationalProjectsListController,
        resolve: {
          operationalProjects: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalProject/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetOperationalPlanDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/operationalPlan/:targetId/projects/Create', {
        templateUrl: "content/views/operationalProject.html",
        caseInsensitiveMatch: true,
        controller: OperationalProjectController,
        resolve: {
          operationalProject: function() {
            return null;
          },
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalPlan/" + $route.current.params.targetId);
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          mopSectors: [
            '$http', function($http) {
              return $http.get("lookup/mopSectors");
            }
          ],
          mopProjectTypes: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectTypes");
            }
          ],
          mopProjectStages: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectStages");
            }
          ],
          fundingSources: [
            '$http', function($http) {
              return $http.get("lookup/fundingSources");
            }
          ],
          fundingSourceGroups: [
            '$http', function($http) {
              return $http.get("lookup/fundingSourceGroups");
            }
          ],
          mopkpis: [
            '$http', function($http) {
              return $http.get("lookup/mopkpis");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetOperationalPlanDescription/" + $route.current.params.targetId);
            }
          ]
        }
      }).when('/operationalPlan/:targetId/projects/:id', {
        templateUrl: "content/views/operationalProject.html",
        caseInsensitiveMatch: true,
        controller: OperationalProjectController,
        resolve: {
          operationalProject: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalProject/" + $route.current.params.id);
            }
          ],
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/operationalPlan/" + $route.current.params.targetId);
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          mopSectors: [
            '$http', function($http) {
              return $http.get("lookup/mopSectors");
            }
          ],
          mopProjectTypes: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectTypes");
            }
          ],
          mopProjectStages: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectStages");
            }
          ],
          fundingSources: [
            '$http', function($http) {
              return $http.get("lookup/fundingSources");
            }
          ],
          fundingSourceGroups: [
            '$http', function($http) {
              return $http.get("lookup/fundingSourceGroups");
            }
          ],
          mopkpis: [
            '$http', function($http) {
              return $http.get("lookup/mopkpis");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetOperationalPlanDescription/" + $route.current.params.targetId);
            }
          ]
        }
      }).when('/operations/plans', {
        templateUrl: 'content/views/mopii/operationsPlanList.html',
        caseInsensitiveMatch: true,
        controller: MopiiPlanListController,
        resolve: {
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          plans: [
            '$http', function($http) {
              return $http.get("/api/mopii/plans");
            }
          ]
        }
      }).when('/operations/plans/create', {
        templateUrl: 'content/views/mopii/operationsPlanCreate.html',
        caseInsensitiveMatch: true,
        controller: MopiiPlanCreateController,
        resolve: {
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ]
        }
      }).when('/operations/plan/:id', {
        templateUrl: 'content/views/mopii/operationsPlan.html',
        caseInsensitiveMatch: true,
        controller: MopiiPlanController,
        resolve: {
          plan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mopii/plan/" + $route.current.params.id);
            }
          ]
        }
      }).when('/operations/actuals/:id', {
        templateUrl: 'content/views/mopii/operationsActuals.html',
        caseInsensitiveMatch: true,
        controller: MopiiActualsController,
        resolve: {
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ]
        }
      }).when('/operations/validation/:id', {
        templateUrl: 'content/views/mopii/validation.html',
        caseInsensitiveMatch: true,
        controller: MopiiValidationController,
        resolve: {
          plan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mopii/validation/" + $route.current.params.id);
            }
          ]
        }
      }).when('/operations/nationalvalidation/:id', {
        templateUrl: 'content/views/mopii/nationalvalidation.html',
        caseInsensitiveMatch: true,
        controller: MopiiValidationController,
        resolve: {
          plan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mopii/validation/" + $route.current.params.id);
            }
          ]
        }
      }).when('/operations/overview/:id', {
        templateUrl: 'content/views/mopii/operationsOverview.html',
        caseInsensitiveMatch: true,
        controller: MopiiOverviewController,
        resolve: {
          plan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mopii/actuals/" + $route.current.params.id + "/1");
            }
          ],
          docs: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mopii/validation/" + $route.current.params.id);
            }
          ],
          mOPIIProjects: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPIIProject/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ]
        }
      }).when('/operations/:id/projects', {
        templateUrl: 'content/views/mopiiProjectList.html',
        caseInsensitiveMatch: true,
        controller: MOPIIProjectsListController,
        resolve: {
          mOPIIProjects: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPIIProject/", {
                params: {
                  targetId: $route.current.params.id
                }
              });
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetMOPIIPlanDescription/" + $route.current.params.id);
            }
          ]
        }
      }).when('/operations/:targetId/projects/Create', {
        templateUrl: "content/views/mopiiProject.html",
        caseInsensitiveMatch: true,
        controller: MOPIIProjectController,
        resolve: {
          mOPIIProject: function() {
            return null;
          },
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mopii/plan/" + $route.current.params.targetId);
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          mopSectors: [
            '$http', function($http) {
              return $http.get("lookup/mopSectors");
            }
          ],
          mopProjectTypes: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectTypes");
            }
          ],
          mopProjectStages: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectStages");
            }
          ],
          fundingSources: [
            '$http', function($http) {
              return $http.get("lookup/fundingSources");
            }
          ],
          fundingSourceGroups: [
            '$http', function($http) {
              return $http.get("lookup/fundingSourceGroups");
            }
          ],
          mopkpis: [
            '$http', function($http) {
              return $http.get("lookup/mopkpis");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetMOPIIPlanDescription/" + $route.current.params.targetId);
            }
          ]
        }
      }).when('/operations/:targetId/projects/:id', {
        templateUrl: "content/views/mopiiProject.html",
        caseInsensitiveMatch: true,
        controller: MOPIIProjectController,
        resolve: {
          mOPIIProject: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mOPIIProject/" + $route.current.params.id);
            }
          ],
          operationalPlan: [
            '$http', '$route', function($http, $route) {
              return $http.get("api/mopii/plan/" + $route.current.params.targetId);
            }
          ],
          organisations: [
            '$http', function($http) {
              return $http.get("lookup/Organisations");
            }
          ],
          financialYears: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialYears");
            }
          ],
          financialPeriods: [
            '$http', function($http) {
              return $http.get("lookup/MisaFinancialPeriods");
            }
          ],
          mopSectors: [
            '$http', function($http) {
              return $http.get("lookup/mopSectors");
            }
          ],
          mopProjectTypes: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectTypes");
            }
          ],
          mopProjectStages: [
            '$http', function($http) {
              return $http.get("lookup/mopProjectStages");
            }
          ],
          fundingSources: [
            '$http', function($http) {
              return $http.get("lookup/fundingSources");
            }
          ],
          fundingSourceGroups: [
            '$http', function($http) {
              return $http.get("lookup/fundingSourceGroups");
            }
          ],
          mopkpis: [
            '$http', function($http) {
              return $http.get("lookup/mopkpis");
            }
          ],
          operationPlanDescription: [
            '$http', '$route', function($http, $route) {
              return $http.get("breadCrumb/GetMOPIIPlanDescription/" + $route.current.params.targetId);
            }
          ]
        }
      }).otherwise({
        redirectTo: '/'
      });
      return $httpProvider.interceptors.push([
        '$q', 'notification', '$rootScope', '$window', function($q, notification, $rootScope, $window) {
          return {
            request: function(config) {
              $rootScope.busy = true;
              return config || $q.when(config);
            },
            response: function(response) {
              $rootScope.busy = false;
              return response || $q.when(response);
            },
            responseError: function(rejection) {
              if (rejection.status === 500) {
                notification("There was a problem processing your request. If this problem persist, please contact your system administrator", 1);
              }
              if (rejection.status === 400) {
                notification(rejection.data.message, 1);
              }
              if (rejection.status === 401) {
                notification("You do not have the required permissions to perform this task, please contact your system administrator", 1);
              }
              $rootScope.busy = false;
              return $q.reject(rejection);
            }
          };
        }
      ]);
    }
  ]);

  if (typeof String.prototype.startsWith !== 'function') {
    String.prototype.startsWith = function(str) {
      return this.slice(0, str.length) === str;
    };
  }

  app.run([
    '$rootScope', '$location', 'notification', 'operation', function($rootScope, $location, notification, operation) {
      var hub;
      $rootScope.$on("$routeChangeSuccess", function(event, route) {
        if ($location.$$path.startsWith("/project")) {
          return $rootScope.page = "Projects";
        } else if ($location.$$path.startsWith("/infrastructure")) {
          return $rootScope.page = "Register";
        } else if ($location.$$path.startsWith("/insights")) {
          return $rootScope.page = "Insights";
        } else if ($location.$$path.startsWith("/administration")) {
          return $rootScope.page = "Administration";
        } else if ($location.$$path.startsWith("/fault")) {
          return $rootScope.page = "FaultReporting";
        } else if ($location.$$path.startsWith("/operationalPlan")) {
          return $rootScope.page = "OperationalPlan";
        } else if ($location.$$path.startsWith("/MSDAT")) {
          return $rootScope.page = "MSDAT";
        } else if ($location.$$path.startsWith("/backToBasics")) {
          return $rootScope.page = "BackToBasics";
        } else {
          return $rootScope.page = "Home";
        }
      });
      hub = $.connection.faultReportingHub;
      hub.client.fault = function(x) {
        var sound;
        sound = document.getElementById("alarm");
        sound.play();
        notification("<a href='/#/faultReport/" + x + "'>A new fault has been reported</a>", false, true);
        return $rootScope.$broadcast('fault', x);
      };
      if (operation('FaultAdmin')) {
        return $.connection.hub.start();
      }
    }
  ]);

  Array.prototype.any = function(predicate) {
    var item, _i, _len;
    for (_i = 0, _len = this.length; _i < _len; _i++) {
      item = this[_i];
      if (predicate(item)) {
        return true;
      }
    }
    return false;
  };

  Array.prototype.first = function(predicate) {
    var item, _i, _len;
    for (_i = 0, _len = this.length; _i < _len; _i++) {
      item = this[_i];
      if (predicate(item)) {
        return item;
      }
    }
    return null;
  };

  Array.prototype.flatMap = function(selector) {
    var item, results, x, _i, _j, _len, _len1, _ref;
    results = [];
    _ref = this.map(selector);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      item = _ref[_i];
      for (_j = 0, _len1 = item.length; _j < _len1; _j++) {
        x = item[_j];
        results.push(x);
      }
    }
    return results;
  };

  Array.prototype.groupBy = function(keySelector) {
    var key, value, y, _results;
    y = this.reduce(function(xs, x) {
      var key;
      key = keySelector(x);
      if (!(key in xs)) {
        xs[key] = [];
      }
      xs[key].push(x);
      return xs;
    }, {});
    _results = [];
    for (key in y) {
      value = y[key];
      _results.push({
        key: key,
        value: value
      });
    }
    return _results;
  };

  this.count = function(obj) {
    return Object.keys(obj).length;
  };

  this.finYearPeriod = function(calendarYear, calendarMonth) {
    if (calendarMonth <= 6) {
      return {
        finYear: calendarYear,
        finPeriod: calendarMonth + 6
      };
    } else {
      return {
        finYear: calendarYear + 1,
        finPeriod: calendarMonth - 6
      };
    }
  };

}).call(this);
