@MOPResponsiblePeopleController = ['$scope', '$http', '$routeParams', 'notification','organisations', 'mOPResponsiblePeople', 'breadcrumb', ($scope, $http, $routeParams, notification, organisations, mOPResponsiblePeople, breadcrumb) ->
    fn=()->if $scope.mOPResponsiblePeople.id then $http.put else $http.post
    $scope.saveMOPResponsiblePeople =  ->
        if $scope.mOPResponsiblePeopleForm.$valid 
            fn()("api/mOPResponsiblePeople/", $scope.mOPResponsiblePeople).then((response) -> 
                $scope.mOPResponsiblePeople = response.data 
                notification("Successfully saved"))

    $scope.mOPResponsiblePeople = mOPResponsiblePeople?.data[0]||{}
    $scope.organisations = organisations.data

    breadcrumb([
        { description: 'MOP Responsible People', url: "administration/mOPResponsiblePeopleList" }
    ])



]
# CoffeeScript
