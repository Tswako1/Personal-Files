app = angular.module('mipmis', ['ui.map','ui.bootstrap','blueimp.fileupload','LocalStorageModule'])  
 
app.config ['$routeProvider','$httpProvider', ($routeProvider,$httpProvider) ->
    $routeProvider.
      when('/', 
            templateUrl: 'content/views/home.html',  
            controller: HomeController, 
            caseInsensitiveMatch: true 
            resolve:
                projects: ['$http', 'operation', ($http, operation) -> if operation('ViewProject') then $http.get 'api/project'] 
                tasks: ['$http', ($http) -> $http.get 'api/task']
                infrastructures: ['$http', 'operation', ($http, operation) -> if operation('ViewInfrastructure') then $http.get 'api/infrastructureRegister'])
      .when('/administration', 
            templateUrl: 'content/views/administration.html' 
            resolve:
                breadcrumb: ['breadcrumb',(breadcrumb)-> breadcrumb({})]
            )
      .when('/administration/peopleList', 
            templateUrl: 'content/views/peopleList.html',  
            controller: PeopleListController,
            resolve:
                people: ['$http', '$route', ($http, $route) -> $http.get "api/people"]
            )
      .when('/administration/people/:id', 
            templateUrl: 'content/views/people.html',  
            controller: PeopleController,
            resolve:
                people: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/people/#{$route.current.params.id}"]
                provinces: ['$http', ($http) -> $http.get "lookup/provinces"]
                districts: ['$http', ($http) -> $http.get "lookup/districts"]

                organisations : ['$http',($http) -> $http.get "lookup/organisationsWithProviceAndDistrict"]
                jobDescriptions : ['$http',($http) -> $http.get "lookup/jobDescriptions"]
                organisationHierarchy : ['$http',($http) -> $http.get "lookup/organisationHierarchy"]
                roles : ['$http',($http) -> $http.get "lookup/roles"]
                sectors : ['$http',($http) -> $http.get "lookup/SectorProgrammesAll"]
                isUser : -> false 
                isAtLoadUser : -> false 

            )
      .when('/administration/faultTypeList', 
            templateUrl: 'content/views/faultTypeList.html',  
            controller: FaultTypeListController,
            resolve:
                faultTypes: ['$http', '$route', ($http, $route) -> $http.get "api/faultType"]
            )
      .when('/administration/faultType/:id', 
            templateUrl: 'content/views/faultType.html',  
            controller: FaultTypeController,
            resolve:
                faultType: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/faultType/#{$route.current.params.id}"]
                sectors: ['$http', ($http) -> $http.get "lookup/sectorProgrammes"]
                priorities: ['$http', ($http) -> $http.get "lookup/faultPriorities"]
            )
      .when('/administration/faultOrganisationSectorPersonList', 
            templateUrl: 'content/views/faultOrganisationSectorPersonList.html',  
            controller: FaultOrganisationSectorPersonListController,
            resolve:
                faultOrganisationSectorPersonList: ['$http', '$route', ($http, $route) -> $http.get "api/faultOrganisationSectorPerson"]
            )
      .when('/administration/faultOrganisationSectorPerson/:id', 
            templateUrl: 'content/views/faultOrganisationSectorPerson.html',  
            controller: FaultOrganisationSectorPersonController,
            resolve:
                faultOrganisationSectorPerson: ['$http', '$route',($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/faultOrganisationSectorPerson/#{$route.current.params.id}"]
                provinces: ['$http', ($http) -> $http.get "lookup/provinces"]
                sectors: ['$http', ($http) -> $http.get "lookup/sectorProgrammes"]
            )
      .when('/administration/faultPriorityList', 
            templateUrl: 'content/views/faultPriorityList.html',  
            controller: FaultPriorityListController,
            resolve:
                faultPriorities: ['$http', '$route', ($http, $route) -> $http.get "api/faultPriority"]
            )
      .when('/administration/faultPriority/:id', 
            templateUrl: 'content/views/faultPriority.html',  
            controller: FaultPriorityController,
            resolve:
                faultPriority: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/faultPriority/#{$route.current.params.id}"]
                faultEscalationTimes: ['$http', ($http) -> $http.get "lookup/faultEscalationTime"]
            )
      .when('/faultReport/:id', 
            templateUrl: 'content/views/faultReporting.html',  
            controller: FaultReportController,
            resolve:
                faultReport: ['$http', '$route', ($http, $route) -> $http.get "api/faultReportInternal/#{$route.current.params.id}"]
            )
      .when('/faultReportList', 
            templateUrl: 'content/views/faultReportList.html',  
            controller: FaultReportListController,
            resolve:
                #people: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/people/#{$route.current.params.id}"]
                faultReports: ['$http', '$route', ($http, $route) -> $http.get "api/faultReportInternal"]
                faultReportStatus: ['$http', ($http) -> $http.get "lookup/faultStatus"]
                organisations : ['$http',($http) -> $http.get "lookup/organisationsWithProviceAndDistrict"]
                sectorProgrammes : ['$http',($http) -> $http.get "lookup/sectorProgrammes"]
            )
      .when('/administration/assetClassList', 
            templateUrl: 'content/views/assetClassList.html',  
            controller: AssetClassListController,
            resolve:
                assetClasses: ['$http', '$route', ($http, $route) -> $http.get "api/assetClass"]
            )
      .when('/administration/assetClass/:id', 
            templateUrl: 'content/views/assetClass.html',  
            controller: AssetClassController,
            resolve:
                assetClass: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/assetClass/#{$route.current.params.id}"]
            )
        .when('/administration/actionsTakenAgainstFraudList', 
            templateUrl: 'content/views/actionsTakenAgainstFraudList.html',  
            controller: ActionsTakenAgainstFraudListController,
            resolve:
                actionsTakenAgainstFraud: ['$http', '$route', ($http, $route) -> $http.get "api/actionsTakenAgainstFraud"]
            )
      .when('/administration/actionsTakenAgainstFraud/:id', 
            templateUrl: 'content/views/actionsTakenAgainstFraud.html',  
            controller: ActionsTakenAgainstFraudController,
            resolve:
                actionsTakenAgainstFraud: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/actionsTakenAgainstFraud/#{$route.current.params.id}"]
            )
      .when('/administration/causeOfProtestList', 
            templateUrl: 'content/views/causeOfProtestList.html',  
            controller: CauseOfProtestListController,
            resolve:
                causesOfProtest: ['$http', '$route', ($http, $route) -> $http.get "api/causeOfProtest"]
            )
      .when('/administration/causeOfProtest/:id', 
            templateUrl: 'content/views/causeOfProtest.html',  
            controller: CauseOfProtestController,
            resolve:
                causeOfProtest: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/causeOfProtest/#{$route.current.params.id}"]
            )
      .when('/administration/causeOfStoppageList', 
            templateUrl: 'content/views/causeOfStoppageList.html',  
            controller: CauseOfStoppageListController,
            resolve:
                causesOfStoppage: ['$http', '$route', ($http, $route) -> $http.get "api/causeOfStoppage"]
            )
      .when('/administration/causeOfStoppage/:id', 
            templateUrl: 'content/views/causeOfStoppage.html',  
            controller: CauseOfStoppageController,
            resolve:
                causeOfStoppage: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/causeOfStoppage/#{$route.current.params.id}"]
            )
      .when('/administration/typeOfStoppageList', 
            templateUrl: 'content/views/typeOfStoppageList.html',  
            controller: TypeOfStoppageListController,
            resolve:
                typesOfStoppage: ['$http', '$route', ($http, $route) -> $http.get "api/typeOfStoppage"]
            )
      .when('/administration/typeOfStoppage/:id', 
            templateUrl: 'content/views/typeOfStoppage.html',  
            controller: TypeOfStoppageController,
            resolve:
                typeOfStoppage: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/typeOfStoppage/#{$route.current.params.id}"]
            )
      .when('/administration/frequencyOfCollectionList', 
            templateUrl: 'content/views/frequencyOfCollectionList.html',  
            controller: FrequencyOfCollectionListController,
            resolve:
                frequenciesOfCollection: ['$http', '$route', ($http, $route) -> $http.get "api/frequencyOfCollection"]
            )
      .when('/administration/frequencyOfCollection/:id', 
            templateUrl: 'content/views/frequencyOfCollection.html',  
            controller: FrequencyOfCollectionController,
            resolve:
                frequencyOfCollection: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/frequencyOfCollection/#{$route.current.params.id}"]
            )
      .when('/administration/crossCuttingProgrammeList', 
            templateUrl: 'content/views/crossCuttingProgrammeList.html',  
            controller: CrossCuttingProgrammeListController,
            resolve:
                crossCuttingProgrammes: ['$http', '$route', ($http, $route) -> $http.get "api/crossCuttingProgramme"]
            )
      .when('/administration/crossCuttingProgramme/:id', 
            templateUrl: 'content/views/crossCuttingProgramme.html',  
            controller: CrossCuttingProgrammeController,
            resolve:
                crossCuttingProgramme: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/crossCuttingProgramme/#{$route.current.params.id}"]
            )
      .when('/administration/developmentalLocationList', 
            templateUrl: 'content/views/developmentalLocationList.html',  
            controller: DevelopmentalLocationListController,
            resolve:
                developmentalLocations: ['$http', '$route', ($http, $route) -> $http.get "api/developmentalLocation"]
            )
      .when('/administration/developmentalLocation/:id', 
            templateUrl: 'content/views/developmentalLocation.html',  
            controller: DevelopmentalLocationController,
            resolve:
                developmentalLocation: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/developmentalLocation/#{$route.current.params.id}"]
            )
      .when('/administration/fundingSourceGroupList', 
            templateUrl: 'content/views/fundingSourceGroupList.html',  
            controller: FundingSourceGroupListController,
            resolve:
                fundingSourceGroups: ['$http', '$route', ($http, $route) -> $http.get "api/fundingSourceGroup"]
            )
      .when('/administration/fundingSourceGroup/:id', 
            templateUrl: 'content/views/fundingSourceGroup.html',  
            controller: FundingSourceGroupController,
            resolve:
                fundingSourceGroup: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/fundingSourceGroup/#{$route.current.params.id}"]
            )
      .when('/administration/fundingSourceList', 
            templateUrl: 'content/views/fundingSourceList.html',  
            controller: FundingSourceListController,
            resolve:
                fundingSources: ['$http', '$route', ($http, $route) -> $http.get "api/fundingSource"]
            )
      .when('/administration/fundingSource/:id', 
            templateUrl: 'content/views/fundingSource.html',  
            controller: FundingSourceController,
            resolve:
                fundingSourceGroups: ['$http', ($http) -> $http.get "lookup/fundingSourceGroups"]
                fundingSource: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/fundingSource/#{$route.current.params.id}"]
            )
      .when('/administration/jobDescriptionList', 
            templateUrl: 'content/views/jobDescriptionList.html',  
            controller: JobDescriptionListController,
            resolve:
                jobDescriptions: ['$http', '$route', ($http, $route) -> $http.get "api/jobDescription"]
            )
      .when('/administration/jobDescription/:id', 
            templateUrl: 'content/views/jobDescription.html',  
            controller: JobDescriptionController,
            resolve:
                jobDescription: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/jobDescription/#{$route.current.params.id}"]
            )
      .when('/administration/migComponentList', 
            templateUrl: 'content/views/migComponentList.html',  
            controller: MigComponentListController,
            resolve:
                migComponents: ['$http', '$route', ($http, $route) -> $http.get "api/migComponent"]
            )
      .when('/administration/migComponent/:id', 
            templateUrl: 'content/views/migComponent.html',  
            controller: MigComponentController,
            resolve:
                migComponent: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/migComponent/#{$route.current.params.id}"]
            )
      .when('/administration/mOPProjectTypeList', 
            templateUrl: 'content/views/mOPProjectTypeList.html',  
            controller: MOPProjectTypeListController,
            resolve:
                mOPProjectTypes: ['$http', '$route', ($http, $route) -> $http.get "api/mOPProjectType"]
            )
      .when('/administration/mOPProjectType/:id', 
            templateUrl: 'content/views/mOPProjectType.html',  
            controller: MOPProjectTypeController,
            resolve:
                mOPProjectType: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPProjectType/#{$route.current.params.id}"]
            )
      .when('/administration/mOPProjectStageList', 
            templateUrl: 'content/views/mOPProjectStageList.html',  
            controller: MOPProjectStageListController,
            resolve:
                mOPProjectStages: ['$http', '$route', ($http, $route) -> $http.get "api/mOPProjectStage"]
            )
      .when('/administration/mOPProjectStage/:id', 
            templateUrl: 'content/views/mOPProjectStage.html',  
            controller: MOPProjectStageController,
            resolve:
                mOPProjectStage: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPProjectStage/#{$route.current.params.id}"]
            )
      .when('/administration/mOPKPIList', 
            templateUrl: 'content/views/mOPKPIList.html',  
            controller: MOPKPIListController,
            resolve:
                mOPKPIs: ['$http', '$route', ($http, $route) -> $http.get "api/mOPKPI"]
            )
      .when('/administration/mOPKPI/:id', 
            templateUrl: 'content/views/mOPKPI.html',  
            controller: MOPKPIController,
            resolve:
                mOPKPI: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPKPI/#{$route.current.params.id}"]
            )
      .when('/administration/mOPIIKPIList', 
            templateUrl: 'content/views/mOPIIKPIList.html',  
            controller: MOPIIKPIListController,
            resolve: 
                mOPIIKPIs: ['$http', '$route', ($http, $route) -> $http.get "api/mOPIIKPI"]
            )
      .when('/administration/mOPIIKPI/:id', 
            templateUrl: 'content/views/mOPIIKPI.html',  
            controller: MOPIIKPIController,
            resolve:
                mISAFinancialYears: ['$http', ($http) -> $http.get "lookup/misaFinancialYears"]
                mOPIIKPI: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPIIKPI/#{$route.current.params.id}"]
            )
      .when('/administration/mOPIISectionList', 
            templateUrl: 'content/views/mOPIISectionList.html',  
            controller: MOPIISectionListController,
            resolve:
                mOPIISections: ['$http', '$route', ($http, $route) -> $http.get "api/mOPIISection"]
            )
      .when('/administration/mOPIISection/:id', 
            templateUrl: 'content/views/mOPIISection.html',  
            controller: MOPIISectionController,
            resolve:
                mOPIIKPIs: ['$http', ($http) -> $http.get "lookup/mOPIIKPIs"]
                mOPIISection: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPIISection/#{$route.current.params.id}"]
            )
      .when('/administration/mOPIIProcessList', 
            templateUrl: 'content/views/mOPIIProcessList.html',  
            controller: MOPIIProcessListController,
            resolve:
                mOPIIProcesss: ['$http', '$route', ($http, $route) -> $http.get "api/mOPIIProcess"]
            )
      .when('/administration/mOPIIProcess/:id', 
            templateUrl: 'content/views/mOPIIProcess.html',  
            controller: MOPIIProcessController,
            resolve:
                mOPIISections: ['$http', ($http) -> $http.get "lookup/mOPIISections"]
                mOPIIProcess: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPIIProcess/#{$route.current.params.id}"]
            )
      .when('/administration/mOPSectorList', 
            templateUrl: 'content/views/mOPSectorList.html',  
            controller: MOPSectorListController,
            resolve:
                mOPSectors: ['$http', '$route', ($http, $route) -> $http.get "api/mOPSector"]
            )
      .when('/administration/mOPSector/:id', 
            templateUrl: 'content/views/mOPSector.html',  
            controller: MOPSectorController,
            resolve:
                mOPSector: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPSector/#{$route.current.params.id}"]
            )
      .when('/administration/misaSupportAgentList', 
            templateUrl: 'content/views/misaSupportAgentList.html',  
            controller: MisaSupportAgentListController,
            resolve:
                misaSupportAgents: ['$http', '$route', ($http, $route) -> $http.get "api/misaSupportAgent"]
            )
      .when('/administration/misaSupportAgent/:id', 
            templateUrl: 'content/views/misaSupportAgent.html',  
            controller: MisaSupportAgentController,
            resolve:
                misaSupportAgent: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/misaSupportAgent/#{$route.current.params.id}"]
            )
      .when('/administration/mOPResponsiblePeopleList', 
            templateUrl: 'content/views/MOPResponsiblePeopleList.html',  
            controller: MOPResponsiblePeopleListController,
            resolve:
                mOPResponsiblePeoples: ['$http', '$route', ($http, $route) -> $http.get "api/mOPResponsiblePeople"]
            )
      .when('/administration/mOPResponsiblePeople/:id', 
            templateUrl: 'content/views/MOPResponsiblePeople.html',  
            controller: MOPResponsiblePeopleController,
            resolve:
                mOPResponsiblePeople: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/mOPResponsiblePeople/#{$route.current.params.id}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
            )
      .when('/administration/sectorProgrammeList', 
            templateUrl: 'content/views/sectorProgrammeList.html',  
            controller: SectorProgrammeListController,
            resolve:
                sectorProgrammes: ['$http', '$route', ($http, $route) -> $http.get "api/sectorProgramme"]
            )
      .when('/administration/sectorProgramme/:id', 
            templateUrl: 'content/views/sectorProgramme.html',  
            controller: SectorProgrammeController,
            resolve:
                sectorProgramme: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/sectorProgramme/#{$route.current.params.id}"]
            )
      .when('/administration/indicatorItemList', 
            templateUrl: 'content/views/indicatorItemList.html',  
            controller: IndicatorItemListController,
            resolve:
                indicatorItems: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorItem"]
            )
      .when('/administration/indicatorItem/:id', 
            templateUrl: 'content/views/indicatorItem.html',  
            controller: IndicatorItemController,
            resolve:
                indicatorItem: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/indicatorItem/#{$route.current.params.id}"]
            )
      .when('/administration/indicatorStandardList', 
            templateUrl: 'content/views/indicatorStandardList.html',  
            controller: IndicatorStandardListController,
            resolve:
                indicatorStandards: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorStandard"]
            )
      .when('/administration/indicatorStandard/:id', 
            templateUrl: 'content/views/indicatorStandard.html',  
            controller: IndicatorStandardController,
            resolve:
                indicatorStandard: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/indicatorStandard/#{$route.current.params.id}"]
            )
      .when('/administration/indicatorStrategyList', 
            templateUrl: 'content/views/indicatorStrategyList.html',  
            controller: IndicatorStrategyListController,
            resolve:
                indicatorStrategies: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorStrategy"]
            )
      .when('/administration/indicatorStrategy/:id', 
            templateUrl: 'content/views/indicatorStrategy.html',  
            controller: IndicatorStrategyController,
            resolve:
                indicatorStrategy: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/indicatorStrategy/#{$route.current.params.id}"]
            )
      .when('/administration/indicatorTypeList', 
            templateUrl: 'content/views/indicatorTypeList.html',  
            controller: IndicatorTypeListController,
            resolve:
                indicatorTypes: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorType"]
            )
      .when('/administration/indicatorType/:id', 
            templateUrl: 'content/views/indicatorType.html',  
            controller: IndicatorTypeController,
            resolve:
                indicatorType: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/indicatorType/#{$route.current.params.id}"]
            )
      .when('/administration/indicatorUnitOfMeasureList', 
            templateUrl: 'content/views/indicatorUnitOfMeasureList.html',  
            controller: IndicatorUnitOfMeasureListController,
            resolve:
                indicatorUnitOfMeasures: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorUnitOfMeasure"]
            )
      .when('/administration/indicatorUnitOfMeasure/:id', 
            templateUrl: 'content/views/indicatorUnitOfMeasure.html',  
            controller: IndicatorUnitOfMeasureController,
            resolve:
                indicatorUnitOfMeasure: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/indicatorUnitOfMeasure/#{$route.current.params.id}"]
            )
      .when('/administration/indicators', 
            templateUrl: 'content/views/indicatorList.html',  
            controller: IndicatorListController,
            resolve:
                indicators: ['$http', '$route', ($http, $route) -> $http.get "api/indicator"]
            )
      .when('/administration/indicator/:id', 
            templateUrl: 'content/views/indicator.html',  
            controller: IndicatorController,
            resolve:
                indicator:  ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/indicator/#{$route.current.params.id}"]
                types: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorType"]
                unitOfMeasures: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorUnitOfMeasure"]
                standards: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorStandard"]
                items: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorItem"]
                strategies: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorStrategy"]
            )
      .when('/administration/indicatorTargets/:id', 
            templateUrl: 'content/views/indicatorTargets.html',  
            controller: IndicatorTargetsController,
            resolve:
                targets: ['$http', '$route', ($http, $route) -> $http.get "api/indicatorTargets/#{$route.current.params.id}"]
            )
      .when('/project/:id', 
            templateUrl: 'content/views/project.html',  
            controller: ProjectController,
            resolve:
                project: ['$http', '$route', ($http, $route) -> $http.get "api/project/#{$route.current.params.id}"])
      .when('/project', 
            templateUrl: 'content/views/projectList.html',  
            caseInsensitiveMatch: true
            controller: ProjectListController
            resolve:
                projects : ['$http',($http) -> $http.get "api/project?filter="]
                organisations : ['$http',($http) -> $http.get "lookup/organisations"]
                projectStatus : ['$http',($http) -> $http.get "lookup/projectStatus"]
                sectorProgrammes : ['$http',($http) -> $http.get "lookup/sectorProgrammes"]
                fundingSources: ['$http',($http) -> $http.get "lookup/fundingSources"]
                deleteProject : -> false 
            )
      .when('/administration/deleteProject', 
            templateUrl: 'content/views/projectList.html',  
            caseInsensitiveMatch: true
            controller: ProjectListController
            resolve:
                projects : ['$http',($http) -> $http.get "api/project?filter="]
                organisations : ['$http',($http) -> $http.get "lookup/organisations"]
                projectStatus : ['$http',($http) -> $http.get "lookup/projectStatus"]
                sectorProgrammes : ['$http',($http) -> $http.get "lookup/sectorProgrammes"]
                fundingSources: ['$http',($http) -> $http.get "lookup/fundingSources"]
                deleteProject : -> true 
            )
      .when('/insights', 
            templateUrl: 'content/views/insights.html',  
            controller: InsightController
            resolve:
                insights : ['$http',($http) -> $http.get "lookup/insights"]
                )
      .when('/projectRegistration/:id', 
            templateUrl: 'content/views/projectregistration.html',  
            controller: ProjectRegistrationContoller,
            resolve:
                project: ['$http', '$route', ($http, $route) -> if $route.current.params.id == "Create" then null else  $http.get "api/project/#{$route.current.params.id}"]

                
                #infrastructureRegisters : ['$http',($http) -> $http.get "lookup/infrastructureRegisters"]
                organisations : ['$http',($http) -> $http.get "lookup/organisations"]
                projectStatus : ['$http',($http) -> $http.get "lookup/projectStatus"]
                infrastructureLifeCycles : ['$http',($http) -> $http.get "lookup/infrastructureLifeCycles"]
                implementingAgents : ['$http',($http) -> $http.get "lookup/implementingAgents"]
                migComponents : ['$http',($http) -> $http.get "lookup/migComponents"]
                misaSupportAgents : ['$http',($http) -> $http.get "lookup/misaSupportAgents"]
                sectorProgrammes : ['$http',($http) -> $http.get "lookup/sectorProgrammes"]
                crossCuttingProgrammes : ['$http',($http) -> $http.get "lookup/crossCuttingProgrammes"]
                developmentalLocations : ['$http',($http) -> $http.get "lookup/developmentalLocations"]
                fundingSources: ['$http',($http) -> $http.get "lookup/fundingSources"]
                
                )
      .when('/projectRegistration/:id/financials', 
            templateUrl: 'content/views/projectFinancials.html',  
            controller: ProjectFinancialsController,
            resolve:
                
                projectFinancials : ['$http','$route',($http,$route) -> $http.get "api/projectFinancials/#{$route.current.params.id}"]
                )
      .when('/projectRegistration/:id/projectStakeHolderList', 
            templateUrl: 'content/views/projectStakeHolderList.html',  
            controller: ProjectStakeHolderListController,
            resolve:
                
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]
                projectStakeHolders : ['$http','$route',($http,$route) -> $http.get "api/projectStakeHolder/",params: projectId:$route.current.params.id]

                )
      .when('/projectRegistration/:projectId/projectStakeHolder/:id', 
            templateUrl: 'content/views/projectStakeHolder.html',  
            controller: ProjectStakeHolderController,
            resolve:
                
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.projectId}"]
                projectStakeHolder : ['$http','$route',($http,$route) -> if $route.current.params.id == "Create" then null else $http.get "api/projectStakeHolder/#{$route.current.params.id}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]

                )
      .when('/projectRegistration/:id/siteVisitList', 
            templateUrl: 'content/views/siteVisitList.html',
            caseInsensitiveMatch: true
            controller: SiteVisitListController
            resolve:
                siteVisits : ['$http', '$route',($http, $route) -> $http.get "api/siteVisit/",params: projectId:$route.current.params.id]
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]
                ) 
      .when('/projectRegistration/:projectId/siteVisitSchedule/:id', 
            templateUrl: 'content/views/siteVisitSchedule.html',  
            controller: SiteVisitController,
            resolve:
                siteVisit : ['$http','$route',($http,$route) ->if $route.current.params.id == "Create" then $http.get "api/siteVisit?project=#{$route.current.params.projectId}&id=" else $http.get "api/siteVisit/#{$route.current.params.id}?project=#{$route.current.params.projectId}"]
                people: ['$http','$route',($http,$route) -> $http.get "lookup/PeopleByProjectId", params: projectId: $route.current.params.projectId],
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.projectId}"]
                )
      .when('/projectRegistration/:projectId/siteVisitUpdate/:id', 
            templateUrl: 'content/views/siteVisitUpdate.html',  
            controller: SiteVisitController,
            resolve:
                siteVisit : ['$http','$route',($http,$route) -> $http.get "api/siteVisit/#{$route.current.params.id}?project=#{$route.current.params.projectId}"]
                people: ['$http','$route',($http,$route) -> $http.get "lookup/PeopleBySiteVisitId", params: siteVisitId: $route.current.params.id],
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.projectId}"]
                )
      .when('/siteVisitUpdate/:id', 
            templateUrl: 'content/views/siteVisitUpdate.html',  
            controller: SiteVisitController,
            resolve:
                siteVisit : ['$http','$route',($http,$route) -> $http.get "api/siteVisit/#{$route.current.params.id}"]
                people: ['$http','$route',($http,$route) -> $http.get "lookup/PeopleBySiteVisitId", params: siteVisitId: $route.current.params.id],
                #projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.projectId}"]
                )
      .when('/projectRegistration/:id/riskList', 
            templateUrl: 'content/views/projectRiskList.html',
            caseInsensitiveMatch: true
            controller: ProjectRiskListController
            resolve:
                projectRisks : ['$http', '$route',($http, $route) -> $http.get "api/projectRisk/",params: projectId:$route.current.params.id]
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]
                )
      .when('/projectRegistration/:projectId/projectRisk/:id', 
            templateUrl: 'content/views/projectRisk.html',  
            controller: ProjectRiskController,
            resolve:

                projectRiskTypes : ['$http',($http) -> $http.get "lookup/ProjectRiskTypes"]
                projectRiskCategories : ['$http',($http) -> $http.get "lookup/ProjectRiskCategories"]
                riskConsequences : ['$http',($http) -> $http.get "lookup/RiskConsequences"]
                riskProbabilities : ['$http',($http) -> $http.get "lookup/RiskProbabilities"]
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.projectId}"]
                projectRiskDescription :['$http','$route',($http,$route) -> if $route.current.params.id == "Create" then null else $http.get "breadCrumb/GetProjectRiskDescription/#{$route.current.params.id}"]
                projectRisk : ['$http','$route',($http,$route) -> if $route.current.params.id == "Create" then null else $http.get "api/ProjectRisk/#{$route.current.params.id}"]
                people: ['$http',($http) -> $http.get "lookup/people"]
                )
      .when('/projectRegistration/:id/issueList', 
            templateUrl: 'content/views/projectIssueList.html',
            controller: ProjectIssueListController
            resolve:
                projectIssues : ['$http', '$route',($http, $route) -> $http.get "api/projectIssue/",params: projectId:$route.current.params.id]
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]
                )
      .when('/projectRegistration/:id/qualityControl', 
            templateUrl: 'content/views/projectQualityControl.html',
            caseInsensitiveMatch: true
            controller: ProjectQualityControlController
            resolve:
                checks : ['$http', '$route',($http, $route) -> $http.get "api/ProjectQualityChecks",params: projectId:$route.current.params.id]
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]
                )
      .when('/projectRegistration/:projectId/projectIssue/:id', 
            templateUrl: 'content/views/projectIssue.html',  
            controller: ProjectIssueController,
            resolve:

                issueSeverity : ['$http',($http) -> $http.get "lookup/RiskConsequences"]
                issueProbability : ['$http',($http) -> $http.get "lookup/RiskProbabilities"]
                projectDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.projectId}"]
                projectIssueDescription :['$http','$route',($http,$route) -> if $route.current.params.id == "Create" then null else $http.get "breadCrumb/GetProjectIssueDescription/#{$route.current.params.id}"]
                projectIssue : ['$http','$route',($http,$route) -> if $route.current.params.id == "Create" then null else $http.get "api/ProjectIssue/#{$route.current.params.id}"]
                people: ['$http',($http) -> $http.get "lookup/people"]
                )
      .when('/projectRegistration/:id/projectCheckList', 
            templateUrl: 'content/views/projectCheckList.html',  
            controller: ProjectCheckListController,
            resolve:
                
                project : ['$http', '$route',($http, $route) -> $http.get "api/projectCheckList/#{$route.current.params.id}"]
                documentTypes: ['$http',($http) -> $http.get "lookup/documentTypes"]
                )
      .when('/projectRegistration/:id/projectActivities', 
            templateUrl: 'content/views/projectActivities.html',  
            controller: ProjectActivitiesController,
            resolve:
                
                project : ['$http', '$route',($http, $route) -> $http.get "api/projectActivities/#{$route.current.params.id}"]
                )
      .when('/projectRegistration/:id/indicators', 
            templateUrl: 'content/views/projectIndicatorList.html',  
            controller: ProjectIndicatorsController,
            resolve:
                project :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]                
                indicators : ['$http', '$route',($http, $route) -> $http.get "api/projectIndicators?projectId=#{$route.current.params.id}"]
                )
      .when('/projectRegistration/:id/indicator/:indicatorId', 
            templateUrl: 'content/views/projectIndicatorValues.html',  
            controller: ProjectIndicatorValuesController,
            resolve:
                project :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]                
                indicator : ['$http', '$route',($http, $route) -> $http.get "api/projectIndicators/#{$route.current.params.indicatorId}"]
                )
      .when('/projectRegistration/:id/indicators/create', 
            templateUrl: 'content/views/projectIndicatorCreate.html',  
            controller: ProjectIndicatorsCreateController,
            resolve:
                project :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetProjectDescription/#{$route.current.params.id}"]                
                indicators : ['$http', '$route',($http, $route) -> $http.get "api/indicator"]
                )
      .when('/projectOverview/:id', 
            templateUrl: 'content/views/projectOverview.html',  
            caseInsensitiveMatch: true
            controller: ProjectOverviewController
            resolve:
                project : ['$http', '$route',($http, $route) -> $http.get "api/project/#{$route.current.params.id}"]
                financials: ['$http', '$route',($http, $route) -> $http.get "api/projectFinancials/#{$route.current.params.id}"]
                activities: ['$http', '$route',($http, $route) -> $http.get "api/projectActivities/#{$route.current.params.id}"]
                risks : ['$http', '$route',($http, $route) -> $http.get "api/projectRisk/",params: projectId:$route.current.params.id]
                issues : ['$http', '$route',($http, $route) -> $http.get "api/projectIssue/",params: projectId:$route.current.params.id]
                siteVisits : ['$http', '$route',($http, $route) -> $http.get "api/siteVisit/",params: projectId:$route.current.params.id]

                indicators: ['$http', '$route',($http, $route) -> $http.get "api/projectIndicators?projectId=#{$route.current.params.id}"]
                )
      .when('/project/:id/issue/create', 
            templateUrl: 'content/views/issue.html',  
            caseInsensitiveMatch: true
            controller: IssueController)
      .when('/project/:id/notes', 
            templateUrl: 'content/views/notes.html',  
            caseInsensitiveMatch: true
            controller: NotesController)
      .when('/sitevisit/:id', 
            templateUrl: 'content/views/sitevisit.html',  
            caseInsensitiveMatch: true 
            controller: SiteVisitController
            resolve:
                siteVisit : ['$http', '$route',($http, $route) -> $http.get "api/siteVisit/#{$route.current.params.id}"])
      .when('/infrastructureRegister/:id', 
            templateUrl: 'content/views/infrastructureRegister.html',  
            caseInsensitiveMatch: true
            controller: InfrastructureRegisterController
            resolve:
                infrastructureRegister : ['$http', '$route',($http, $route) -> if $route.current.params.id == "Create" then null else $http.get "api/infrastructureRegister/#{$route.current.params.id}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                criticalityGrades : ['$http',($http) -> $http.get "lookup/CriticalityGrades"]
                conditions : ['$http',($http) -> $http.get "lookup/Conditions"]
                assetClasses : ['$http',($http) -> $http.get "lookup/assetClasses"]
                sectorProgrammes : ['$http',($http) -> $http.get "lookup/sectorProgrammes"]
                documentTypes : ['$http',($http) -> $http.get "lookup/documentTypes"]
                )
      .when('/infrastructureRegisterOverview/:id', 
            templateUrl: 'content/views/infrastructureRegisterOverview.html',  
            caseInsensitiveMatch: true
            controller: InfrastructureRegisterOverviewController
            resolve:
                infrastructureRegister : ['$http', '$route',($http, $route) -> $http.get "api/infrastructureRegister/#{$route.current.params.id}"]
                infrastructureRisks : ['$http', '$route',($http, $route) -> $http.get "api/infrastructureRisk/",params: infrastructureRegisterId:$route.current.params.id])
      .when('/infrastructureRegister', 
            templateUrl: 'content/views/infrastructureRegisterList.html',  
            caseInsensitiveMatch: true
            controller: InfrastructureRegisterListController
            resolve:
                infrastructureRegisters : ['$http',($http) -> $http.get "api/infrastructureRegister?filter="]
                organisations : ['$http',($http) -> $http.get "lookup/organisations"]
                assetClasses : ['$http',($http) -> $http.get "lookup/assetClasses"]
                deleteInfrastructure : -> false 
                )
      .when('/administration/deleteInfrastructureRegister', 
            templateUrl: 'content/views/infrastructureRegisterList.html',  
            caseInsensitiveMatch: true
            controller: InfrastructureRegisterListController
            resolve:
                infrastructureRegisters : ['$http',($http) -> $http.get "api/infrastructureRegister?filter="]
                assetClasses : ['$http',($http) -> $http.get "lookup/assetClasses"]
                organisations : ['$http',($http) -> $http.get "lookup/organisations"]
                deleteInfrastructure : -> true 
                )
      .when('/infrastructureRegister/:id/infrastructureRisk', 
            templateUrl: 'content/views/infrastructureRiskList.html',
            caseInsensitiveMatch: true
            controller: InfrastructureRiskListController
            resolve:
                infrastructureRisks : ['$http', '$route',($http, $route) -> $http.get "api/infrastructureRisk/",params: infrastructureRegisterId:$route.current.params.id]
                insights : ['$http',($http) -> $http.get "lookup/Insights"]
                infrastructureRiskDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetInfrastructureRegisterDescription/#{$route.current.params.id}"])
      .when('/infrastructureRegister/:id/infrastructureRisk/:riskId', 
            templateUrl: 'content/views/infrastructureRisk.html',  
            caseInsensitiveMatch: true
            controller: InfrastructureRiskController
            resolve:
                infrastructureRisk : ['$http', '$route',($http, $route) -> if $route.current.params.riskId == "Create" then null else $http.get "api/infrastructureRisk/#{$route.current.params.riskId}"]
                riskTypes : ['$http',($http) -> $http.get "lookup/RiskTypes"]
                riskConsequences : ['$http',($http) -> $http.get "lookup/RiskConsequences"]
                riskProbabilities : ['$http',($http) -> $http.get "lookup/RiskProbabilities"]
                infrastructureRiskDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetInfrastructureRegisterDescription/#{$route.current.params.id}"])
      .when('/backToBasics', 
            templateUrl: 'content/views/backToBasicsList.html',  
            controller: BackToBasicsListController,
            resolve:
                backToBasics: ['$http', '$route', ($http, $route) -> $http.get "api/backToBasics"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/FinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/FinancialPeriods"]
            )
      .when('/backToBasics/Create', 
            templateUrl: "content/views/backToBasics1.html",  
            caseInsensitiveMatch: true
            controller: BackToBasicsController
            resolve:
                backToBasics : () -> null
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                actionsAgainstFraud : ['$http',($http) -> $http.get "lookup/ActionsAgainstFraud"]
                causesOfProtest : ['$http',($http) -> $http.get "lookup/CauseOfProtest"]
                causesOfStoppage : ['$http',($http) -> $http.get "lookup/CauseOfStoppage"]
                typesOfStoppage : ['$http',($http) -> $http.get "lookup/TypeOfStoppage"]
                frequenciesOfCollection : ['$http',($http) -> $http.get "lookup/FrequencyOfCollection"]
                financialYears : ['$http',($http) -> $http.get "lookup/FinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/FinancialPeriods"]
                )
      .when('/backToBasics/:id/:page', 
            templateUrl: (params) -> "content/views/backToBasics#{params.page}.html",  
            caseInsensitiveMatch: true
            controller: BackToBasicsController
            resolve:
                backToBasics : ['$http', '$route',($http, $route) -> if $route.current.params.id == "Create" then null else $http.get "api/backToBasics/#{$route.current.params.id}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                actionsAgainstFraud : ['$http',($http) -> $http.get "lookup/ActionsAgainstFraud"]
                causesOfProtest : ['$http',($http) -> $http.get "lookup/CauseOfProtest"]
                causesOfStoppage : ['$http',($http) -> $http.get "lookup/CauseOfStoppage"]
                typesOfStoppage : ['$http',($http) -> $http.get "lookup/TypeOfStoppage"]
                frequenciesOfCollection : ['$http',($http) -> $http.get "lookup/FrequencyOfCollection"]
                financialYears : ['$http',($http) -> $http.get "lookup/FinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/FinancialPeriods"]
                )
      .when('/operationalPlanOverview/:id', 
            templateUrl: 'content/views/operationalPlanOverview.html',  
            caseInsensitiveMatch: true
            controller: OperationalOverviewController
            resolve:
                operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/operationalPlan/#{$route.current.params.id}"]
                operationalActuals : ['$http', '$route',($http, $route) ->  $http.get "api/operationalActual/",params: theTargetId:$route.current.params.id ]
                documentTypes: ['$http',($http) -> $http.get "lookup/documentTypes"]
                operationalProjects : ['$http', '$route',($http, $route) ->  $http.get "api/operationalProject/",params: targetId:$route.current.params.id ]
                operationPlanDocumentsQ1: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId:$route.current.params.id ]
                operationPlanDocumentsQ2: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId1:$route.current.params.id ]
                operationPlanDocumentsQ3: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId2:$route.current.params.id ]
                operationPlanDocumentsQ4: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId3:$route.current.params.id ]
                )
      .when('/operationalPlanDocuments/:id', 
            templateUrl: 'content/views/mopDocumentValidation.html',  
            caseInsensitiveMatch: true
            controller: OperationalOverviewController
            resolve:
                operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/operationalPlan/#{$route.current.params.id}"]
                operationalActuals : ['$http', '$route',($http, $route) ->  $http.get "api/operationalActual/",params: theTargetId:$route.current.params.id ]
                documentTypes: ['$http',($http) -> $http.get "lookup/documentTypes"]
                operationalProjects : ['$http', '$route',($http, $route) ->  $http.get "api/operationalProject/",params: targetId:$route.current.params.id ]
                operationPlanDocumentsQ1: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId:$route.current.params.id ]
                operationPlanDocumentsQ2: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId1:$route.current.params.id ]
                operationPlanDocumentsQ3: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId2:$route.current.params.id ]
                operationPlanDocumentsQ4: ['$http', '$route',($http, $route) ->  $http.get "api/document/", params: targetId3:$route.current.params.id ]
                )
      .when('/operationalPlan', 
            templateUrl: 'content/views/operationalPlanList.html',  
            controller: OperationalPlanListController,
            resolve:
                operationalPlan: ['$http', '$route', ($http, $route) -> $http.get "api/operationalPlan"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
            )
      .when('/operationalPlan/Create', 
            templateUrl: "content/views/operationalPlan1.html",  
            caseInsensitiveMatch: true
            controller: OperationalPlanController
            resolve:
                operationalPlan : () -> null
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                )
      .when('/operationalPlan/:id/actuals', 
            templateUrl: 'content/views/operationalActualsList.html',  
            caseInsensitiveMatch: true
            controller: OperationalActualsListController
            resolve:
                operationalActuals : ['$http', '$route',($http, $route) ->  $http.get "api/operationalActual/",params: targetId:$route.current.params.id ]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
                operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetOperationalPlanDescription/#{$route.current.params.id}"]
                )
      .when('/operationalPlan/:targetId/actuals/Create', 
            templateUrl: "content/views/operationalActual1.html",  
            caseInsensitiveMatch: true
            controller: OperationalActualsController
            resolve:
                operationalActual : () -> null
                operationalActuals : ['$http', '$route',($http, $route) ->  $http.get "api/operationalActual/",params: theTargetId:$route.current.params.targetId ]
                operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/operationalPlan/#{$route.current.params.targetId}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
                documentTypes: ['$http',($http) -> $http.get "lookup/documentTypes"]
                operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetOperationalPlanDescription/#{$route.current.params.targetId}"]
                )
      .when('/operationalPlan/:id/:page', 
            templateUrl: (params) -> "content/views/operationalPlan#{params.page}.html",  
            caseInsensitiveMatch: true
            controller: OperationalPlanController
            resolve:
                operationalPlan : ['$http', '$route',($http, $route) -> if $route.current.params.id == "Create" then null else $http.get "api/operationalPlan/#{$route.current.params.id}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                )
      .when('/operationalPlan/:targetId/actuals/:id/:page', 
            templateUrl: (params) -> "content/views/operationalActual#{params.page}.html",  
            caseInsensitiveMatch: true
            controller: OperationalActualsController
            resolve:
                operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/operationalPlan/#{$route.current.params.targetId}"]
                operationalActual : ['$http', '$route',($http, $route) ->  $http.get "api/operationalActual/#{$route.current.params.id}" ]
                operationalActuals : ['$http', '$route',($http, $route) ->  $http.get "api/operationalActual/",params: theTargetId:$route.current.params.targetId ]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
                documentTypes: ['$http',($http) -> $http.get "lookup/documentTypes"]
                operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetOperationalPlanDescription/#{$route.current.params.targetId}"]
                )
      .when('/operationalPlans/:id/projects', 
            templateUrl: 'content/views/operationalProjectsList.html',  
            caseInsensitiveMatch: true
            controller: OperationalProjectsListController
            resolve:
                operationalProjects : ['$http', '$route',($http, $route) ->  $http.get "api/operationalProject/",params: targetId:$route.current.params.id ]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
                operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetOperationalPlanDescription/#{$route.current.params.id}"]
                )
      .when('/operationalPlan/:targetId/projects/Create', 
            templateUrl: "content/views/operationalProject.html",  
            caseInsensitiveMatch: true
            controller: OperationalProjectController
            resolve:
                operationalProject : () -> null
                operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/operationalPlan/#{$route.current.params.targetId}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
                mopSectors: ['$http',($http) -> $http.get "lookup/mopSectors"]
                mopProjectTypes: ['$http',($http) -> $http.get "lookup/mopProjectTypes"]
                mopProjectStages: ['$http',($http) -> $http.get "lookup/mopProjectStages"]
                fundingSources: ['$http',($http) -> $http.get "lookup/fundingSources"]
                fundingSourceGroups: ['$http',($http) -> $http.get "lookup/fundingSourceGroups"]
                mopkpis: ['$http',($http) -> $http.get "lookup/mopkpis"]
                operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetOperationalPlanDescription/#{$route.current.params.targetId}"]
                )
      .when('/operationalPlan/:targetId/projects/:id', 
            templateUrl: "content/views/operationalProject.html",  
            caseInsensitiveMatch: true
            controller: OperationalProjectController
            resolve:
                operationalProject : ['$http', '$route',($http, $route) ->  $http.get "api/operationalProject/#{$route.current.params.id}" ]
                operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/operationalPlan/#{$route.current.params.targetId}"]
                organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
                financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
                financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
                mopSectors: ['$http',($http) -> $http.get "lookup/mopSectors"]
                mopProjectTypes: ['$http',($http) -> $http.get "lookup/mopProjectTypes"]
                mopProjectStages: ['$http',($http) -> $http.get "lookup/mopProjectStages"]
                fundingSources: ['$http',($http) -> $http.get "lookup/fundingSources"]
                fundingSourceGroups: ['$http',($http) -> $http.get "lookup/fundingSourceGroups"]
                mopkpis: ['$http',($http) -> $http.get "lookup/mopkpis"]
                operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetOperationalPlanDescription/#{$route.current.params.targetId}"]
                )
      .when('/operations/plans', 
        templateUrl: 'content/views/mopii/operationsPlanList.html',
        caseInsensitiveMatch: true
        controller: MopiiPlanListController
        resolve: 
            organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
            financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
            plans: ['$http', ($http) -> $http.get "/api/mopii/plans"]            
            )
      .when('/operations/plans/create', 
        templateUrl: 'content/views/mopii/operationsPlanCreate.html',
        caseInsensitiveMatch: true
        controller: MopiiPlanCreateController
        resolve: 
            organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
            financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
            )
      .when('/operations/plan/:id', 
        templateUrl: 'content/views/mopii/operationsPlan.html',
        caseInsensitiveMatch: true
        controller: MopiiPlanController
        resolve: 
            plan : ['$http', '$route',($http, $route) -> $http.get "api/mopii/plan/#{$route.current.params.id}"]
            )
      .when('/operations/actuals/:id', 
        templateUrl: 'content/views/mopii/operationsActuals.html',
        caseInsensitiveMatch: true
        controller: MopiiActualsController
        resolve: 
            financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
            )
      .when('/operations/validation/:id', 
        templateUrl: 'content/views/mopii/validation.html',
        caseInsensitiveMatch: true
        controller: MopiiValidationController
        resolve: 
            plan : ['$http', '$route',($http, $route) -> $http.get "api/mopii/validation/#{$route.current.params.id}"]
            )
      .when('/operations/nationalvalidation/:id', 
        templateUrl: 'content/views/mopii/nationalvalidation.html',
        caseInsensitiveMatch: true
        controller: MopiiValidationController
        resolve: 
            plan : ['$http', '$route',($http, $route) -> $http.get "api/mopii/validation/#{$route.current.params.id}"]
            )
      .when('/operations/overview/:id', 
        templateUrl: 'content/views/mopii/operationsOverview.html',
        caseInsensitiveMatch: true
        controller: MopiiOverviewController
        resolve: 
            plan : ['$http', '$route',($http, $route) -> $http.get "api/mopii/actuals/#{$route.current.params.id}/1"]
            docs : ['$http', '$route',($http, $route) -> $http.get "api/mopii/validation/#{$route.current.params.id}"]
            mOPIIProjects : ['$http', '$route',($http, $route) ->  $http.get "api/mOPIIProject/",params: targetId:$route.current.params.id ]
            )
      .when('/operations/:id/projects', 
        templateUrl: 'content/views/mopiiProjectList.html',  
        caseInsensitiveMatch: true
        controller: MOPIIProjectsListController
        resolve:
            mOPIIProjects : ['$http', '$route',($http, $route) ->  $http.get "api/mOPIIProject/",params: targetId:$route.current.params.id ]
            organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
            financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
            financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
            operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetMOPIIPlanDescription/#{$route.current.params.id}"]
            )
      .when('/operations/:targetId/projects/Create', 
        templateUrl: "content/views/mopiiProject.html",  
        caseInsensitiveMatch: true
        controller: MOPIIProjectController
        resolve:
            mOPIIProject : () -> null
            operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/mopii/plan/#{$route.current.params.targetId}"]
            organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
            financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
            financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
            mopSectors: ['$http',($http) -> $http.get "lookup/mopSectors"]
            mopProjectTypes: ['$http',($http) -> $http.get "lookup/mopProjectTypes"]
            mopProjectStages: ['$http',($http) -> $http.get "lookup/mopProjectStages"]
            fundingSources: ['$http',($http) -> $http.get "lookup/fundingSources"]
            fundingSourceGroups: ['$http',($http) -> $http.get "lookup/fundingSourceGroups"]
            mopkpis: ['$http',($http) -> $http.get "lookup/mopkpis"]
            operationPlanDescription : ['$http','$route',($http,$route) -> $http.get "breadCrumb/GetMOPIIPlanDescription/#{$route.current.params.targetId}"]
            )            
      .when('/operations/:targetId/projects/:id', 
        templateUrl: "content/views/mopiiProject.html",  
        caseInsensitiveMatch: true
        controller: MOPIIProjectController
        resolve:
            mOPIIProject : ['$http', '$route',($http, $route) ->  $http.get "api/mOPIIProject/#{$route.current.params.id}" ]
            operationalPlan : ['$http', '$route',($http, $route) -> $http.get "api/mopii/plan/#{$route.current.params.targetId}"]
            organisations : ['$http',($http) -> $http.get "lookup/Organisations"]
            financialYears : ['$http',($http) -> $http.get "lookup/MisaFinancialYears"]
            financialPeriods : ['$http',($http) -> $http.get "lookup/MisaFinancialPeriods"]
            mopSectors: ['$http',($http) -> $http.get "lookup/mopSectors"]
            mopProjectTypes: ['$http',($http) -> $http.get "lookup/mopProjectTypes"]
            mopProjectStages: ['$http',($http) -> $http.get "lookup/mopProjectStages"]
            fundingSources: ['$http',($http) -> $http.get "lookup/fundingSources"]
            fundingSourceGroups: ['$http',($http) -> $http.get "lookup/fundingSourceGroups"]
            mopkpis: ['$http',($http) -> $http.get "lookup/mopkpis"]
            operationPlanDescription :['$http','$route',($http,$route) -> $http.get "breadCrumb/GetMOPIIPlanDescription/#{$route.current.params.targetId}"]
            )            
      .otherwise({redirectTo: '/'})

    $httpProvider.interceptors.push ['$q','notification','$rootScope','$window',($q,notification,$rootScope,$window)->
        request: (config)->
            $rootScope.busy = true
            config||$q.when(config)
        response: (response)->
            $rootScope.busy = false
            response||$q.when(response)
        responseError: (rejection)->
            if rejection.status == 500 then notification("There was a problem processing your request. If this problem persist, please contact your system administrator",1)
            if rejection.status == 400 then notification(rejection.data.message,1)
#            if rejection.status == 401 then $window.location.href = "/account/login"
            if rejection.status == 401 then notification("You do not have the required permissions to perform this task, please contact your system administrator",1)
            $rootScope.busy = false
            $q.reject(rejection)
        ]
]
if (typeof String::startsWith != 'function') 
    String::startsWith = (str) ->
        return this.slice(0, str.length) == str
          
app.run ['$rootScope', '$location', 'notification', 'operation', ($rootScope, $location,notification,operation) ->
    $rootScope.$on "$routeChangeSuccess", (event, route) ->
        if $location.$$path.startsWith "/project"
            $rootScope.page = "Projects"
        else if $location.$$path.startsWith "/infrastructure"
            $rootScope.page = "Register"
        else if $location.$$path.startsWith "/insights"
            $rootScope.page = "Insights"
        else if $location.$$path.startsWith "/administration"
            $rootScope.page = "Administration"
        else if $location.$$path.startsWith "/fault"
            $rootScope.page = "FaultReporting"
        else if $location.$$path.startsWith "/operationalPlan"
            $rootScope.page = "OperationalPlan"
        else if $location.$$path.startsWith "/MSDAT"
            $rootScope.page = "MSDAT"
        else if $location.$$path.startsWith "/backToBasics"
            $rootScope.page = "BackToBasics"
        else 
            $rootScope.page = "Home"

    hub = $.connection.faultReportingHub
    hub.client.fault = (x) ->
         sound = document.getElementById("alarm")
         sound.play()
         notification("<a href='/#/faultReport/#{x}'>A new fault has been reported</a>", false, true)
         $rootScope.$broadcast 'fault', x
    if operation('FaultAdmin')
        $.connection.hub.start()
]
            


# CoffeeScript
# CoffeeScript
Array::any=(predicate)->
    for item in this 
        if predicate(item) then return true
    false

Array::first=(predicate)->
    for item in this 
        if predicate(item) then return item
    null

Array::flatMap=(selector)->
    results = [] 
    for item in this.map(selector) 
        for x in item 
            results.push(x)
    results

Array::groupBy = (keySelector) ->
    y = this.reduce (xs, x) ->
        key = keySelector(x)
        if !(key of xs) then xs[key] = []
        xs[key].push(x)
        xs
    ,{}
    {key: key,value: value} for key,value of y

@count = (obj) ->
    Object.keys(obj).length

@finYearPeriod = (calendarYear,calendarMonth)->
    if calendarMonth <= 6 then finYear: calendarYear, finPeriod: calendarMonth + 6 else finYear: calendarYear + 1, finPeriod: calendarMonth - 6

