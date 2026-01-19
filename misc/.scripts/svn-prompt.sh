#!/bin/sh
#
# bash/zsh svn prompt support
#
# Setup instructions
#
# https://github.com/mcandre/svn-prompt

parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | egrep -o '(tags|branches)/[^/]+|trunk' | egrep -o '[^/]+$' | awk '{print " ("$1")" }'
}
parse_svn_url() {
    svn info 2>/dev/null | sed -ne 's#^URL: ##p'
}
parse_svn_repository_root() {
    svn info 2>/dev/null | grep Racine | grep -o "http.*$"
}

parse_svn_branch()
