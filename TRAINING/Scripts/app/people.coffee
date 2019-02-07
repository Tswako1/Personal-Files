@PeopleController = ['$scope', '$http', '$routeParams', 'notification', 'people', 'isUser', 'isAtLoadUser','provinces', 'districts', 'organisations', 'organisationHierarchy','roles', 'sectors','jobDescriptions', 'breadcrumb', ($scope, $http, $routeParams, notification, people, isUser,isAtLoadUser, provinces, districts, organisations, organisationHierarchy,roles,sectors,jobDescriptions, breadcrumb) ->
    fn=()->if $scope.people.id then $http.put else $http.post
    $scope.savePeople =  ->
        if $scope.peopleForm.$valid 
            fn()("api/people/", $scope.people).then((response) -> 
                $scope.people = response.data 
                notification("Successfully saved"))

    $scope.people = people?.data[0]||{userOrganisations: []}
    $scope.provinces = provinces.data
    $scope.jobDescriptions = jobDescriptions.data
    $scope.hierarchy = organisationHierarchy.data
    $scope.districts = districts.data 
    $scope.roles = roles.data 
    $scope.sectors = sectors.data 
    $scope.organisations = organisations.data
    $scope.isUser = if people?.data[0]?.userName then true else null
    $scope.isAtLoadUser = if people?.data[0]?.userName then true else null
   
    breadcrumb([
        { description: 'People', url: "administration/peopleList" }
    ])



]
