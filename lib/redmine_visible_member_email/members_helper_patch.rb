require_dependency 'members_helper'

module RedmineVisibleMemberEmail
  module MembersHelperPatch
    def self.included(base)
      base.send(:extend, ClassMethods)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
      end
    end

    module ClassMethods
    end

    module InstanceMethods
      def render_principals_for_new_members_with_email(project)
        scope = Principal.active.sorted.not_member_of(project).like(params[:q])
        principal_count = scope.count
        principal_pages = Redmine::Pagination::Paginator.new principal_count, 100, params['page']
        principals = scope.offset(principal_pages.offset).limit(principal_pages.per_page).all

        s = content_tag('div', principals_check_box_tags_with_email('membership[user_ids][]', principals), :id => 'principals')

        links = pagination_links_full(principal_pages, principal_count, :per_page_links => false) {|text, parameters, options|
          link_to text, autocomplete_project_memberships_path(project, parameters.merge(:q => params[:q], :format => 'js')), :remote => true
        }

        s + content_tag('p', links, :class => 'pagination')
      end
    end
  end
end
