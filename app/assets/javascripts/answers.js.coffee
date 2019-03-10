$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  questionId = $('.answers').data('questionId')
  PivatePub.subscribe '/questions/' + questionId + '/answers', (data, channel) ->
    answer = $.parseJSON(data['answer'])
    $('.answers').append('<p>' + answer.body + '<p>')
    $('.answers').append('<p><a href="#">Edit</a><p>')
    $('.new_answer #answer_body').val('');