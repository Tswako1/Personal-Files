@FaultPriorityController = ['$scope','$http', 'notification', 'faultPriority','faultEscalationTimes', 'breadcrumb', ($scope, $http, notification, faultPriority, faultEscalationTimes, breadcrumb) ->
    $scope.faultPriority = faultPriority?.data[0]
    $scope.faultEscalationTimes = faultEscalationTimes.data
    $scope.isUpdate = (faultPriority != null)
    
    fn=()->if $scope.faultPriority.id then $http.put else $http.post
   
    $scope.save =  ->
        if $scope.faultPriorityForm.$valid 
            fn()("api/faultPriority/", $scope.faultPriority).then (response)->
                $scope.faultPriority.id = response.data.id
                notification("Successfully saved")

      
    breadcrumb([
        { description: 'Fault Priorities', url: '/administration/faultPriorityList'},
        { description: 'Create'}
    ])
]# CoffeeScript
