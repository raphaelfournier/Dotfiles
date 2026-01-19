#! /bin/bash 

echo "== Quota Check =="
echo 
python  ~/.scripts/imapQuotaCheck/imapQuotaChecker.py
echo -e "\n== Details ==\n"
perl ~/.scripts/imap-folder-sizes/folder-sizes.pl
