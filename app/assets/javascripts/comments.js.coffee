#$ ->
#  $('.edit-comment-link').click (e) ->
#    e.preventDefault();
#    $(this).hide();
#    comment_id = $(this).data('commentId')
#    $('form#edit-comment-' + comment_id).show()

#  $('form.new_comment').bind 'ajax:success', (e, data, status, xhr) ->
#    comment = $.parseJSON(xhr.responseText)
#    $('.comments').append('<p>' + comment.body + '<p>')
#    $('.comments').append('<p><a href="#">Edit</a><p>')
#    $('.new_comment #comment_body').val('');
#  .bind 'ajax:error', (e, xhr, status, error) ->
#    errors = $.parseJSON(xhr.responseText)
#    $.each errors, (index, value) ->
#      $('.comment-errors').append(value)

#  questionId = $('.comments').data('questionId')
#  PivatePub.subscribe '/questions/' + questionId + '/comments', (data, channel) ->
#    console.log(data)
#    comment = $.parseJSON(data['comment'])
#    $('.comments').append('<p>' + comment.body + '<p>')
#    $('.comments').append('<p><a href="#">Edit</a><p>')
#    $('.new_comments #comments_body').val('');
#
#  answerId = $('.comments').data('answerId')
#  PivatePub.subscribe '/answers/' + answerId + '/comments', (data, channel) ->
#    console.log(data)
#    comment = $.parseJSON(data['comment'])
#    $('.comments').append('<p>' + comment.body + '<p>')
#    $('.comments').append('<p><a href="#">Edit</a><p>')
#    $('.new_comments #comments_body').val('');