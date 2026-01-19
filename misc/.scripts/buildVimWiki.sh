#! /bin/bash

vim -E -c VimwikiAll2HTML -c VimwikiDiaryGenerateLinks -c q
cd /home/raph/public_html/vimwiki
make clean html copyhtml
