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

  $('.remove_day').click ->
    a = confirm "Are you sure? This won't take efect until you click 'Update Configuration'."
    if a
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('li.boxed').appendTo('ul#weekday_list').hide()
      update_day_num()
      show_add_weekday()
    event.preventDefault()
    false

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

