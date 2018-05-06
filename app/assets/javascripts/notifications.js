document.addEventListener('DOMContentLoaded', getNotifications);

function getNotifications() {
  let notificationLink = document.querySelector('.notifications-link');
  let notificationDropdown = document.querySelector('.notifications-dropdown');
  let notificationNumberSpan = document.querySelector('.unread-count');
  let notificationItem;
  $.get('/notifications', function (res) {

    let notifications = res;
    if(notifications.length > 0){
      notificationLink.addEventListener('click', markAsSeen);
      notificationNumberSpan.textContent = notifications.length
      notifications.forEach(function (notification) {
        // fill dropdown with these notifications
        notificationItem = document.createElement('a');
        notificationItem.className = 'dropdown-item';
        notificationItem.href = 'someurl';
        notificationItem.textContent = 'xxxx';
        notificationDropdown.appendChild(notificationItem);
      });
    } else {
      notificationItem = document.createElement('a');
      notificationItem.className = 'dropdown-item';
      notificationItem.textContent = 'You have no new notifications.';
      notificationDropdown.appendChild(notificationItem);
    }
  });
}

function markAsSeen(ev) {
  let data = {};
  $.post('/notifications/mark_as_read', data, function () {});
  ev.preventDefault();
}