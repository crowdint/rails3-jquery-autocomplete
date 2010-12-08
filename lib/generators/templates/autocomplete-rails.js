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
*       <input type="text" data-autocomplete="/url/to/autocomplete" id_element="#id_field">
*/

$(document).ready(function(){
	$('input[data-autocomplete]').railsAutocomplete();
});

(function(jQuery)
{
	var self = null;
	jQuery.fn.railsAutocomplete = function() {
		return this.live('focus',function() {
			if (!this.railsAutoCompleter) {
				this.railsAutoCompleter = new jQuery.railsAutocomplete(this);
			}
		});
	};
	
	jQuery.railsAutocomplete = function (e) {
		_e = e;
		this.init(_e);
	};
	
	jQuery.railsAutocomplete.fn = jQuery.railsAutocomplete.prototype = {
		railsAutocomplete: '0.0.1'
	};
	
	jQuery.railsAutocomplete.fn.extend = jQuery.railsAutocomplete.extend = jQuery.extend;
	jQuery.railsAutocomplete.fn.extend({
		init: function(e) {
			e.delimiter = $(e).attr('data-delimiter') || null;
			function split( val ) {
				return val.split( e.delimiter );
			}
			function extractLast( term ) {
				return split( term ).pop().replace(/^\s+/,"");
			}
		
	    $(e).autocomplete({
				source: function( request, response ) {
					$.getJSON( $(e).attr('data-autocomplete'), {
					term: extractLast( request.term )
					}, response );
				},
				search: function() {
					// custom minLength
					var term = extractLast( this.value );
					if ( term.length < 2 ) {
						return false;
					}
				},
				focus: function() {
								// prevent value inserted on focus
					return false;
				},
				select: function( event, ui ) {
					var terms = split( this.value );
					// remove the current input
					terms.pop();
					// add the selected item
					terms.push( ui.item.value );
					// add placeholder to get the comma-and-space at the end
					if (e.delimiter != null) {
						terms.push( "" );
						this.value = terms.join( e.delimiter );
					} else {
						this.value = terms.join("");
						if ($(this).attr('id_element')) {
							$($(this).attr('id_element')).val(ui.item.id);
						}
					};
				
					return false;
				}
			});
    }
  });
})(jQuery);
