jQuery ->
  $('#payroll-user-table').dataTable()

  $('#payroll-category-table').dataTable()

  $('#hours_dialog').dialog
    dialogClass: "no-close",
    autoOpen: false,
    buttons: [{
      text: "Ok"
      click: ->
        $(this).dialog("close")
    }]

  $('#hours_dialog_q').click ->
    $('#hours_dialog').dialog("open")
    event.preventDefault
    false

  $('#categories_dialog').dialog
    dialogClass: "no-close",
    autoOpen: false,
    buttons: [{
      text: "Ok"
      click: ->
        $(this).dialog("close")
    }]

  $('#categories_dialog_q').click ->
    $('#categories_dialog').dialog("open")
    event.preventDefault
    false


  $('#category_users_dialog').dialog
    dialogClass: "no-close",
    autoOpen: false,
    width: "auto",
    buttons: [{
      text: "Ok"
      click: ->
        $(this).dialog("close")
    }]

  # create a div for showing the users by category tbl
  cat_user_tbl = (user) ->
    name = user["staff"]
    hours = user["hours"]
    rate = user["rate"]
    subttl = user["subttl"]
    html = "<tr><td>"+name+"</td><td class='text-center'>"+hours+"</td><td class='text-right'>"+rate+"</td><td class='text-right'>"+subttl+"</td></tr>"
    $("#category_users_tbody").append(html)

  cat_user_json = (data) ->
    ary = data
    if (typeof ary != 'undefined')
      parsed = jQuery.parseJSON(ary)
      cat_user_tbl user for user, i in parsed
    $('#category_users_dialog').dialog("open")

  $('.cat_users_dialog_link').click ->
    $('#category_users_tbody').empty()
    cat_id = $(this).attr("name")
    replace = new RegExp('/', 'g')
    start_date = $('#start_date').html().replace(replace,"-")
    end_date = $('#end_date').html().replace(replace,"-")
    $.ajax( url: "/payroll_cats_users/"+cat_id+"/"+start_date+"/"+end_date, type: 'get', success: (data) ->
      cat_user_json(data)
    )
    event.preventDefault
    false

  # Change the dates on the form before submission, for a cleaner URL
  $('#payroll_searchbar_form').submit ->
    humanDateStart = $('#searchbar_start').val()
    humanDateEnd = $('#searchbar_end').val()
    startDate = new Date(humanDateStart)
    endDate = new Date(humanDateEnd)
    startYear = startDate.getFullYear()
    startMonth = ('0'+(startDate.getMonth()+1)).slice(-2)
    startDay = ('0'+ startDate.getDate()).slice(-2)
    rubyDateStart = startYear+"-"+startMonth+"-"+startDay
    endYear = endDate.getFullYear()
    endMonth = ('0'+(endDate.getMonth()+1)).slice(-2)
    endDay = ('0'+ endDate.getDate()).slice(-2)
    rubyDateEnd = endYear+"-"+endMonth+"-"+endDay
    $('#searchbar_start').val(rubyDateStart)
    $('#searchbar_end').val(rubyDateEnd)
    true


