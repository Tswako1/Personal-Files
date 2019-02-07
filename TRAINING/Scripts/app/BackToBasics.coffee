@BackToBasicsController = ['$scope','$http', '$routeParams', '$location', 'operation', 'notification', 'backToBasics','organisations','financialYears','financialPeriods','causesOfProtest','causesOfStoppage','typesOfStoppage','actionsAgainstFraud','frequenciesOfCollection', 'breadcrumb', ($scope, $http, $routeParams, $location, operation, notification, backToBasics,organisations,financialYears,financialPeriods,causesOfProtest,causesOfStoppage,typesOfStoppage,actionsAgainstFraud,frequenciesOfCollection, breadcrumb) ->
    
    $scope.backToBasics = backToBasics?.data
    $scope.organisations = organisations.data
    $scope.financialYears = financialYears.data
    $scope.financialPeriods = financialPeriods.data
    $scope.causesOfProtest = causesOfProtest.data
    $scope.causesOfStoppage = causesOfStoppage.data
    $scope.typesOfStoppage = typesOfStoppage.data
    $scope.actionsAgainstFraud = actionsAgainstFraud.data
    $scope.frequenciesOfCollection = frequenciesOfCollection.data

    #$scope.isUpdate = (faultPriority != null)
    
    fn=()->if $scope.backToBasics.id then $http.put else $http.post
   
    $scope.saveBackToBasics =  ->
        if $scope.backToBasicsForm.$valid 
            if operation('CreateBackToBasics') 
                fn()("api/backToBasics/", $scope.backToBasics).then (response)->
                    $scope.backToBasics.id = response.data.id                
                    notification("Successfully saved")
                    $location.path "/backToBasics/#{if $routeParams.id then $routeParams.id else $scope.backToBasics.id}/#{if $routeParams.page then parseInt($routeParams.page) + 1 else 2}"
            else
                $location.path "/backToBasics/#{$routeParams.id}/#{parseInt($routeParams.page) + 1}"
            
      
    breadcrumb([
        { description: 'Back To Basics', url: '/backToBasics'},
        { description: 'Create'}
    ])
]# CoffeeScript
