att_id = <%= JSON.generate @attempt.id %>
user_id = <%= JSON.generate @student_drift_user.id %>
is_coding = <%= JSON.generate @exercise.is_coding? %>

setTimeout ( ->
  $.ajax(url: "/sse/feedback_poll?att_id=#{att_id}")
), 2000
