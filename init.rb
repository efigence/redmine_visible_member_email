require 'redmine'

Redmine::Plugin.register :redmine_visible_member_email do
  name 'Redmine visible member email plugin'
  author 'Jacek Grzybowski'
  description "Allows to display user email next to username when adding members to project"
  version '0.0.1'
  url 'http://github.com/efigence/redmine_visible_member_email'
  author_url 'http://efigence.com'
end

ActionDispatch::Callbacks.to_prepare do
  ApplicationHelper.send(:include, RedmineVisibleMemberEmail::ApplicationHelperPatch) unless ApplicationHelper.included_modules.include? RedmineVisibleMemberEmail::ApplicationHelperPatch
end
