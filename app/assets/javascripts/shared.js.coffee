# scripts shared across different paths.

jQuery ->
  # Universal datepicker for any weekday
  $('.open_date_picker').datepicker
    todayBtn: "linked"
    format: 'mm/dd/yyyy'
    calendarWeeks: true
    weekStart: 1
    autoclose: true
    todayHighlight: true

  # Universal datepicker for Mondays
  $('.start_date_picker').datepicker
    daysOfWeekDisabled: "0,2,3,4,5,6"
    todayBtn: "linked"
    format: 'mm/dd/yyyy'
    calendarWeeks: true
    weekStart: 1
    autoclose: true
    todayHighlight: true

  # Universal datepicker for Sundays
  $('.end_date_picker').datepicker
    daysOfWeekDisabled: "1,2,3,4,5,6"
    todayBtn: "linked"
    format: 'mm/dd/yyyy'
    calendarWeeks: true
    weekStart: 1
    autoclose: true
    todayHighlight: true

  # when clicking the input-group-addon before the input, move the focus to the input to open the datePicker
  $('.input-group-addon').click ->
    $(this).next("input").focus()

  
    