# CoffeeScript
@JobDescriptionController = ['$scope', '$http', '$routeParams', 'notification', 'jobDescription', 'breadcrumb', ($scope, $http, $routeParams, notification, jobDescription, breadcrumb) ->
    fn=()->if $scope.jobDescription.id then $http.put else $http.post
    $scope.saveJobDescription =  ->
        if $scope.jobDescriptionForm.$valid 
            fn()("api/jobDescription/", $scope.jobDescription).then((response) -> 
                $scope.jobDescription = response.data 
                notification("Successfully saved"))

    $scope.jobDescription = jobDescription?.data[0]||{}
   
    breadcrumb([
        { description: 'Job Description', url: "administration/jobDescriptionList" }
    ])



]
