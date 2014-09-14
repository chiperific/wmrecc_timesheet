# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  if $.inArray("categories", pathAry) >= 0
    $('#cat-view-switch').click ->
      $('#inactive-cats').toggleClass('hidden')
      if $(this).html() == "View inactive categories"
        $(this).html("Hide inactive categories")
      else
        $(this).html("View inactive categories")
      event.preventDefault()
      false

    $('#categories-table').dataTable
      columnDefs: [
        targets: -1, searchable: false, orderable: false
      ]

    $('#inactive-categories-table').dataTable
      columnDefs: [
        targets: -1, searchable: false, orderable: false
      ]