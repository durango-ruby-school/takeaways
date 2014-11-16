$('#information').click(function() {
  $('#information').tooltip("open");
});

$(".more_info").click(function () {
    var $title = $(this).find(".title");
    if (!$title.length) {
        $(this).append('<span class="title">' + $(this).attr("title") + '</span>');
    } else {
        $title.remove();
    }
});
