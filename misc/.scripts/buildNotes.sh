#! /bin/bash

vim -E -c  VimwikiDiaryGenerateLinks -c q
cd /home/raph/Notes
make clean html copyhtml
