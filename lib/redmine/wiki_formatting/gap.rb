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

#require 'digest/md5'

module Redmine
  module WikiFormatting
    # Custom formatter module, based on the NullFormatter
    module GAP
      class Formatter
        include ActionView::Helpers::TagHelper
        include ActionView::Helpers::TextHelper
        include ActionView::Helpers::UrlHelper
        include Redmine::WikiFormatting::LinksHelper

        def initialize(text)
          @text = text
        end

        def to_html(*args)
          t = CGI::escapeHTML(@text)
          auto_link!(t)
          auto_mailto!(t)
          #simple_format(t, {}, :sanitize => false)
          t = '<div style="white-space: pre-wrap;">' + t.to_str + '</div>'
          t.html_safe
        end
      end

      module Helper
        def wikitoolbar_for(field_id)
        end

        def heads_for_wiki_formatter
        end

        def initial_page_content(page)
          page.pretty_title.to_s
        end
      end
    end
  end
end
