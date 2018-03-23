//= require core/jquery.min.js
//= require core/popper.min.js
//= require core/bootstrap.min.js
//= require rails-ujs
//= require_directory ./plugins
//= require messages_form
//= require cable
//= require now-ui/now-ui-kit

notifications = {
    showNotification: function(from, align, color, message){

        $.notify({
            icon: "now-ui-icons ui-1_bell-53",
            message: message

        },{
            type: color,
            timer: 8000,
            placement: {
                from: from,
                align: align
            }
        });
    }
};