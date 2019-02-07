(function() {

  this.ProjectCheckListController = [
    '$scope', '$http', '$routeParams', 'notification', 'documentTypes', 'project', 'breadcrumb', function($scope, $http, $routeParams, notification, documentTypes, project, breadcrumb) {
      $scope.saveProjectCheckList = function() {
        if ($scope.projectCheckListForm.$valid) {
          $http.put("api/projectCheckList/", $scope.project);
          return notification("Successfully saved");
        }
      };
      $scope.getDocumentCount = function(documentType) {
        var doc;
        doc = $scope.project.projectDocuments.filter(function(item) {
          return item.documentType === documentType;
        });
        if (doc.length) {
          return doc[0].count;
        } else {
          return 0;
        }
      };
      $scope.foreignId = $routeParams.id;
      $scope.documentTypes = documentTypes.data;
      $scope.project = project.data[0];
      return breadcrumb([
        {
          description: project.data[0].name,
          url: "/projectRegistration/" + project.data[0].id
        }, {
          description: 'Check List'
        }
      ]);
    }
  ];

}).call(this);
