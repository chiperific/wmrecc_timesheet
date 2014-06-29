jQuery ->
  $('.date-picker').datepicker({
      todayHighlight: true
    });

  $('#numdays_btn').click ->
    #populate button - to load multiple days off forms
    numdays = $('#numdays_field').val()
    if numdays != ""
      url = window.location.href
      urlsplit = url.split('?')
      url_w_var = urlsplit[0] + "?numdays=" + numdays
      window.location.href = url_w_var
    event.preventDefault()
    false

  $('.destroyer').click ->
      $(this).toggleClass('text-danger')
      $(this).toggleClass('text-info')
    
