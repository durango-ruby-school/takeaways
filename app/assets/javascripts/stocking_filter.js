$(function() {
  $("#time_frame_filter #time_frame").on("change", function() {
    this.form.submit();
  })
});
