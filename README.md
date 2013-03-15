Redmine plugin for the GAP issue tracker
========================================

This [Redmine][] plugin collects various tweaks intended for use by the
[GAP][] [issue tracker][]. In particular:

* A new text formatting style 'gap' is added. It is very close to 'none',
  but it preserves indention and other runs of whitespaces.
* The MailHandler class is monkey patched to ensure that plain text emails are
  accepted as-is. In particular, no attempt is made to strip HTML. This
  way, emails containing GAP pseudo code are preserved. This is important
  because some GAP output can look like HTML, e.g. &lt;object&gt;
* The Mailer class is monkey patched to tweak various things:
  * The ``Subject:`` field for added and edited issues is now identical in
    both cases, except that for updates, we prefix ``Re:`` to help mail
    clients sort related messages in thread views. It is also more compact
    and does not include the issue status
  * The ``From:`` field is tweaked to include the user's full name. So instead
     of ``email@tracker.domain`` you now get mails from
     ``John Doe <email@tracker.domain>``
  * The ``In-Reply-To:`` field is set (identical to ``References:``)
* The mail templates are customized for our needs.
  * The global ``mailer.*.erb`` is tweaked to suppress the global
    email header and/or footer (and related text) if it has been
    set to be empty by the site admin.


[Redmine]: http://www.redmine.org/
[GAP]: http://www.gap-system.org/
[issue tracker]: http://tracker.gap-system.org/
