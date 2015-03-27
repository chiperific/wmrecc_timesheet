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