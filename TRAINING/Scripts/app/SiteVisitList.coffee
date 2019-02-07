# CoffeeScript
@SiteVisitListController = ['$scope', '$http', '$routeParams', 'siteVisits','projectDescription', 'breadcrumb', ($scope, $http, $routeParams, siteVisits,projectDescription, breadcrumb) ->
    $scope.projectId = $routeParams.id
    $scope.siteVisits = siteVisits.data
    $scope.projectDescription = projectDescription.data

    breadcrumb [
        {description: projectDescription.data.name, url: "/projectRegistration/#{$routeParams.id}"},
        {description: 'Activity Schedules'}
    ]
]
# CoffeeScript
