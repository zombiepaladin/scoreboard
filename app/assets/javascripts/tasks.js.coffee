# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("input.date_picker").datepicker({format: 'yyyy-mm-dd'})
  $("#sortable-tasks").sortable
    axis: 'y',
    handle: '.drag-handle',
    update: () ->
      $.post(
        $(this).data('update-url'),
        $(this).sortable('serialize')
      );
    

