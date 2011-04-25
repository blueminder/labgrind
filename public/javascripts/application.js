// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function() {
    
  // Always send the authenticity_token with ajax
  $(document).ajaxSend(function(event, request, settings) {
    if ( settings.type == 'post' ) {
      settings.data = (settings.data ? settings.data + "&" : "") + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
    }
  });
    
 // hides the slickbox as soon as the DOM is ready
  $('#slickbox').hide();
 // shows the slickbox on clicking the noted link  
  $('#slick-show').click(function() {
    $('#slickbox').show('slow');
    return false;
  });
 // hides the slickbox on clicking the noted link  
  $('#slick-hide').click(function() {
    $('#slickbox').hide('fast');
    return false;
  });
 
 // toggles the slickbox on clicking the noted link  
  $('#slick-toggle').click(function() {
    $('#slickbox').toggle(400);
    return false;
  });
  
  $(".project_entry").each( function() {   
    
    $(".edit_title").each( function() {    
        $(this).editable('update_entry_title', {
              type    :   'textarea',
              cancel  :   'Cancel',
              submit  :   'Save Title',
              indicator   :   'Saving...',
              tooltip :   'Click to Edit.',
              rows        :       0,
              method      :       "put",
              submitdata  :   {id: $(this).attr('id'), name:$(this).attr('name') }
          });
    });
      
    $(".edit_content").each( function() {    
        $(this).editable('update_entry_content', {
              type    :   'textarea',
              cancel  :   'Cancel',
              submit  :   'Save Entry Content',
              indicator   :   'Saving...',
              tooltip :   'Click to Edit.',
              rows        :       5,
              method      :       "put",
              submitdata  :   {id: $(this).attr('id'), name:$(this).attr('name') }
          });
    });
    
    $(".edit_title").mouseover(function(event) {
      $(this).css('background','#ffffff'); 
    });
    
    $(".edit_title").mouseout(function(event) {
      $(this).css('background',''); 
    });
    
    $(".edit_content").mouseover(function(event) {
      $(this).css('background','#ffffff'); 
    });
    
    $(".edit_content").mouseout(function(event) {
      $(this).css('background',''); 
    });
  });
  
  $(".project_entry").mouseover(function(event) {
    $(this).css('background','#ffffcc'); 
    $('.entry_options').show();
  });
  
  $(".project_entry").mouseout(function(event) {
    $(this).css('background',''); 
    $('.entry_options').hide();
  });
  

  
  $(".user_entry").mouseover(function(event) {
    $(this).css('background','#ffffcc'); 
    $(this).children('.entry_options').show();
  });
  
  $(".user_entry").mouseout(function(event) {
    $(this).css('background',''); 
    $(this).children('.entry_options').hide();
  });
  
  $("#self.user_entry").mouseover(function(event) {
    $(this).css('background','#ff9999'); 
    $(this).children('.entry_options').show();
  });
  
  $("#self.user_entry").mouseout(function(event) {
    $(this).css('background','#ff9999'); 
    $(this).children('.entry_options').hide();
  });
  
  $('.delete_entry').click(function() {
    $('.delete_entry').post
    return false;
  });

});


