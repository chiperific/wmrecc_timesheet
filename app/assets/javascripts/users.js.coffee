# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#user-view-switch').click ->
    $('#inactive-users').toggleClass('hidden')
    if $(this).html() == "View inactive users"
      $(this).html("Hide inactive users")
    else
      $(this).html("View inactive users")
    event.preventDefault()

  $('.super-view-switch').click ->
    closed = "fa fa-caret-right"
    open = "fa fa-caret-down"
    list_id = $(this).attr('id')
    $('#active-users').find('.'+list_id).children('td').toggleClass('hidden')
    if $(this).children('i').attr('class') == closed
      $(this).children('i').removeClass(closed)
      $(this).children('i').addClass(open)
    else
      $(this).children('i').removeClass(open)
      $(this).children('i').addClass(closed)
    event.preventDefault()
    false