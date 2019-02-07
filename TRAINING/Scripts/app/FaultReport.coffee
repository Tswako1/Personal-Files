@FaultReportController = ['$scope', '$http', '$modal', '$routeParams', 'notification','faultReport', 'breadcrumb', ($scope, $http, $modal, $routeParams, notification,faultReport, breadcrumb) ->
    fault = faultReport.data
    $scope.faultReport = faultReport.data
   
    $scope.add = () -> 
        $http.post('api/fault/comment', FaultReportId: faultReport.data.id, comment: $scope.comment).then (response) ->
            $scope.comment = ''
            $scope.faultReport = response.data
    action = (x) ->
        $http.post("api/fault/#{x}", FaultReportId: faultReport.data.id, comment: $scope.comment).then (response) ->
            if response.data == "null"
                notification 'No responsible person assigned to this organisation and sector', false, true
            else
                $scope.comment = ''
                $scope.faultReport = response.data
     

    $scope.confirm = () ->
        action 'confirm'
    $scope.reject = () ->
        action 'reject'
    $scope.close = () ->
        action 'close'

    $scope.duplicate = () ->
        modal = $modal.open
            templateUrl : "content/views/faultReportDuplicateAction.html"
            controller: ['$scope','$modalInstance', 'faults', ($scope,$modalInstance, faults) ->
                    $scope.selected = null
                    $scope.modal = $modalInstance   
                    $scope.faults = faults.data.items
                    $scope.select = (fault) ->
                        if $scope.selected then $scope.selected.selected = false
                        $scope.selected = fault                        
                        fault.selected = true
            ],
            resolve: 
                faults: ['$http', ($http) ->
                    $http.get 'api/faultReportInternal', params: status: 2, organisation: fault.organisationId, sectorProgram: fault.sectorProgramId
                ]
        modal.result.then (id) -> 
            if not id then return
            $http.post('api/fault/duplicate', FaultReportId: faultReport.data.id, comment: $scope.comment, DuplicateFaultId: id).then (response) ->
                $scope.comment = ''
                $scope.faultReport = response.data
              
    breadcrumb([])
]
