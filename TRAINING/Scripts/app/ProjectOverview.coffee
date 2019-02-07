# CoffeeScript
@ProjectOverviewController = ['$scope', '$http', '$routeParams','project', 'financials', 'breadcrumb', 'activities', 'risks', 'issues', 'siteVisits', 'indicators', ($scope, $http, $routeParams, project, financials, breadcrumb, activities, risks, issues, siteVisits, indicators) ->
  $scope.projectId = $routeParams.id
  $scope.project = project.data[0]
  $scope.financials = financials.data[0]
  $scope.risks = risks.data.risks
  $scope.issues = issues.data.issues
  $scope.siteVisits = siteVisits.data
  $scope.indicators = indicators.data
  $scope.autoproject = if project?.data[0]
    "PR-" + project?.data[0].sectorCode + "-" + project?.data[0].autoNumber   

  
  pa = activities.data[0]
  xs = [
    {name: "Establish Steering Comittee", start: new Date(pa.activityEstablishSteeringCommitteeStartDate), end: new Date(pa.activityEstablishSteeringCommitteeEndDate), completed: new Date(pa.activityEstablishSteeringCommitteeCompleteDate)},
    {name: "Design", start: new Date(pa.activityDesignStartDate), end: new Date(pa.activityDesignEndDate), completed: new Date(pa.activityDesignCompleteDate)},
    {name: "Tender", start: new Date(pa.activityTenderStartDate), end: new Date(pa.activityTenderEndDate), completed: new Date(pa.activityTenderCompleteDate)},
    {name: "Construction", start: new Date(pa.activityConstructionStartDate), end: new Date(pa.activityConstructionEndDate), completed: new Date(pa.activityConstructionCompleteDate)},
    {name: "Completion", start: new Date(pa.activityCompletionStartDate), end: new Date(pa.activityCompletionEndDate), completed: new Date(pa.activityCompletionCompleteDate)}
  ]
  min = (xs.reduce (a,b) -> if a.start < b.start then start: a.start else start: b.start).start
  max = (xs.reduce (a,b) -> if a.end > b.end then end: a.end else end: b.end).end
  len = max - min

  $scope.activities = xs.map (x) ->  
    name: x.name
    start: (x.start - min) / len * 100
    len: (x.end - x.start) / len * 100
    done: (x.completed - min) / len * 100

  $scope.activities.min = new Date(min).getFullYear() + "/" + (new Date(min).getMonth() + 1)
  $scope.activities.max = new Date(max).getFullYear() + "/" + (new Date(max).getMonth() + 1)
  


  breadcrumb [description: project.data[0].name]

]
# CoffeeScript
