@MopiiOverviewController = ['$scope', '$http', '$routeParams', 'notification', 'plan', 'docs', 'mOPIIProjects','breadcrumb', ($scope, $http, $routeParams, notification, plan, docs, mOPIIProjects,breadcrumb) ->

    $scope.plan = plan?.data||{}
    $scope.docs = docs?.data||{}
    $scope.mOPIIProjects = mOPIIProjects?.data||{}
   
    breadcrumb([
        { description: 'Operations', url: "operations/plans" }
    ])
]
