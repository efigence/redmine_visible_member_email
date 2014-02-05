require_dependency 'application_helper'

module RedmineVisibleMemberEmail
  module ApplicationHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method :principals_check_box_tags, :principals_check_box_tags_with_emails
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
      end
    end
  end
end
