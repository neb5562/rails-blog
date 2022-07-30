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
        $("#comment-heart-" + comment_id).toggleClass("text-blue-500");
        $("#comment-heart-" + comment_id).toggleClass("dark:text-slate-300");
        $("#comment-heart-" + comment_id).toggleClass("dark:text-blue-500");
      }
      if (post_id)
      {
        $("#post-heart-" + post_id).toggleClass("text-blue-500");
        $("#post-heart-" + post_id).toggleClass("dark:text-slate-300");
        $("#post-heart-" + post_id).toggleClass("dark:text-blue-500");
      }
    },
    error: function(data) { 
      toastr.error(data.responseJSON.error, 'Error')
    }
  })
}