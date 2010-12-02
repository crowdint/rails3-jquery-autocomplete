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
  $('input[data-autocomplete]').each(function(i){
		this.delimiter = $(this).attr('data-delimiter') || null;
		_selfinput = this;
		function split( val ) {
			return val.split( _selfinput.delimiter );
		}
		function extractLast( term ) {
			return split( term ).pop();
		}
		
    $(this).autocomplete({
			source: function( request, response ) {
				$.getJSON( $(_selfinput).attr('data-autocomplete'), {
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
				if (_selfinput.delimiter != null) {
					terms.push( "" );
					this.value = terms.join( _selfinput.delimiter );
				} else {
					this.value = terms.join("");
				};
				
				return false;
			}

    });
  });
});
