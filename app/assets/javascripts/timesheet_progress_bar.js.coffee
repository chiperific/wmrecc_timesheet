calculateTotalVal = (input, ttl_field) ->
  sum = 0
  $(input).each ->
    if !isNaN(this.value) && this.value.length != 0
      sum += parseFloat this.value
    $(ttl_field).val(sum.toFixed(1))

setColors = (bar, now, max) ->
  if now > max

updateProgressBar = (bar) ->
  target = $(bar).children('.progress-bar')
  min = target.attr('aria-valuemin')
  max = target.attr('aria-valuemax')
  now = $(bar).siblings('input').val()
  siz = (now-min)*100/(max-min)
  target.css('width', siz+'%')
  target.html(now + "/" + max)

jQuery ->
  #set initial bar values
  $('.progress-bar').each ->
    min = $(this).attr('aria-valuemin')
    max = $(this).attr('aria-valuemax')
    now = $(this).attr('aria-valuenow')
    siz = (now-min)*100/(max-min)
    $(this).css('width', siz+'%')
    $(this).html(now + "/" + max)

  # calculate total and update progress bar when hours-based fields are changed
  $('.progressbar-hours').bind 'click keyup', (event) ->
    calculateTotalVal('.progressbar-hours', '#hours_bar_ttl')
    updateProgressBar('#hours_progressbar')

  $('.progressbar-categories').bind 'click keyup', (event) ->
    calculateTotalVal('.progressbar-categories', '#categories_bar_ttl')
    updateProgressBar('#categories_progressbar')
