#!/usr/bin/env python3

# Take an mbox HTML message (e.g. from mutt), split it using munpack
# (a separate program), and rewrite it so it can be viewed in an
# external browser.
# Can be run from within a mailer like mutt, or independently
# on a single message file.
#
# Usage: viewhtmlmail
#
# Inspired by John Eikenberry <jae@zhar.net>'s view_html_mail.sh
# which sadly no longer works, at least with mail from current Apple Mail.
#
# Copyright 2013 by Akkana Peck. Share and enjoy under the GPL v2 or later.
# Changes:
#   Holger Klawitter 2014: create a secure temp file and avoid temp mbox
#   Read the message as bytes and honour the MIME charset, so non-ASCII
#   text displays correctly; keep attachments inside the temp dir.

# To use it from mutt, put the following lines in your .muttrc:
# macro  index  <F10>  "<pipe-message>~/bin/viewhtmlmail\n" "View HTML in browser"
# macro  pager  <F10>  "<pipe-message>~/bin/viewhtmlmail\n" "View HTML in browser"

import os, sys
import re
import time
import shutil
import subprocess
import email, mimetypes
import tempfile
from pathlib import Path


def decode_html(part):
    """Return (html_text, charset_known) for the HTML part.

    get_payload(decode=True) only undoes the transfer encoding
    (base64 / quoted-printable). The result is still bytes in whatever
    charset the sender used, which is named in the MIME header, e.g.
        Content-Type: text/html; charset="utf-8"
    """
    payload = part.get_payload(decode=True) or b''
    charset = part.get_content_charset()
    if charset:
        try:
            return payload.decode(charset, errors='replace').lstrip('\ufeff'), True
        except LookupError:
            print(f"Unknown charset {charset}, leaving the HTML bytes as they are")
    # No usable charset in the MIME headers. Decode in a way that gives
    # back exactly the same bytes when written out, so the browser can
    # still use any <meta charset> inside the HTML itself.
    return payload.decode('ascii', errors='surrogateescape'), False


def view_html_message(tmpdir):

    # Parse the message as bytes. Reading sys.stdin as text decodes it with
    # the locale's encoding, and the email module then mangles any body sent
    # as raw 8bit (common for UTF-8 mail): non-ASCII characters come out as
    # Latin-1 bytes or literal \uXXXX escapes.
    msg = email.message_from_binary_file(sys.stdin.buffer)

    html_part = None
    counter = 1
    subfiles = []
    for part in msg.walk():

        # part has, for example:
        # items: [('Content-Type', 'image/jpeg'), ('Content-Transfer-Encoding', 'base64'), ('Content-ID', '<14.3631871432@web82503.mail.mud.yahoo.com>'), ('Content-Disposition', 'attachment; filename="ATT0001414.jpg"')]
        # keys: ['Content-Type', 'Content-Transfer-Encoding', 'Content-ID', 'Content-Disposition']
        # values: ['image/jpeg', 'base64', '<14.3631871432@web82503.mail.mud.yahoo.com>', 'attachment; filename="ATT0001414.jpg"']

        # multipart/* are just containers
        if part.is_multipart() or part.get_content_type() == 'message/rfc822':
            continue

        if part.get_content_subtype() == 'html':
            if html_part:
                print("Eek, more than one html part!")
            html_part = part

        # Save it to a file in the temp dir.
        filename = part.get_filename()
        if filename:
            # Don't let a message write outside tmpdir: drop any directory
            # part, including ../ and absolute paths like /home/you/.bashrc
            # (os.path.join ignores tmpdir when given an absolute path).
            filename = os.path.basename(filename)
        if not filename or filename in ('.', '..'):
            ext = mimetypes.guess_extension(part.get_content_type())
            if not ext:
                # Use a generic bag-of-bits extension
                ext = '.bin'
            filename = 'part-%03d%s' % (counter, ext)

        filename = os.path.join(tmpdir, filename)

        # Mailers may use Content-Id or Content-ID (or, presumably, various
        # other capitalizations). So we can't just look it up simply.
        content_id = None
        for k in part.keys():
            if k.lower() == 'content-id':
                # Remove angle brackets, if present.
                content_id = str(part[k]).strip()
                if content_id.startswith('<') and content_id.endswith('>'):
                    content_id = content_id[1:-1]

                subfiles.append({ 'filename': filename,
                                  'url': Path(filename).as_uri(),
                                  'Content-Id': content_id })
                counter += 1
                with open(filename, 'wb') as fp:
                    fp.write(part.get_payload(decode=True) or b'')
                break     # no need to look at other keys

        if not content_id:
            print(f"{filename} doesn't have a Content-Id, not saving")

    if html_part is None:
        print("No HTML part in this message")
        shutil.rmtree(tmpdir)
        return

    # We're done saving the parts. It's time to save the HTML part.
    html, charset_known = decode_html(html_part)

    # Substitute all the filenames for CIDs:
    for sf in subfiles:
        html = re.sub('cid: ?' + re.escape(sf['Content-Id']),
                      sf['url'], html, flags=re.IGNORECASE)

    if charset_known:
        # Write UTF-8 with a byte order mark. Browsers treat a BOM as
        # authoritative, overriding any (possibly wrong) <meta charset>
        # in the HTML, so Firefox doesn't have to guess.
        data = html.encode('utf-8-sig')
    else:
        data = html.encode('ascii', errors='surrogateescape')

    htmlfile = os.path.join(tmpdir, "viewhtml.html")
    with open(htmlfile, 'wb') as fp:
        fp.write(data)

    # Now we have the file. Call firefox on it.
    url = Path(htmlfile).as_uri()
    print(f"Calling firefox for {url}")
    subprocess.call(["firefox", url])

    # Wait a while to make sure firefox has loaded the images, then clean up.
    time.sleep(6)
    shutil.rmtree(tmpdir)

if __name__ == '__main__':
    tmpdir = tempfile.mkdtemp()
    view_html_message(tmpdir)
