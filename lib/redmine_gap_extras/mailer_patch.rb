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
  module MailerPatch
    #unloadable # ????

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        alias_method_chain :issue_add, :hack
        alias_method_chain :issue_edit, :hack
      end
    end

    module InstanceMethods
      def issue_add_with_hack(issue)
        redmine_headers 'Project' => issue.project.identifier,
                        'Issue-Id' => issue.id,
                        'Issue-Author' => issue.author.login
        redmine_headers 'Issue-Assignee' => issue.assigned_to.login if issue.assigned_to
        message_id issue
        @author = issue.author
        @issue = issue
        @issue_url = url_for(:controller => 'issues', :action => 'show', :id => issue)
        recipients = issue.recipients
        cc = issue.watcher_recipients - recipients
        mail :to => recipients,
          :cc => cc,
          :subject => "[#{issue.project.name} ##{issue.id}] #{issue.subject}"
      end

      def issue_edit_with_hack(journal)
        issue = journal.journalized.reload
        redmine_headers 'Project' => issue.project.identifier,
                        'Issue-Id' => issue.id,
                        'Issue-Author' => issue.author.login
        redmine_headers 'Issue-Assignee' => issue.assigned_to.login if issue.assigned_to
        message_id journal
        references issue
        @author = journal.user
        recipients = journal.recipients
        # Watchers in cc
        cc = journal.watcher_recipients - recipients
        @issue = issue
        @journal = journal
        @issue_url = url_for(:controller => 'issues', :action => 'show', :id => issue, :anchor => "change-#{journal.id}")
        mail :to => recipients,
          :cc => cc,
          :subject => "[#{issue.project.name} ##{issue.id}] #{issue.subject}"
      end
    end
  end
end

unless Mailer.include?(RedmineGAPExtras::MailerPatch)
  Mailer.send :include, RedmineGAPExtras::MailerPatch
end
