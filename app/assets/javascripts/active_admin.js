//= require active_admin/base

// ========================
// = Learning Target Form =
// ========================
var AddResourceToLastObjective = function(){$('.has_many_container.learning_objectives > .has_many_fields:last .has_many_container.learning_resources > .has_many_add').click()}

$(document).on('click', '.has_many_container.learning_objectives > .has_many_add', function(){
  setTimeout(AddResourceToLastObjective,100);
});
