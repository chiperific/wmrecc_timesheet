# scripts for the Export page

jQuery ->
  $('#export_table').dataTable
    columnDefs: [
      width: "20%", targets: -1
    ]

  # Change the dates on the form before submission, for a cleaner URL
  $('#export_searchbar_form').submit ->
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

  $('#export_searchbar_close').click ->
    $('#export_searchbar').toggle()
    $(this).toggleClass('fa-times')
    $(this).toggleClass('fa-plus')
    event.preventDefault()
    false

  # $('#export_input_department').change ->
  #   dept = this.value
  #   $('.export-searchbar-usr-check').prop("checked",false)
  #   $('#usr_ary').attr("value", "")
  #   $('.export-searchbar-usr-dept').each ->
  #     if $(this).attr("data-department") == dept
  #       $(this).siblings('.export-searchbar-usr-check').prop("checked", true)
  #       usrId = $(this).siblings('.export-searchbar-usr-check').attr("id")
  #       $('#usr_ary').attr("value", $(this).attr("value") + usrID + " ")
  #   event.preventDefault()
  #   false
