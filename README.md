# Redmine Backlogs extended sprints plugin

Redmine plugin for Backlogs users which enables displaying `due date` for stories assigned to Sprints in Master Backlogs sprint tables.

# Requirements

Developed & tested on Redmine 2.3.3.

# Installation

1. Go to your Redmine installation's plugins/ directory.
2. `git clone http://github.com/efigence/redmine_backlogs_extended_sprints`.
3. Go back to Redmine root directory and run `bundle`.
3. Restart Redmine.

# Configuration

To enable/disable plugins' functionality visit Administration -> Plugin. Afterwards, click on `Configure` link next to the plugin name.

# Note

Plugin depends on [deface](https://github.com/spree/deface) gem which made it possible to extend original Backlogs views.
