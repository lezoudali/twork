var ready;
 
ready = function(){
    // enable chosen js
    $('.chosen-select').chosen({
        no_results_text: 'No results matched'
    });
}
 
$(document).ready(ready);
