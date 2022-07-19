function add_like(user_id, comment_id, post_id)
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
      post_id: post_id
   }),
    success: function(data) {
      if (comment_id)
      {
        $("#comment-heart-" + comment_id).toggleClass("text-blue-600");
      }
      if (post_id)
      {
        $("#post-heart-" + post_id).toggleClass("text-blue-600");
      }
    },
    error: function(data) { 
      toastr.error(data.responseJSON.error, 'Error')
    }
  })
}