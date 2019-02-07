angular.module("mipmis").factory "notification", ->
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
    }
    (message,isError,isWarning) ->
        if isError
            toastr.options.timeOut = "0"
            toastr.error message        
        else
            if(isWarning)
                toastr.options.timeOut = "0"
                toastr.warning message        
            else
                toastr.options.timeOut = "4000"
                toastr.success message        
