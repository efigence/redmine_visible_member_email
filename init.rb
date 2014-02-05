require 'redmine'

# Little hack for deface in redmine:
# - redmine plugins are not railties nor engines, so deface overrides are not detected automatically
# - deface doesn't support direct loading anymore ; it unloads everything at boot so that reload in dev works
# - hack consists in adding "app/overrides" path of the plugin in Redmine's main #paths
Rails.application.paths["app/overrides"] ||= []
Rails.application.paths["app/overrides"] << File.expand_path("../app/overrides", __FILE__)

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
