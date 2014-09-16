jQuery ->
  if $.inArray("configure", pathAry) >= 0 
    $('#pay_period_dialog').dialog
      dialogClass: "no-close",
      autoOpen: false,
      buttons: [{
        text: "Ok"
        click: ->
          $(this).dialog("close")
      }]

    $('#pay_period_q').click ->
      $('#pay_period_dialog').dialog("open")
      event.preventDefault
      false