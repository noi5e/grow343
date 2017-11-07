//= require active_admin/base
//= require google-chart

// ========================
// = Learning Target Form =
// ========================
var AddResourceToLastObjective = function(){$('.has_many_container.learning_objectives > .has_many_fields:last .has_many_container.learning_resources > .has_many_add').click()}

$(document).on('click', '.has_many_container.learning_objectives > .has_many_add', function(){
  setTimeout(AddResourceToLastObjective,100);
});

google.charts.load('current', {packages: ['corechart', 'line']});

function drawChart(d, id) {
  var data = new google.visualization.DataTable();
  data.addColumn('string', 'X');
  data.addColumn('number', 'Score');

  data.addRows(d);

  var options = {
    pointSize: 4,
    legend: {position: 'none'},
    vAxis: {
      baseline: 0,
      gridlines: {color: 'transparent'},
      viewWindow: {
          min: 0,
          max: 4
      }
    },
    hAxis: {
      baselineWidth: 2,
      baselineColor: '#000',
      gridlines: {color: '#000000'}
    }
  };

  var chart = new google.visualization.LineChart(document.getElementById(id));
  chart.draw(data, options);
}

