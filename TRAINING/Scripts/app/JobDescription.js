(function() {

  this.JobDescriptionController = [
    '$scope', '$http', '$routeParams', 'notification', 'jobDescription', 'breadcrumb', function($scope, $http, $routeParams, notification, jobDescription, breadcrumb) {
      var fn;
      fn = function() {
        if ($scope.jobDescription.id) {
          return $http.put;
        } else {
          return $http.post;
        }
      };
      $scope.saveJobDescription = function() {
        if ($scope.jobDescriptionForm.$valid) {
          return fn()("api/jobDescription/", $scope.jobDescription).then(function(response) {
            $scope.jobDescription = response.data;
            return notification("Successfully saved");
          });
        }
      };
      $scope.jobDescription = (jobDescription != null ? jobDescription.data[0] : void 0) || {};
      return breadcrumb([
        {
          description: 'Job Description',
          url: "administration/jobDescriptionList"
        }
      ]);
    }
  ];

}).call(this);
