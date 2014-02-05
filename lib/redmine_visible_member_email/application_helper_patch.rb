require_dependency 'application_helper'

module RedmineVisibleMemberEmail
  module ApplicationHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method :principals_check_box_tags, :principals_check_box_tags_with_emails
        alias_method_chain :link_to_user, :email
      end
    end

    module InstanceMethods
      def principals_check_box_tags_with_emails(name, principals)
        s = ''
        principals.each do |principal|
          s << "<label>#{ check_box_tag name, principal.id, false, :id => nil } #{h principal} (#{principal.mail})</label>\n"
        end
        s.html_safe
      end

      def link_to_user_with_email(user, options={})
        # show email next to username only on projects/settings/members view
        if controller.view_context.view_renderer.
                instance_variable_get('@_partial_renderer').instance_values['path'] == 'projects/settings/members'
          if user.is_a?(User)
            name = h(user.name(options[:format]))
            if user.active? || (User.current.admin? && user.logged?)
              link_to "#{user.name} (#{user.mail})", user_path(user), :class => user.css_classes
            else
              name
            end
          else
            h(user.to_s)
          end
        else
          link_to_user_without_email(user, options={})
        end
      end
    end
  end
end
