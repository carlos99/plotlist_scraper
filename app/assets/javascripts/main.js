$( document ).ready(function() {
    $('#ragain').click(function(e){
	    e.preventDefault();
	    $('.search-again').fadeToggle(1500);
	});

	$('.morefilters').click(function(e){
	    e.preventDefault();
	    $('.more-filters-form').fadeToggle(800);
	});
});

/*$('#reset-btn').on('click', function () {
	    $('#frm-search').find('input:text').val(''); 
	    $('input:checkbox').removeAttr('checked');
	});

	$('#frm-search').on('click', function () {
	    $('#reset-btn').trigger("reset");
	});*/