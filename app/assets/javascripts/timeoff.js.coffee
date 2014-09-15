jQuery ->
  if $.inArray("timeoff", pathAry) >= 0
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