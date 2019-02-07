(function() {

  this.HomeController = [
    '$scope', '$http', 'projects', 'tasks', 'infrastructures', 'breadcrumb', function($scope, $http, projects, tasks, infrastructures, breadcrumb) {
      var allTasks, compare, today;
      $scope.projects = projects != null ? projects.data.items : void 0;
      $scope.infrastructures = infrastructures != null ? infrastructures.data.items : void 0;
      allTasks = $scope.tasks = tasks.data;
      today = new Date();
      compare = function(d, d2) {
        var dt;
        dt = new Date(d2);
        return dt.getFullYear() === d.getFullYear() && dt.getMonth() === d.getMonth() && dt.getDate() === d.getDate();
      };
      $scope.getAppointments = function(d) {
        var xs;
        xs = allTasks.filter(function(x) {
          return compare(d, x.dueDate);
        });
        return (xs.length > 0 ? "appointment" : "") + " " + (today.getFullYear() === d.getFullYear() && today.getMonth() === d.getMonth() && today.getDate() === d.getDate() ? "today" : "") + " " + (d < today ? "overdue" : "");
      };
      $scope.showDay = function(d) {
        return $scope.tasks = allTasks.filter(function(x) {
          return compare(d, x.dueDate);
        });
      };
      $scope.monthChange = function(year, month, callback) {
        return $scope.$apply(function() {
          return $http.get('api/task', {
            params: {
              year: year,
              month: month + 1
            }
          }).then(function(response) {
            allTasks = $scope.tasks = response.data;
            return callback();
          });
        });
      };
      $scope.isDue = function(task) {
        return new Date(task.dueDate) < Date.now();
      };
      $scope.$parent.changePassword = function() {
        var change;
        change = $scope.change;
        if (change.newPassword !== change.confirmPassword) {
          change.message = "New passwords does not match";
          return;
        }
        return $http.post('api/password', {
          oldPassword: change.oldPassword,
          newPassword: change.newPassword
        }).then(function(response) {
          if (response.data !== "null") {
            return $scope.change.message = response.data;
          } else {
            return $scope.change.visible = false;
          }
        });
      };
      return breadcrumb([]);
    }
  ];

}).call(this);
