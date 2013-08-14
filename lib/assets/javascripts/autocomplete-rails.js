/*
* Unobtrusive autocomplete
*
* To use it, you just have to include the HTML attribute autocomplete
* with the autocomplete URL as the value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete">
*
* Optionally, you can use a jQuery selector to specify a field that can
* be updated with the element id whenever you find a matching value
*
*   Example:
*       <input type="text" data-autocomplete="/url/to/autocomplete" data-id-element="#id_field">
*/
!function(a){a.fn.railsAutocomplete=function(){return this.live("focus",function(){this.railsAutoCompleter||(this.railsAutoCompleter=new a.railsAutocomplete(this))})},a.railsAutocomplete=function(a){_e=a,this.init(_e)},a.railsAutocomplete.fn=a.railsAutocomplete.prototype={railsAutocomplete:"0.0.1"},a.railsAutocomplete.fn.extend=a.railsAutocomplete.extend=a.extend,a.railsAutocomplete.fn.extend({init:function(b){function c(a){return a.split(b.delimiter)}function d(a){return c(a).pop().replace(/^\s+/,"")}b.delimiter=a(b).attr("data-delimiter")||null,b.min_length=a(b).attr("min-lenght")||2,a(b).autocomplete({source:function(c,e){a.getJSON(a(b).attr("data-autocomplete"),{term:d(c.term)},function(){a(arguments[0]).each(function(c,d){var e={};e[d.id]=d,a(b).data(e)}),e.apply(null,arguments)})},search:function(){var a=d(this.value);return a.length<b.min_length?!1:void 0},focus:function(){return!1},select:function(d,e){var f=c(this.value);if(f.pop(),f.push(e.item.value),null!=b.delimiter)f.push(""),this.value=f.join(b.delimiter);else if(this.value=f.join(""),a(this).attr("data-id-element")&&a(a(this).attr("data-id-element")).val(e.item.id),a(this).attr("data-update-elements")){var g=a(this).data(e.item.id.toString()),h=a.parseJSON(a(this).attr("data-update-elements"));for(var i in h)a(h[i]).val(g[i])}var j=this.value;return a(this).bind("keyup.clearId",function(){a(this).val().trim()!=j.trim()&&(a(a(this).attr("data-id-element")).val(""),a(this).unbind("keyup.clearId"))}),a(this).trigger("railsAutocomplete.select",e),!1}})}}),a(document).ready(function(){a("input[data-autocomplete]").railsAutocomplete()})}(jQuery);
