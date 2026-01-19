#
# If you want to see svn modifications:
# export SVN_SHOWDIRTYSTATE=1 
#
# Put this in your PS1 like this:
# PS1='\u@\h:\W\[\033[01;33m\]$(__git_svn_ps1)\[\033[00m\]$ '

# 
__svn_info_str() {
  svn info --show-item wc-root 2>/dev/null
  # possibly necessary for older versions of svn that can't do wc-root:
  # svn info 2>/dev/null | grep '[A-Z]' | cut -c 1 | head -1
}


# Git/Subversion prompt function
__svn_ps1() {
    local s=
    if [ __svn_info_str ]; then
        local r=`__svn_rev`
        local b=`__svn_branch`
        s=" [$b:$r]"
    fi
    echo -n "$s"
}

# Outputs the current trunk, branch, or tag
__svn_branch() {
    local url=
    if [ __svn_info_str ]; then
        url=`svn info | awk '/URL:/ {print $2}'`
        if [[ $url =~ trunk ]]; then
            echo trunk
        elif [[ $url =~ /branches/ ]]; then
            echo $url | sed -e 's#^.*/\(branches/.*\)/.*$#\1#'
        elif [[ $url =~ /tags/ ]]; then
            echo $url | sed -e 's#^.*/\(tags/.*\)/.*$#\1#'
        fi
    fi
}

# Outputs the current revision
__svn_rev() {
    local r=$(svn info | awk '/Revision:/ {print $2}')

    if [ ! -z $SVN_SHOWDIRTYSTATE ]; then
        local svnst flag
        svnst=$(svn status | grep '^\s*[?ACDMR?!]')
        [ -z "$svnst" ] && flag=*
        r=$r$flag
    fi
    echo $r
}
