# make a date Ruby can handle
rubyReadyDate = ->
  n = new Date()
  y = n.getFullYear()
  m = n.getMonth()
  d = n.getDate()
  y + '/' + m + '/' + d

calculateTotal = (input, ttl_field) ->
  sum = 0
  $(input).each ->
    if !isNaN(this.value) && this.value.length != 0
      sum += parseFloat this.value
    $(ttl_field).html(sum)


jQuery ->
# _timesheet_form.html.erb:
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

  $('#week_num_to_date_field').datepicker
    todayBtn: "linked"
    format: 'mm/dd'
    calendarWeeks: true
    weekStart: 1
    autoclose: true

  $('#week_num_to_date_field').change ->
    new_mm_dd = $(this).val()
    new_yy = $('#timesheet_year').val()
    new_date = new_mm_dd + "/" + new_yy
    $('#timesheet_week_num').val(new Date(new_date).getWeek())

  $('#timesheet_year').datepicker
    format: "yyyy"
    minViewMode: 2
    autoclose: true

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

  # _timesheet_hours_form.html.erb
  $('#review_select_tag').change ->
    if $(this).val() == "true"
      $('.reviewed-field').val(RubyReadyDate())
    else
      $('.reviewed-field').val('')

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

  $('#to_approve_select_tag').change ->
    if $(this).val() == "true"
      $('.timeoff-approved-field').val(rubyReadyDate())
      $('.timeoff-reviewed-field').val(rubyReadyDate())
      $('#to_review_select_tag').val('true')
    else
      $('.timeoff-approved-field').val('')

  calculateTotal('.hours-field', '#ttl-hours')
  calculateTotal('.timeoff-hours-field', '#ttl-timeoff-hours')
  
  $('.hours-field').keyup ->
    calculateTotal('.hours-field', '#ttl-hours')

  $('.timeoff-hours-field').keyup ->
    calculateTotal('.timeoff-hours-field', '#ttl-timeoff-hours')

  $('#timesheet-admin-table').dataTable
    pagingType: "full_numbers"
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]

  $('#timesheet-over-table').dataTable
    pagingType: "full_numbers"
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]