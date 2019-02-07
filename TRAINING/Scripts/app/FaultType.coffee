@FaultTypeController = ['$scope','$http', 'notification', 'faultType','sectors', 'priorities', 'breadcrumb', ($scope, $http, notification, faultType,sectors, priorities, breadcrumb) ->
    $scope.faultType = faultType?.data[0]
    $scope.sectors = sectors.data
    $scope.priorities = priorities.data
    $scope.isUpdate = (faultType != null)
    
    fn=()->if $scope.faultType.id then $http.put else $http.post
   
    $scope.save =  ->
        if $scope.faultTypeForm.$valid 
            fn()("api/FaultType/", $scope.faultType).then (response)->
                $scope.faultType.id = response.data.id
                notification("Successfully saved")

      
    breadcrumb([
        { description: 'Fault Types', url: '/administration/faultTypeList'},
        { description: 'Create'}
    ])
]# CoffeeScript
