function add_like(user_id, comment_id)
{
  $.ajax({
    url: "/likes/save",
    type: "POST",
    dataType:'json',
    headers: {
      'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content'),
      'Content-Type': 'application/json'
    },
    processData: false,
    data: JSON.stringify({
      user_id: user_id,
      comment_id: comment_id,
   }),
    success: function(data) {
      $("#comment-heart-" + comment_id).toggleClass("text-red-600");
    },
    error: function(data) { 
      toastr.error(data.responseJSON.error, 'Error')
    }
  })
};
