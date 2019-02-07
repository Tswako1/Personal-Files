# CoffeeScript
@ActionsTakenAgainstFraudListController = ['$scope','$http', 'actionsTakenAgainstFraud', 'breadcrumb', ($scope, $http, actionsTakenAgainstFraud,breadcrumb) ->
  $scope.actionsTakenAgainstFraud = actionsTakenAgainstFraud.data
  $scope.search = ()->
    $http.get("api/actionsTakenAgainstFraud/", params:filter:$scope.filter).then((response)->
        $scope.faultPriorities = response.data
        )

  breadcrumb([
    { description: 'Actions Taken Against Fraud'}
  ])

]
# CoffeeScript
