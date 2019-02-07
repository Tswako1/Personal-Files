@FrequencyOfCollectionController = ['$scope', '$http', '$routeParams', 'notification', 'frequencyOfCollection', 'breadcrumb', ($scope, $http, $routeParams, notification, frequencyOfCollection, breadcrumb) ->
    fn=()->if $scope.frequencyOfCollection.id then $http.put else $http.post
    $scope.saveFrequencyOfCollection =  ->
        if $scope.frequencyOfCollectionForm.$valid 
            fn()("api/frequencyOfCollection/", $scope.frequencyOfCollection).then((response) -> 
                $scope.frequencyOfCollection = response.data 
                notification("Successfully saved"))

    $scope.frequencyOfCollection = frequencyOfCollection?.data[0]||{}
   
    breadcrumb([
        { description: 'Frequency Of Collection', url: "administration/frequencyOfCollectionList" }
    ])



]
