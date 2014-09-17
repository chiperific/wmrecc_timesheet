# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  #if $.inArray("users", pathAry) >= 0
  $('#user-view-switch').click ->
    $('#inactive-users').toggleClass('hidden')
    if $(this).html() == "View inactive users"
      $(this).html("Hide inactive users")
    else
      $(this).html("View inactive users")
    event.preventDefault()
    false

  # user_form: show/hide salary or hourly field based upon paytype
  $('#user_pay_type').change ->
    $('#user_salary_div').toggleClass('hidden')
    $('#user_hourly_div').toggleClass('hidden')

  # self, supervisor and admin views
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

  # start and end date fields on show_form
  $('.date_field').datepicker
    todayBtn: "linked"
    todayHighlight: true

  $('#users-table').dataTable
    ordering: false
    columnDefs: [
      targets: [0, -1, -2], searchable: false, orderable: false
    ]

  $('#inactive-users-table').dataTable
    ordering: false
    columnDefs: [
      targets: [0, -1], searchable: false, orderable: false
    ]