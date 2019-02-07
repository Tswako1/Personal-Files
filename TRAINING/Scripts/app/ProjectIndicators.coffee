@ProjectIndicatorsController = ['$scope', '$http', '$routeParams','notification', 'indicators', 'project', 'breadcrumb', ($scope, $http, $routeParams, notification, indicators, project, breadcrumb) ->
    $scope.indicators = indicators.data
    $scope.project = project.data
    
    breadcrumb [
        {description: project.data.name, url: "/projectRegistration/#{project.data.id}"},
        {description: 'Indicators'}
    ]

]

@ProjectIndicatorsCreateController = ['$scope', '$http', '$routeParams','notification', 'indicators', 'project', 'breadcrumb', ($scope, $http, $routeParams, notification, indicators, project, breadcrumb) ->
    $scope.indicators = indicators.data
    $scope.project = project.data
    
    $scope.save = -> 
        $http.post('api/ProjectIndicators', projectId: project.data.id, indicatorId: $scope.selected.id, start: $scope.selected.start, end: $scope.selected.end).then ->
            notification("Successfully saved")
            $scope.saved = true
    
    
    start = Date.parse(project.data.startDate) 
    end = Date.parse(project.data.endDate) 
    $scope.$watch 'selected.id', (x) ->
        if !$scope.selected  then return
        if !$scope.selected.start then $scope.selected.start = project.data.startDate
        if !$scope.selected.end then $scope.selected.end = project.data.endDate
   
    $scope.$watch 'selected.start', (x) ->
        date = Date.parse(x)
        valid = !x || (date >= start - 7200000 && date <= end)
        $scope.siteVisitScheduleForm.start.$setValidity "min", valid 
        if !$scope.selected || !$scope.selected.end then return
        to = Date.parse($scope.selected.end)
        $scope.siteVisitScheduleForm.start.$setValidity "min", valid && to >= date
    $scope.$watch 'selected.end', (x) ->
        date = Date.parse(x)
        valid = !x || (date >= start + 7200000 && date <= end)
        $scope.siteVisitScheduleForm.end.$setValidity "min",  valid
        if !$scope.selected || !$scope.selected.start then return
        from = Date.parse($scope.selected.start)
        $scope.siteVisitScheduleForm.end.$setValidity "min", valid && date >= from
    
    breadcrumb [
        {description: project.data.name, url: "/projectRegistration/#{project.data.id}"},
        {description: 'Indicators', url: "/projectRegistration/#{project.data.id}/indicators"},
        {description: 'Create'}
    ]
]


@ProjectIndicatorValuesController = ['$scope', '$http', '$routeParams','notification', 'indicator', 'project', 'breadcrumb', ($scope, $http, $routeParams, notification, indicator, project, breadcrumb) ->
    $scope.project = project.data
    
    $scope.values = indicator.data.values.groupBy (x) -> x.financialYear
                
    $scope.save = -> 
        $http.put('api/ProjectIndicators', indicatorId: $routeParams.indicatorId, values: indicator.data).then ->
            notification("Successfully saved")
    
    $scope.isInFuture = (financialYear, financialPeriod) ->
        now = new Date()
        dt = if financialPeriod < 7 then new Date(financialYear - 1, financialPeriod + 5, 1) else new Date(financialYear, financialPeriod - 6, 1)
        dt.setMonth(dt.getMonth() + 1)        
        dt >= now 
    
    breadcrumb [
        {description: project.data.name, url: "/projectRegistration/#{project.data.id}"},
        {description: 'Indicators', url: "/projectRegistration/#{project.data.id}/indicators"},
        {description: indicator.data.description}
    ]

]
