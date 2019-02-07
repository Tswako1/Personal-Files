@infrastructureFilters = {}

@InfrastructureRegisterListController = ['$scope','$http', '$modal','infrastructureRegisters','organisations', 'breadcrumb', 'deleteInfrastructure','assetClasses','notification',($scope, $http, $modal, infrastructureRegisters,organisations,breadcrumb,deleteInfrastructure,assetClasses,notification) ->
  $scope.deleteInfrastructure = value: deleteInfrastructure
  $scope.infrastructureRegisters = infrastructureRegisters.data.items
  $scope.page = 1
  $scope.pages = (i for i in [1..(Math.ceil(infrastructureRegisters.data.count / 10.0))])
  $scope.organisations = organisations.data
  $scope.assetClasses = assetClasses.data
  $scope.field = "Description"
  $scope.desc = false
  
  $scope.filters = infrastructureFilters

  $scope.deleteInfrastructureRegister = (infrastructureId,$index) -> 
            myModal = $modal.open
                templateUrl : "content/views/DeleteConfirmation.html"
                controller: ['$scope','$modalInstance', ($scope,$modalInstance) ->
                     $scope.modal = $modalInstance   
                ]
            myModal.result.then((result) ->  
                if result
                     $http.delete("api/infrastructureRegister/" + infrastructureId ).then (response)->
                        $scope.infrastructureRegisters.splice($index,1)
                        notification("Successfully Deleted")
                    )
  filter = (page)->
    $scope.serverFilter = $scope.filter 
    params = {}
    angular.copy $scope.filters, params
    $http.get("api/infrastructureRegister/", params: angular.extend(params, { filter:$scope.filter || "", page: page || 1, sort: $scope.field, desc: $scope.desc})).then (response)->
        $scope.page = page || 1
        $scope.pages = (i for i in [1..Math.max(1, Math.ceil(response.data.count / 10.0))])
        $scope.infrastructureRegisters = response.data.items

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
                
  if deleteInfrastructure
    breadcrumb [description: 'Delete Assets']
  else
    breadcrumb [description: 'Asset Register List']

]
