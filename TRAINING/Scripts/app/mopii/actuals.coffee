@MopiiActualsController = ['$scope', '$http', '$routeParams', 'notification', 'financialPeriods', 'breadcrumb', ($scope, $http, $routeParams, notification, financialPeriods, breadcrumb) ->
    $scope.save =  ->
        if $scope.planForm.$valid  
            $http.put("api/mopii/actuals/#{$scope.plan.id}/#{$scope.period}", $scope.plan).then (response) -> 
                notification("Successfully saved")
                $scope.plan = response.data
            

    $scope.$watch 'period', (value) ->
        if value
            $http.get("api/mopii/actuals/#{$routeParams.id}/#{value}")
                 .then (x) -> $scope.plan = x.data||{}

    $scope.periods = financialPeriods.data;

    breadcrumb([$
        { description: 'Operations', url: "operations/plans" }
    ])
]
