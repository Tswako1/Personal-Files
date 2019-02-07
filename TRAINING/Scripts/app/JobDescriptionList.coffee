@JobDescriptionListController = ['$scope','$http', 'jobDescriptions', 'breadcrumb', ($scope, $http, jobDescriptions,breadcrumb) ->
  $scope.jobDescriptions = jobDescriptions.data
  $scope.search = ()->
    $http.get("api/jobDescription/", params:filter:$scope.filter).then((response)->
        $scope.jobDescriptions = response.data
        )

  breadcrumb([
    { description: 'Job Descriptions'}
  ])

]
