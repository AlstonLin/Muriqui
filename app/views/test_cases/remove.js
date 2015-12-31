$("#test_list").html('<%= escape_javascript(render partial: "test_cases/test_case_list", :locals => { problem: @problem }) %>');
