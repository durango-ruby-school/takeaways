$(document).ready(function() {
  $(".more_info").click(function () {
    var $title = $(this).find(".title");
    if (!$title.length) {
      $(this).append('<div class="title">' + $(this).attr("title") + '</div>');
    } else {
      $title.remove();
    }
  });
});
