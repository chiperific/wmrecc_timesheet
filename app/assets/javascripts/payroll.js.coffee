jQuery ->
  if $.inArray("payroll", pathAry) >= 0

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

