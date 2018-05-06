class Notifications
  constructor: ->
    @notifications = $(".notifications")
    @setup() if @notifications.length > 0

  setup: ->
    $(".notifications-link").on 'click', @handleClick
    $.ajax(
      url: '/notifications.json',
      dataType: 'JSON',
      method: 'GET',
      success: @handleSuccess
    )
    
    handleClick: (e) =>
      $.ajax(
        url: '/notifications/mark_as_read',
        method: 'PUT',
        dataType: 'JSON'
        success: ->

      )

    handleSuccess: (data) =>
      console.log(data)
      items = $.map data, (notification) ->
       "<a class= 'dropdown-item' href=#{notification.url}>#{notification.actor}#{notification.action}#{notification.subject_type}</a>"

      $(".unread-count").text(items.length)
      $(".notification-dropdown").html(items)

jQuery ->
  new Notifications