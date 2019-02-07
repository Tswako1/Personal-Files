@ProjectActivitiesController = ['$scope', '$http', '$routeParams','notification', 'project', 'breadcrumb', ($scope, $http, $routeParams, notification, project, breadcrumb) ->
    $scope.saveProjectActivities =  ->
        if $scope.projectActivitiesForm.$valid 
                $http.put("api/projectActivities/", $scope.project)
                notification("Successfully saved")

    $scope.project = project.data[0]

    start = Date.parse($scope.project.startDate) 
    end = Date.parse($scope.project.endDate) 
    now = new Date();
    
    validate = (startName, endName, completeName) ->
        double = false
        validateStart = (x) ->
            date = Date.parse(x)
            valid = !x || (date >= start && date <= end)
            $scope.projectActivitiesForm[startName].$setValidity "min", valid
            if !$scope.project[endName] || double  then return
            to = Date.parse($scope.project[endName])
            $scope.projectActivitiesForm[startName].$setValidity "min", valid && date <= to
            double = true
            validateEnd $scope.project[endName]
            double = false
        validateEnd = (x) ->
            date = Date.parse(x)
            valid = !x || (date >= start && date <= end)
            $scope.projectActivitiesForm[endName].$setValidity "min", valid
            if !$scope.project[startName] || double then return
            from = Date.parse($scope.project[startName])
            $scope.projectActivitiesForm[endName].$setValidity "min", valid && date >= from
            double = true
            validateStart $scope.project[startName]
            double = false
    
        $scope.$watch 'project.' + startName, validateStart
        $scope.$watch 'project.' + endName, validateEnd
        $scope.$watch 'project.' + completeName, (x) ->
            date = Date.parse(x)
            $scope.projectActivitiesForm[completeName].$setValidity "min", !x || date <= now
        
    validate 'activityEstablishSteeringCommitteeStartDate', 'activityEstablishSteeringCommitteeEndDate', 'activityEstablishSteeringCommitteeCompleteDate'
    validate 'activityDesignStartDate', 'activityDesignEndDate', 'activityDesignCompleteDate'
    validate 'activityTenderStartDate', 'activityTenderEndDate', 'activityTenderCompleteDate'
    validate 'activityConstructionStartDate', 'activityConstructionEndDate', 'activityConstructionCompleteDate'
    validate 'activityCompletionStartDate', 'activityCompletionEndDate', 'activityCompletionCompleteDate'
                    
    breadcrumb [
        {description: project.data[0].name, url: "/projectRegistration/#{project.data[0].id}"},
        {description: 'Project Gantt Chart'}
    ]

]
# CoffeeScript
