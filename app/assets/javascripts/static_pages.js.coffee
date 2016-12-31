# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

update_day_num= ->
  $('.weekday-li').each (index)->
    new_val = index+1
    $(this).find('.day-num-hidden').val(new_val)
    $(this).find('.day-num').html(new_val)

jQuery ->
  $('#admin-table').dataTable
    ordering: false
    paging: false

  $('#msg-board-hider').click ->
    $('#message-board').slideToggle("fast")
    $('.fa-hideable').slideToggle("fast")
    $(this).toggleClass('unhide')
    event.preventDefault()
    false

  ################## Configure page scripts
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
    $('.holiday-li-empty').hide()
    fields = $(this).data('fields')
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    last_li = $('#holiday_list_body li').last()
    last_li.after($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    false

  # grant: add new
  $('.add_grant').click ->
    $('.grant-li-empty').hide()
    fields = $(this).data('fields')
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    last_li = $('#grant_list_body li').last()
    last_li.after($(this).data('fields').replace(regexp, time))
    event.preventDefault()
    false
