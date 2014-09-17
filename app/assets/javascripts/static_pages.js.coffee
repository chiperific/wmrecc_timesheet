# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

show_add_weekday= ->
  if $('#weekday_list li[style!="display: none;"]').length < 7
    $('#add_weekday_div').show()
  else
   $('#add_weekday_div').hide()

update_day_num= ->
  $('.weekday-li').each (index)->
    new_val = index+1
    $(this).find('.day-num-hidden').val(new_val)
    $(this).find('.day-num').html(new_val)

jQuery ->
  # Configure page scripts
  #if $.inArray("configure", pathAry) >= 0
  show_add_weekday()

  $('#msg-board-hider').click ->
    $('#message-board').slideToggle("fast")
    $('.fa-hideable').slideToggle("fast")
    $(this).toggleClass('unhide')
    event.preventDefault()
    false

  $('#admin-table').dataTable
    ordering: false
    paging: false

  $('#weekday_list').sortable
    axis: 'y'
    update: update_day_num

  # weekday: hide and mark for deletion
  $(document).on 'click', '.remove_day', ( ->
    a = confirm "Are you sure? This won't take efect until you click 'Update Configuration'."
    if a
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('li.boxed').appendTo('ul#weekday_list').hide()
      update_day_num()
      show_add_weekday()
    event.preventDefault()
    false
  )

  # weekday: add new
  $('.add_day').click ->
    fields = $(this).data('fields')
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    last_li = $('#weekday_list li[style!="display: none;"]').last()
    last_li.after($(this).data('fields').replace(regexp, time))
    new_record_day_num = "app_default_weekdays_attributes_"+time+"_day_num"
    li_count = $('#weekday_list li[style!="display: none;"]').length
    new_record = $('#'+new_record_day_num)
    new_record.val(li_count)
    new_record.next('span.day-num').html(li_count)
    show_add_weekday()
    event.preventDefault()
    false

  # holiday: details show / hide
  $(document).on 'click', '.expand_holiday', ( ->
    parent = $(this).parent('span')
    checkbox = $(parent).siblings('span.holiday-type').children('input[type="checkbox"]')
    icon_closed = "fa fa-plus-square"
    icon_open = "fa fa-minus-square"
    if $(checkbox).is(':checked')
      $(parent).siblings('div.holiday-sub-li-float').toggleClass('hidden')
    else
      $(parent).siblings('div.holiday-sub-li-fixed').toggleClass('hidden')
    
    $(this).children('i').toggleClass(icon_closed).toggleClass(icon_open)
    event.preventDefault()
    false
  )

  # holiday: if details are visible when checkbox is changed, switch visible div
  $(document).on "click", 'input[type="checkbox"]', ( ->
    parent = $(this).parent('span.holiday-type')
    fixed = $(parent).siblings('div.holiday-sub-li-fixed')
    float = $(parent).siblings('div.holiday-sub-li-float')
    if !$(fixed).hasClass('hidden') || !$(float).hasClass('hidden')
      $(fixed).toggleClass('hidden')
      $(float).toggleClass('hidden')
  )

  # sync the month-float val with month-fixed
  $(document).on "change", 'select.month-fixed', ( ->
    new_val = $(this).val()
    parent = $(this).parents('div.holiday-sub-li-fixed')
    sibling = $(parent).siblings('div.holiday-sub-li-float')
    other =  $(sibling).find('select.month-float')
    $(other).val(new_val)
  )

  # sync the month-fixed val with month-float
  $(document).on "change", 'select.month-float', ( ->
    new_val = $(this).val()
    parent = $(this).parents('div.holiday-sub-li-float')
    sibling = $(parent).siblings('div.holiday-sub-li-fixed')
    other =  $(sibling).find('select.month-fixed')
    $(other).val(new_val)
  )

  # holiday: hide and mark for deletion
  $(document).on "click", '.remove_holiday', ( ->
    a = confirm "Are you sure? This won't take efect until you click 'Update Configuration'."
    if a
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('li.boxed').hide()
    event.preventDefault()
    false
  )

  # holiday: add new
  $('.add_holiday').click ->
    fields = $(this).data('fields')
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    last_li = $('#holiday_list li[style!="display: none;"]').last()
    last_li.after($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    false
