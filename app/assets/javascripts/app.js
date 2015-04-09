function show(id) {
  // $('.skills_jobs').css('display', 'none');
  $('.skills_jobs').slideUp(500);
  $('#skill_jobs_'+id).slideDown('fast');
}

$(function() {
  setTimeout(function(){
    $('.alert').slideUp(500);
  }, 2000);
});