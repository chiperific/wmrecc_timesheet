jQuery ->
  $('#timeoff_table').dataTable
    order: [[1, "desc"]],
    responsive: true,
    autoWidth: false,
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]

  # Change the dates on the form before submission, for a cleaner URL
  $('#timeoff_searchbar_form').submit ->
    humanDate = $('#searchbar_date').val()
    date = new Date(humanDate)
    year = date.getFullYear()
    month = ('0'+(date.getMonth()+1)).slice(-2)
    day = ('0'+ date.getDate()).slice(-2)
    rubyDate = year+"-"+month+"-"+day
    $('#searchbar_date').val(rubyDate)
    true

  $('#timeoff_users_table').dataTable
    order: [[0,"asc"],[1,"asc"]],
    responsive: true,
    autoWidth: false,
    columnDefs: [
      targets: [0,1], sortable: false, searchable: false
    ]

  # Toggle visibility of _timeoff_searchbar and _timeoff_users_table on admin and supervisor views
  $('#toggle_timeoff_users_partials').click ->
    $('.timeoff_users_toggle').slideToggle()
    $(this).toggleClass('on')
    $(this).toggleClass('off')
    $("a#toggle_timeoff_users_partials.on").html(
      "<i class='fa fa-minus'></i> Hide User Summary"
      )
    $("a#toggle_timeoff_users_partials.off").html(
      "<i class='fa fa-plus'></i> Show User Summary"
      )
    event.preventDefault
    false