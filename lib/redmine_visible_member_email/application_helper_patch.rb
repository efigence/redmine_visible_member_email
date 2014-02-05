require_dependency 'application_helper'

module RedmineVisibleMemberEmail
  module ApplicationHelperPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        alias_method_chain :principals_check_box_tags, :emails
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
    end
  end
end
