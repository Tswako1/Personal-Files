@FaultReportListController = ['$scope','$http', 'faultReports', 'faultReportStatus', 'organisations', 'sectorProgrammes', 'breadcrumb', '$timeout', ($scope, $http, faultReports, faultReportStatus, organisations, sectorProgrammes,breadcrumb,$timeout) ->
  $scope.faultReports = faultReports.data

  $scope.page = 1
  $scope.faultReportStatus = faultReportStatus.data
  $scope.organisations = organisations.data
  $scope.sectorProgrammes = sectorProgrammes.data  

  filter = (page)->
    $scope.serverFilter = $scope.filter
    params = {}
    angular.copy $scope.filters, params
    $http.get("api/faultReportInternal", params: angular.extend(params, { filter:$scope.filter || "", page: page || 1, sort: $scope.field, desc: $scope.desc})).then (response)->
        $scope.page = page || 1
        $scope.pages = (i for i in [1..Math.max(1, Math.ceil(response.data.count / 10.0))])
        $scope.faultReports = response.data

  $scope.search = ()->
    filter()

  $scope.gotoPage = (x) ->
    if x < 1 || x > ($scope.pages.length) then return
    $scope.page = x
    filter(x)

  $scope.filters = status: null
  $scope.$watch 'filters', (value) -> 
        if(value) then filter()
    , true

  $scope.$on 'fault', (e, x) ->
    $scope.$apply () -> filter($scope.page)

  timer = null

  refresh = () -> 
    filter($scope.page)
    timer = $timeout refresh, 60000
    
  timer = $timeout refresh, 60000

  $scope.$on '$destroy', () -> timer.cancel()

  breadcrumb([
    { description: 'Incident Reporting'}
  ])

]
# CoffeeScript
