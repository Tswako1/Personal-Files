@InsightController = ['$scope','$http', 'insights', 'breadcrumb', ($scope, $http, insights,breadcrumb) ->
  $scope.projectInsights = insights.data.filter((x)->x.module ==2)
  $scope.infrastructureInsights = insights.data.filter((x)->x.module ==1)
        
  breadcrumb []
]
# CoffeeScript
