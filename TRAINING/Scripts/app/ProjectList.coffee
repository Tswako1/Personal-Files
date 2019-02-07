@projectFilters = {}

@ProjectListController = ['$scope','$http', '$modal', 'projects','organisations', 'projectStatus', 'sectorProgrammes','fundingSources', 'breadcrumb','notification', 'deleteProject', ($scope, $http, $modal, projects, organisations, projectStatus, sectorProgrammes,fundingSources,breadcrumb,notification, deleteProject) ->
  $scope.deleteProject = value: deleteProject
  $scope.projects = projects.data.items
  $scope.organisations = organisations.data
  $scope.projectStatus = projectStatus.data
  $scope.sectorProgrammes = sectorProgrammes.data
  $scope.fundingSources = fundingSources.data
  $scope.page = 1
  $scope.pages = (i for i in [1..(Math.ceil(projects.data.count / 10.0))])

  $scope.filters = projectFilters

  $scope.deleteProjectRegistration = (projectId,$index) -> 
            myModal = $modal.open
                templateUrl : "content/views/DeleteConfirmation.html"
                controller: ['$scope','$modalInstance', ($scope,$modalInstance) ->
                     $scope.modal = $modalInstance  
                ]
            myModal.result.then((result) ->  
                if result
                     $http.delete("api/project/" + projectId ).then (response)->
                        $scope.projects.splice($index,1)
                        notification("Successfully Deleted")
                    )

  filter = (page)->
    $scope.serverFilter = $scope.filter
    params = {}
    angular.copy $scope.filters, params
    $http.get("api/project/", params: angular.extend(params, { filter:$scope.filter || "", page: page || 1, sort: $scope.field, desc: $scope.desc})).then (response)->
        $scope.page = page || 1
        $scope.pages = (i for i in [1..Math.max(1, Math.ceil(response.data.count / 10.0))])
        $scope.projects = response.data.items

  $scope.sort = (field) ->
    if($scope.field == field)
        $scope.desc = !$scope.desc
    else 
        $scope.desc = false
        $scope.field = field
    filter()
  
  $scope.search = filter
  $scope.clearSearch = () ->
    $scope.filter = null
    filter()
  
  $scope.$watch 'filters', (value) -> 
        if(value) then filter()
    , true
  
  $scope.gotoPage = (x) ->
    if x < 1 || x > ($scope.pages.length) then return
    $scope.page = x
    filter x
  
  if deleteProject
    breadcrumb [description: 'Delete Projects']
  else
    breadcrumb [description: 'Project List']
]
# CoffeeScript
