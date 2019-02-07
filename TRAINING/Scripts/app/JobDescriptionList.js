(function() {

  this.JobDescriptionListController = [
    '$scope', '$http', 'jobDescriptions', 'breadcrumb', function($scope, $http, jobDescriptions, breadcrumb) {
      $scope.jobDescriptions = jobDescriptions.data;
      $scope.search = function() {
        return $http.get("api/jobDescription/", {
          params: {
            filter: $scope.filter
          }
        }).then(function(response) {
          return $scope.jobDescriptions = response.data;
        });
      };
      return breadcrumb([
        {
          description: 'Job Descriptions'
        }
      ]);
    }
  ];

}).call(this);
