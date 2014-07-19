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
