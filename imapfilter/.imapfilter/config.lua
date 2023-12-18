
-- Utility function to get IMAP password from file
function get_imap_password(file)
    local home = os.getenv("HOME")
    local file = home .. "/" .. file
    local str = io.open(file):read()
    return str;
end

----------------
--  Accounts  --
----------------

local cnam = IMAP {
    server = 'imap.cnam.fr',
    username = 'fournier',
    password = get_imap_password(".offlineimap/Password.IMAP.cnam"),
    ssl = 'ssl3',
}

-- Get a list of the available mailboxes and folders
mailboxes, folders = cnam:list_all()
--for _, m in ipairs(mailboxes) do print(m) end
for _, f in ipairs(folders) do print(f) end

-----------------
--  Mailboxes  --
-----------------

-- Get the status of a mailbox
--cnam.INBOX:check_status()
--cnam.News:check_status()
bullei3 = cnam["INBOX"]:is_unseen() * cnam["INBOX"]:contain_subject("bulle-i3")
--bullei3:move_messages(cnam["News"])

filtreNewSujet = function(pattern)
											return cnam["INBOX"]:is_unseen() * cnam["INBOX"]:contain_subject(pattern)
										end

filtreNewTo = function(pattern)
											return cnam["INBOX"]:is_unseen() * cnam["INBOX"]:contain_to(pattern)
										end
filtreNewToCC = function(pattern)
											return cnam["INBOX"]:is_unseen() * (cnam["INBOX"]:contain_to(pattern) + cnam["INBOX"]:contain_cc(pattern))
										end
filtreNewFrom = function(pattern)
											return cnam["INBOX"]:is_unseen() * cnam["INBOX"]:contain_from(pattern)
										end

results = filtreNewSujet("bulle-i3") + 
          filtreNewSujet("bull-ia") + 
          filtreNewSujet("gazettebd3") + 
          filtreNewSujet("liste-egc") + 
          filtreNewSujet("Info-ARIA") + 
          filtreNewSujet("Thomson Reuters") + 
          filtreNewSujet("Publish Your Research Works") + 
          filtreNewSujet("sif-annonces") +
          filtreNewFrom("mailrobot@mail.xing.com") + 
          filtreNewFrom("springer@newsletter.springer.com") + 
          filtreNewFrom("Thomson Reuters") + 
          filtreNewTo("annonces@madics.fr") +
          filtreNewToCC("gdr-securite.appcovid@irisa.fr") +
          filtreNewTo("ssfam@framalistes.org")

--filtreNewSujet("CFP") + 
--filtreNewSujet("Call For Paper") + 

for _, message in ipairs(results) do
  mailbox, uid = table.unpack(message)
  sub = mailbox[uid]:fetch_field("Subject")
  print(uid,sub)
end

results:move_messages(cnam["News"])


--for _, m in ipairs(bullei3) do print(m:fetch_field("subject")) end

