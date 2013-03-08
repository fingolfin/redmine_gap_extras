Redmine plugin for the GAP issue tracker
========================================

This [Redmine](http://redmine.org) plugin collects various tweaks
intended for use by the [GAP](http://www.gap-system.org) issue tracker.
In particular:

* A new text formatting style 'gap' is added. It is very close to 'none',
  but it preserves indention and other runs of whitespaces.
* The MailHandler class is monkey patched to ensure that plain text emails are
  accepted as-is. In particular, no attempt is made to strip HTML. This
  way, emails containing GAP pseudo code are preserved. This is important
  because some GAP output can look like HTML, e.g. &lt;object&gt;
* The Mailer class is monkey patched to tweak the "Subject:" and "From:"
  fields used in issue notification emails.

