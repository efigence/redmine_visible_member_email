Deface::Override.new(:virtual_path => "projects/settings/_members",
                     :name => "add_email_to_members",
                     :replace => "td.user",
                     :text => "<td class='user'><%= link_to_user_with_email member.principal %></td>")
