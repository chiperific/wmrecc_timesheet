jQuery ->
  $('.date-picker').datepicker
    autoclose: true,
    todayHighlight: true,
    format: 'mm/dd/yyyy'

  $('#fake_date').change ->
    userDate = $('#fake_date').val()
    arr = userDate.split('/')
    rubyDate = arr[2]+"-"+arr[0]+"-"+arr[1]
    $('#request_date').val(rubyDate)

  $('#request_date').change ->
    alert "should be changed"