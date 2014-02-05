Deface::Override.new(:virtual_path => "projects/settings/_members",
                     :name => "add_email_to_new_members",
                     :replace => "div#principals_for_new_member",
                     :text => "<div id='principals_for_new_member'><%= render_principals_for_new_members(@project) %></div>")
