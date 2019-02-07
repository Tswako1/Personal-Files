@AssetClassController = ['$scope', '$http', '$routeParams', 'notification', 'assetClass', 'breadcrumb', ($scope, $http, $routeParams, notification, assetClass, breadcrumb) ->
    fn=()->if $scope.assetClass.id then $http.put else $http.post
    $scope.saveAssetClass =  ->
        if $scope.assetClassForm.$valid  
            fn()("api/assetClass/", $scope.assetClass).then((response) -> 
                $scope.assetClass = response.data 
                notification("Successfully saved"))

    $scope.assetClass = assetClass?.data[0]||{}
   
    breadcrumb([
        { description: 'Asset Classes', url: "administration/assetClassList" }
    ])
]
