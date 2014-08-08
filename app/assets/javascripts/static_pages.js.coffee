# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  $('#msg-board-hider').click ->
    $('#message-board').slideToggle("fast")
    $('.fa-hideable').slideToggle("fast")
    $(this).toggleClass('unhide')
    event.preventDefault()
    false

  $('#admin-table').dataTable
    ordering: false
    paging: false