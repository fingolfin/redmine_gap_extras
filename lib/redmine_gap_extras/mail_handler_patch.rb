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

module RedmineGAPExtras
  module MailHandlerPatch
    #unloadable # ????

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :plain_text_body, :hack
      end
    end

    module InstanceMethods
      def plain_text_body_with_hack
        return @plain_text_body unless @plain_text_body.nil?
    
        part = email.text_part || email.html_part || email
        @plain_text_body = Redmine::CodesetUtil.to_utf8(part.body.decoded, part.charset)
    
        if email.html_part.nil?
          # plain text: do nothing. No need to worry about insertion of
          # malicious HTML either, as the text formatter will perform
          # HTML escaping
        else
          # strip html tags and remove doctype directive
          @plain_text_body = strip_tags(@plain_text_body.strip)
          @plain_text_body.sub! %r{^<!DOCTYPE .*$}, ''
        end
        @plain_text_body
      end
    end
  end
end

unless MailHandler.include?(RedmineGAPExtras::MailHandlerPatch)
  MailHandler.send :include, RedmineGAPExtras::MailHandlerPatch
end
