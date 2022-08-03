

function skeleton_image(id, id2) {
  var img = document.getElementById(id);
  var skeleton = document.getElementById(id2);
  img.onload = function () {
    img.style.display = 'block';
    skeleton.style.display = 'none';
  }

  


}