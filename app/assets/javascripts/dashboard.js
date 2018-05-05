//= require core/jquery.min.js
//= require core/popper.min.js
//= require core/bootstrap.min.js
//= require rails-ujs
//= require froala_editor.pkgd.min.js
//= require_directory ../../../vendor/assets/javascripts/plugins
//= require cable
//= require messages_form
//= require now-ui/now-ui-dashboard
//= require_tree ./channels

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

$(function() {
    $('#editor').froalaEditor({toolbarButtons: ['fullscreen', 'bold', 'italic', 'underline', 'strikeThrough', 'subscript', 'superscript', '|', 'fontFamily', 'fontSize', 'color', 'inlineStyle', 'paragraphStyle', '|', 'paragraphFormat', 'align', 'formatOL', 'formatUL', 'outdent', 'indent', 'quote', '-', 'insertLink', 'insertImage', 'insertVideo', 'insertFile', 'insertTable', '|', 'emoticons', 'specialCharacters', 'insertHR', 'selectAll', 'clearFormatting', '|', 'print', 'help', 'html', '|', 'undo', 'redo'],
        pluginsEnabled: null})
});

createMessageChannel();
messageForm();