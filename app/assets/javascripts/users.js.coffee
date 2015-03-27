jQuery ->
  # supervisor and admin views:
  $('#user-view-switch').click ->
    $('#inactive-users').toggleClass('hidden')
    if $(this).html() == "View inactive users"
      $(this).html("Hide inactive users")
    else
      $(this).html("View inactive users")
    event.preventDefault()
    false

  # user_form: show/hide salary or hourly field based upon paytype
  $('#user_pay_type').change ->
    $('#user_salary_div').toggleClass('hidden')
    $('#user_hourly_div').toggleClass('hidden')

  # self, supervisor and admin views
  $('.super-view-switch').click ->
    closed = "fa fa-caret-right"
    open = "fa fa-caret-down"
    list_id = $(this).attr('id')
    $('#active-users').find('.'+list_id).children('td').toggleClass('hidden')
    if $(this).children('i').attr('class') == closed
      $(this).children('i').removeClass(closed)
      $(this).children('i').addClass(open)
    else
      $(this).children('i').removeClass(open)
      $(this).children('i').addClass(closed)
    event.preventDefault()
    false

  $('#users-table').dataTable
    ordering: false
    iDisplayLength: 50
    
  $('#inactive-users-table').dataTable
    ordering: false