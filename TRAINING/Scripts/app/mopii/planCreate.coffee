@MopiiPlanCreateController = ['$scope', '$http', '$routeParams', '$location', 'notification', 'organisations', 'financialYears', 'breadcrumb', ($scope, $http, $routeParams, $location, notification, organisations, financialYears, breadcrumb) ->
    $scope.organisations = organisations.data
    $scope.financialYears = financialYears.data
    $scope.create = ->
        if !$scope.misaFinancialYearId or !$scope.organisationId
            notification "Select organisation and financial year"
            return

        $http.post( '/api/mopii/plans', {organisationId: $scope.organisationId, misaFinancialYearId: $scope.misaFinancialYearId})
             .then (x) -> $location.path "/operations/plan/#{x.data.id}" 
   
    breadcrumb([
        { description: 'Operations', url: "operations/plans" }
    ])
]
