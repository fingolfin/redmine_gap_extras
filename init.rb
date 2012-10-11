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
require 'redmine/wiki_formatting/gap'

Redmine::Plugin.register :gap_extras do
  name 'GAP Extras plugin'
  author 'Max Horn'
  description 'This Reminde plugin adds various tweaks needed for the GAP tracker'
  version '0.0.1'
  url 'http://www.quendie.de/gap/redmine-plugin'
  author_url 'http://www.quendi.de'

  # Register our custom wiki format provider
  wiki_format_provider 'gap', Redmine::WikiFormatting::GAP::Formatter, Redmine::WikiFormatting::GAP::Helper

end
