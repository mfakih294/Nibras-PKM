<script type="text/javascript">

var day_data = [
  {"period": "2012-09-01", "pln total": 9, "pln completed": 7},
  {"period": "2012-09-02", "pln total": 4, "pln completed": 4},
  {"period": "2012-09-03", "pln total": 5, "pln completed": 3},
  {"period": "2012-09-04", "pln total": 8, "pln completed": 6},
  {"period": "2012-09-05", "pln total": 2, "pln completed": 1},
  {"period": "2012-09-06", "pln total": 0, "pln completed": 0},
  {"period": "2012-09-07", "pln total": 5, "pln completed": 5},
  {"period": "2012-09-08", "pln total": 1, "pln completed": 1},
  {"period": "2012-09-09", "pln total": 1, "pln completed": 0},
  {"period": "2012-09-10", "pln total": 12, "pln completed": 10}
];
Morris.Line({
  element: 'graph',
  data: day_data,
  xkey: 'period',
  ykeys: ['pln total', 'pln completed'],
  labels: ['pln total', 'pln completed'],
  /* custom label formatting with `xLabelFormat` */
  xLabelFormat: function(d) { return (d.getMonth()+1)+'/'+d.getDate()+'/'+d.getFullYear(); },
  /* setting `xLabels` is recommended when using xLabelFormat */
  xLabels: 'day'
});

</script>

<div id="graph" style="width: 600px; height: 150px; margin: 5px auto 0 auto;"></div>
