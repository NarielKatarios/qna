$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  $('form.new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    $('.answers').html(xhr.responseText)
  .bind 'ajax:error', (e, xhr, status, error) ->
    $('.answer-errors').html(xhr.responseText)