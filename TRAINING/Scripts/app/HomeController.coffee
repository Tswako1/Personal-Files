@HomeController = ['$scope', '$http', 'projects', 'tasks', 'infrastructures', 'breadcrumb', ($scope, $http, projects, tasks, infrastructures, breadcrumb) ->
    $scope.projects = projects?.data.items
    $scope.infrastructures = infrastructures?.data.items
    allTasks = $scope.tasks = tasks.data
    
    today = new Date()
    compare = (d, d2) ->
        dt = new Date(d2)
        dt.getFullYear() == d.getFullYear() && dt.getMonth() == d.getMonth() && dt.getDate() == d.getDate()
    
    $scope.getAppointments = (d) ->
        xs = allTasks.filter (x) -> compare(d, x.dueDate)
        (if xs.length > 0 then "appointment" else "") + " " + (if today.getFullYear() == d.getFullYear() && today.getMonth() == d.getMonth() && today.getDate() == d.getDate() then "today" else "") + " " + (if d < today then "overdue" else "")
    $scope.showDay = (d) ->
        $scope.tasks = allTasks.filter (x) -> compare(d, x.dueDate)
    $scope.monthChange = (year, month, callback) ->
        $scope.$apply ->
            $http.get('api/task', {params: year: year, month: month + 1}).then (response) -> 
                allTasks = $scope.tasks = response.data
                callback()
    $scope.isDue = (task) -> new Date(task.dueDate) < Date.now()
        
    $scope.$parent.changePassword = () ->
        change = $scope.change
        if change.newPassword != change.confirmPassword
            change.message = "New passwords does not match"
            return
        $http.post('api/password', oldPassword:change.oldPassword, newPassword:change.newPassword).then (response) -> 
            if response.data  != "null"
                $scope.change.message = response.data
            else
                $scope.change.visible = false
    
    breadcrumb []
]