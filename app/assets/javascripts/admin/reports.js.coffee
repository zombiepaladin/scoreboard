# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ () ->
  if $('#total_task_completion_chart').length > 0
    Morris.Line
      element: 'total_task_completion_chart'
      data: $('#total_task_completion_chart').data('task-completion')
      xkey: 'date'
      ykeys: ['count']
      labels: ['Tasks Completed']
     
  if $('#scores_chart').length > 0
    Morris.Line
      element: 'scores_chart'
      data: $('#scores_chart').data('scores')
      xkey: 'date'
      ykeys: ['total', 'admin']
      labels: ['Total Points Scored', 'Points Granted by Admins']
      
  if $('#unique_logins_chart').length > 0
    Morris.Line
      element: 'unique_logins_chart'
      data: $('#unique_logins_chart').data('logins')
      xkey: 'date'
      ykeys: ['total']
      labels: ['Unique Logins']

  options = 
    start: new Date(2013,7,25)
    end: new Date(2013,9,10)
    width: '100%'
    height: 'auto'
    style: 'box'
  jQuery ->
    $('.timeline').each (index, value) ->
      timeline = new links.Timeline(value)
      data = ({start: new Date(event.start), content: event.content} for event in $(value).data('timeline'))
      timeline.draw data, options 
