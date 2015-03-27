// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery-ui/sortable
//= require jquery-ui/dialog
//= require jquery-ui/effect-pulsate
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-sprockets
//= require bootstrap-datepicker/core
//= require dataTables/jquery.dataTables
//= require dataTables/bootstrap/3/jquery.dataTables.bootstrap
//= require dataTables/extras/dataTables.responsive
//= require turbolinks
//= require_tree .

Date.prototype.getWeek = function() {
  var onejan = new Date(this.getFullYear(),0,1);
  return Math.ceil((((this - onejan) / 86400000) + onejan.getDay())/7);
}

$.extend( true, $.fn.dataTable.defaults, {
  responsive: true,
  autoWidth: false,
  order: [[0, "desc"]],
  pagingType: "full_numbers",
  lengthMenu: [ [10, 25, 50, -1], [10, 25, 50, "All"] ],
  info: false,
  dom:
    "<'row'<'col-xs-4'l><'col-xs-8'f>r>"+
    "t"+
    "<'row'<'col-xs-8'p>>",
  language: {
    paginate: {
      first: "&#8676",
      previous: "&#8592",
      next: "&#8594",
      last: "&#8677"
    }
  }
} );