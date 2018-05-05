const messageForm = function () {
  let shiftDown = false;
  let chatForm = document.getElementById('new_message');
  // let messageBox = document.querySelector('.message-box');
  let messageBox = $('.message-box');
  $(document).keypress(function (e) {
    if(e.keyCode === 13) {
      if(messageBox.is(":focus") && !shiftDown) {
        e.preventDefault(); // prevent another \n from being entered
        chatForm.submit();
        $(chatForm).trigger('reset');
      }
    }
  });
  $(document).keydown(function (e) {
    if(e.keyCode === 16) shiftDown = true;
  });
  $(document).keyup(function (e) {
    if(e.keyCode === 16) shiftDown = false;
  });
};