# GAP plugin for Redmine
# Copyright (C) 2012  Max Horn
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'redmine'
require 'redmine_gap_extras/gap_formatting'

Redmine::Plugin.register :redmine_gap_extras do
  name 'GAP Extras plugin'
  author 'Max Horn'
  description 'Add various tweaks to Redmine needed for the GAP issue tracker'
  version '0.2'
  url 'https://github.com/fingolfin/redmine_gap_extras'
  author_url 'http://www.quendi.de'
  requires_redmine :version_or_higher => '2.2.0'

  # Register our custom wiki format provider
  wiki_format_provider 'gap', RedmineGAPExtras::Formatter, RedmineGAPExtras::Helper

end

# Prepare monkey patching the mail handler
ActionDispatch::Callbacks.to_prepare do
  require 'redmine_gap_extras/mail_handler_patch'
  require 'redmine_gap_extras/mailer_patch'
end
