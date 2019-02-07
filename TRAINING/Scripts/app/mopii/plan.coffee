@MopiiPlanController = ['$scope', '$http', '$routeParams', 'notification', 'plan', 'breadcrumb', ($scope, $http, $routeParams, notification, plan, breadcrumb) ->
    $scope.save =  ->
        if $scope.planForm.$valid  
            $http.put("api/mopii/plan/#{$scope.plan.id}", $scope.plan).then((response) -> 
                notification("Successfully saved"))

    $scope.plan = plan?.data||{}
   
    breadcrumb([
        { description: 'Operations', url: "operations/plans" }
    ])
]
