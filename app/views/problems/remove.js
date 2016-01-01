$("#problems_panel").html('<%= escape_javascript( render partial: "problems/problem_list", :locals => { assignment: @assignment } ) %>');
