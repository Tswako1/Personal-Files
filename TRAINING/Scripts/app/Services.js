(function() {

  angular.module("mipmis").factory("notification", function() {
    toastr.options = {
      "closeButton": true,
      "debug": false,
      "positionClass": "toast-top-right",
      "onclick": null,
      "showDuration": "0",
      "hideDuration": "0",
      "timeOut": "0",
      "extendedTimeOut": "0",
      "showEasing": "swing",
      "hideEasing": "linear",
      "showMethod": "fadeIn",
      "hideMethod": "fadeOut"
    };
    return function(message, isError, isWarning) {
      if (isError) {
        toastr.options.timeOut = "0";
        return toastr.error(message);
      } else {
        if (isWarning) {
          toastr.options.timeOut = "0";
          return toastr.warning(message);
        } else {
          toastr.options.timeOut = "4000";
          return toastr.success(message);
        }
      }
    };
  });

}).call(this);
