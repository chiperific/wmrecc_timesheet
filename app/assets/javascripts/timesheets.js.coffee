#returns today's YYYY/MM/DD for reviewed and approved hidden fields
rubyReadyDate = ->
  n = new Date()
  y = n.getFullYear()
  m = n.getMonth()+1
  d = n.getDate()
  y + '/' + m + '/' + d

calculateTotal = (input, ttl_field) ->
  sum = 0
  $(input).each ->
    if !isNaN(this.value) && this.value.length != 0
      sum += parseFloat this.value
    $(ttl_field).html(sum)

# handle the 4 date fields on the _timesheet_form partial
dateSetter = -> 
  startDateString = $("#form_start_date").val()
  startDate = new Date(startDateString)
  endDate = new Date(startDate)
  endDate.setDate(startDate.getDate()+6)

  startYear = startDate.getFullYear()
  startMonth = ('0'+(startDate.getMonth()+1)).slice(-2)
  startDay = ('0'+ startDate.getDate()).slice(-2)
  startRubyString = startYear+"/"+startMonth+"/"+startDay

  endYear = endDate.getFullYear()
  endMonth = ('0'+(endDate.getMonth()+1)).slice(-2)
  endDay = ('0'+ endDate.getDate()).slice(-2)
  endHumanString = endMonth+"/"+endDay+"/"+endYear
  endRubyString = endYear+"/"+endMonth+"/"+endDay

  $("#form_end_date").val(endHumanString)
  $("#ruby_end_date").val(endRubyString)
  $("#ruby_start_date").val(startRubyString)

  if startDate.getDay() != 1
    $('#date_warning').removeClass('hidden')
  else
    $('#date_warning').addClass('hidden')

# Since JS doesn't know string names for days...
weekday_name = (n) ->
  day_name = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
  day_name[n]

#adds the holidays between the date range as a "heads up"
holiday_date_filter = (holiday) ->
  string_date = holiday["date"]
  string_date_w_time = string_date+" 12:00:00"
  holiday_date = new Date(string_date_w_time)
  formatted_date = weekday_name(holiday_date.getDay())+", "+(holiday_date.getMonth()+1)+"/"+(holiday_date.getDate())
  list_item = "<li>"+holiday["name"]+" is "+formatted_date+"</li>"
  start_string = $('input#ruby_start_date').val()
  start = new Date(start_string)
  end_string = $('input#ruby_end_date').val()
  end = new Date(end_string)

  if start <= holiday_date && holiday_date <= end
    $('#holidays_in_period').append(list_item)

holiday_json = ->
  $('#holidays_in_period').html("")
  ary = $('#holiday_ary').html()
  if (typeof ary != 'undefined')
    parsed = jQuery.parseJSON(ary)
    holiday_date_filter holiday for holiday, i in parsed

  if $("#holidays_in_period li").length > 0
    $('#holiday_reminder').removeClass('hidden')
  else
    $('#holiday_reminder').addClass('hidden')

holiday_processor = ->
  start_string = $('input#ruby_start_date').val()
  start_date = new Date(start_string)
  year = start_date.getFullYear()
  $.ajax(url: '/holidays/'+year, type: 'get', success: (data)->
    $('span#holiday_ary').html(data)
    holiday_json()
  )

# checks the timesheet_ary for an existing timesheet and un-hides a warning message about overwritting
timesheet_date_filter = (timesheet) ->
  start_date = timesheet["start_date"]
  start_date_w_time = start_date+" 00:00:00"
  timesheet_date = new Date(start_date_w_time)
  form_date_string = $('input#ruby_start_date').val()
  form_date = new Date(form_date_string)
  timesheet_id = timesheet["id"]
  new_href = timesheet_id+"/edit"
  if form_date.getTime() == timesheet_date.getTime()
    $('#timesheet_overwrite_warning').removeClass('hidden')
    $('#timesheet_overwrite_link').attr("href", new_href)

overwrite_processor = ->
  $('#timesheet_overwrite_warning').addClass('hidden')
  ary = $('#timesheets_ary').html()
  if (typeof ary != 'undefined')
    parsed = jQuery.parseJSON(ary)
    timesheet_date_filter timesheet for timesheet, i in parsed
  

jQuery ->
  dateSetter()
  holiday_processor()
  overwrite_processor()

  $(document).on 'changeDate', '#form_start_date', ( ->
    dateSetter()
    holiday_processor()
    overwrite_processor()
  )

  # timesheets supervisor and admin actions
  $('#direct_report_chooser').click ->
    direct_report = $('#direct_report_select option:selected').val()
    if direct_report == ""
      # Shows the 'Please select a name.' hidden div
      $('#direct_report_error').toggleClass('hidden')
    else
      pathString = "/users/"+direct_report+"/timesheets/new"
      originString = location.origin
      urlString = originString + pathString
      window.location = urlString
    event.preventDefault()
    false

  $('#direct_report_select').change ->
    $('#direct_report_error').addClass('hidden')

  # _timesheet_form.html.erb
  $('#dismiss_timesheet_overwrite_warning').click ->
    $('#timesheet_overwrite_warning').addClass('hidden')
    event.preventDefault
    false

  $('#dismiss_holiday_reminder').click ->
    $('#holiday_reminder').addClass('hidden')
    event.preventDefault
    false

  # _timesheet_hours_form
  $('.timeoff-hide').hide()
  $('.timeoff-show').show()
  $('.expand-5-to-7').removeClass('col-xs-5').addClass('col-xs-7')
  $('.expand-2-to-5').removeClass('col-xs-2').addClass('col-xs-5')

  $('#show_timeoff_switch').click ->
    if $(this).html() == "(add timeoff)"
      htmlString = "(hide timeoff)"
      $('.expand-5-to-7').removeClass('col-xs-7').addClass('col-xs-5')
      $('.expand-2-to-5').removeClass('col-xs-5').addClass('col-xs-2')
      $('.timeoff-hide').show()
      $('.timeoff-show').hide()
    else
      htmlString = "(add timeoff)"
      $('.expand-5-to-7').removeClass('col-xs-5').addClass('col-xs-7')
      $('.expand-2-to-5').removeClass('col-xs-2').addClass('col-xs-5')
      $('.timeoff-hide').hide()
      $('.timeoff-show').show()
    $(this).text( htmlString )
    event.preventDefault()

  # _timesheet_approval_form partial
  $('#review_select_tag').change ->
    if $(this).val() == "true"
      $('.reviewed-field').val(rubyReadyDate())
    else
      $('.reviewed-field').val('')
      $('#approve_select_tag').val('false')
      $('.approved-field').val('')

  $('#approve_select_tag').change ->
    if $(this).val() == "true"
      $('.approved-field').val(rubyReadyDate())
      $('.reviewed-field').val(rubyReadyDate())
      $('#review_select_tag').val('true')
    else
      $('.approved-field').val('')

  $('#to_review_select_tag').change ->
    if $(this).val() == "true"
      $('.timeoff-reviewed-field').val(rubyReadyDate())
    else
      $('.timeoff-reviewed-field').val('')
      $('#to_approve_select_tag').val('false')
      $('.timeoff-approved-field').val('')

  $('#to_approve_select_tag').change ->
    if $(this).val() == "true"
      $('.timeoff-approved-field').val(rubyReadyDate())
      $('.timeoff-reviewed-field').val(rubyReadyDate())
      $('#to_review_select_tag').val('true')
    else
      $('.timeoff-approved-field').val('')

  calculateTotal('.hours-field', '#ttl-hours')
  calculateTotal('.timeoff-hours-field', '#ttl-timeoff-hours')
  
  $('.hours-field').bind 'click keyup', (event) ->
    calculateTotal('.hours-field', '#ttl-hours')

  $('.timeoff-hours-field').bind 'click keyup', (event) ->
    calculateTotal('.timeoff-hours-field', '#ttl-timeoff-hours')

  # timesheet tables in admin, single and supervisor views
  $('#timesheet-admin-table').dataTable
    order: [],
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]

  $('#timesheet-over-table').dataTable
    order: [],
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]

  $('#timesheet-single-table').dataTable
    order: []
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]

  $('#timesheet-archive-table').dataTable
    order: []
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]