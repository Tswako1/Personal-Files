@MopiiPlanListController = ['$scope', '$http', '$routeParams', 'notification', 'organisations', 'financialYears', 'plans', 'breadcrumb', ($scope, $http, $routeParams, notification, organisations, financialYears, plans, breadcrumb) ->
    $scope.organisations = organisations.data
    $scope.financialYears = financialYears.data
    $scope.operationalPlans = items: plans.data||[]
   
    breadcrumb([
        { description: 'Operations', url: "operations/plans" }
    ])
]
