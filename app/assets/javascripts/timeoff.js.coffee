jQuery ->
  $('#timeoff-calculator-year').datepicker
    format: 'yyyy'
    minViewMode: 2
    autoclose: true

  $('#timeoff-calculator-pay-period').datepicker
    format: 'mm-dd'
    todayBtn: 'linked'
    calendarWeeks: true
    weekStart: 1
    autoclose: true

  $('#timeoff-single-table').dataTable
    order: [[0, "desc"]]
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]

  $('#timeoff-table').dataTable
    order: [[1, "desc"]]
    columnDefs: [
      targets: -1, sortable: false, searchable: false
    ]