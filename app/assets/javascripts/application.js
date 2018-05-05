//= require core/jquery.min.js
//= require core/popper.min.js
//= require core/bootstrap.min.js
//= require rails-ujs
//= require_directory ../../../vendor/assets/javascripts/plugins
//= require now-ui/now-ui-kit

const notifications = {
    showNotification: function(from, align, color, message){

        $.notify({
            icon: "now-ui-icons ui-1_bell-53",
            message: message

        },{
            type: color,
            timer: 3000,
            placement: {
                from: from,
                align: align
            }
        });
    }
};