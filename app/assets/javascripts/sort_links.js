$(document).ready(function(){
    $('.select_box').change(function(){
        $('#sorting_form').submit();
        $('.links').empty();
    });
});