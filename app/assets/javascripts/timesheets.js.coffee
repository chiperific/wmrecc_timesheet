# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#direct_report_chooser').click ->
    direct_report = $('#direct_report_select option:selected').val()
    if direct_report == ""
      $('#direct_report_error').toggleClass('hidden')
    else
      url = "/users/"+direct_report+"/timesheets/new"
      window.location.pathname = url
    event.preventDefault()
    false

  $('#direct_report_select').change ->
    $('#direct_report_error').addClass('hidden')

  $('#week_num_to_date').datepicker
    todayBtn: "linked"
    format: 'mm/dd'
    calendarWeeks: true
    weekStart: 1
    autoclose: true

  $('#week_num_to_date').change ->
    new_mm_dd = $(this).val()
    new_yy = $('#timesheet_year').val()
    new_date = new_mm_dd + "/" + new_yy
    $('#timesheet_week_num').val(new Date(new_date).getWeek())

  $('#timesheet_year').datepicker
    format: "yyyy"
    minViewMode: 2
    autoclose: true
