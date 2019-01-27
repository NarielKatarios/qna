$ ->
  PrivatePub.subscribe "/questions/new", (data, channel) ->
    question = $.parseJSON(data['question'])
    $('body table tbody').append('<tr><td>' + question.id + '</td><td>' + question.title + '</td><td>' + question.body + '</td></tr>')
