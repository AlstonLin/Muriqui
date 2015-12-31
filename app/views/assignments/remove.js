$("#assignments_panel").html('<%= escape_javascript( render :partial => "assignments/assignment_list", :locals => { course: @course } ) %>');
