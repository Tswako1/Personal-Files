@SiteVisitController = ['$scope', '$route','$http', 'notification', 'siteVisit', 'people', 'breadcrumb', '$routeParams', ($scope, $route, $http, notification, siteVisit, people, breadcrumb, $routeParams) ->
    $scope.siteVisit = siteVisit.data[0]
    $scope.people = people.data

    fn=()->if $scope.siteVisit.siteVisit.id then $http.put else $http.post
    
    $scope.saveSiteVisitSchedule =  ->
        if $scope.siteVisitScheduleForm.$valid 
            $scope.siteVisit.siteVisit.projectId =  $scope.siteVisit.projectId
            fn()("api/siteVisit/", $scope.siteVisit.siteVisit).then (response)->
                $scope.siteVisit.siteVisit = response.data
                $scope.siteVisit.id = response.data.id
                notification("Successfully saved")

    breadcrumb [
        {description: siteVisit.data[0].projectName, url: "/projectRegistration/#{siteVisit.data[0].projectId}"},
        {description: 'Activity Schedules', url: "/projectRegistration/#{siteVisit.data[0].projectId}/siteVisitList"},
        {description: $scope.siteVisit?.siteVisit?.description || "New Activity Schedule"}
    ]
]# CoffeeScript
