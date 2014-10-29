ready = ->
  $("#bookings").fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,agendaWeek,agendaDay'
    events:
      url: '/bookings.json'

$(document).ready ready
$(document).on 'page:load', ready
