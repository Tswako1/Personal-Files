@mapController  = ['$scope', '$http', 'organisation', 'location', 'dialog', ($scope, $http, organisation, location, dialog) ->
    $scope.organisation = organisation.data
    $scope.location = location
    $scope.modal = dialog.modal
    
    $scope.OK = -> 
        dialog.modal.close(location)
]