$("#courses_panel").html('<%= escape_javascript(render partial: "course_list", :locals => { courses: @courses }) %>');
