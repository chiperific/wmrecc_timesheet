$.fn.removeClassMatch = (rexp) ->
    this.removeClass (i, css) -> (c for c in css.split(' ') when c.match(rexp)).join(' ')

calculateTotalVal = (input, ttl_field) ->
  sum = 0
  $(input).each ->
    if !isNaN(this.value) && this.value.length != 0
      sum += parseFloat this.value
    $(ttl_field).val(sum.toFixed(1))

setColor = (target, now, max) ->
  $(target).removeClassMatch(/progress-bar-[a-zA-Z]*/g)
  if now > max
    $(target).addClass('progress-bar-danger')
  else if now == max
    $(target).addClass('progress-bar-success')
  else
    $(target).addClass('progress-bar-warning')

updateProgressBar = (bar) ->
  target = $(bar).children('.progress-bar')
  min_text = target.attr('aria-valuemin')
  max_text = target.attr('aria-valuemax')
  now_text = $(bar).siblings('input').val()
  min = parseFloat min_text
  max = parseFloat max_text
  now = parseFloat now_text
  size = (now-min)*100/(max-min)
  target.css('width', size+'%')
  target.html(now.toFixed(1) + "/" + max.toFixed(1))
  setColor(target, now, max)

jQuery ->
  $('.progress-bar').each ->
    min_text = $(this).attr('aria-valuemin')
    max_text = $(this).attr('aria-valuemax')
    now_text = $(this).attr('aria-valuenow')
    min = parseFloat min_text
    max = parseFloat max_text
    now = parseFloat now_text
    size = (now-min)*100/(max-min)
    $(this).css('width', size+'%')
    $(this).html(now.toFixed(1) + "/" + max.toFixed(1))
    setColor(this, now, max)

  # calculate total and update progress bar when hours-based fields are changed
  $('.progressbar-hours').bind 'click keyup', (event) ->
    calculateTotalVal('.progressbar-hours', '#hours_bar_ttl')
    updateProgressBar('#hours_progressbar')

  $('.progressbar-categories').bind 'click keyup', (event) ->
    calculateTotalVal('.progressbar-categories', '#categories_bar_ttl')
    updateProgressBar('#categories_progressbar')
