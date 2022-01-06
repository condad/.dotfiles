function fish_prompt
    if not set -q VIRTUAL_ENV_DISABLE_PROMPT
      set -g VIRTUAL_ENV_DISABLE_PROMPT true
    end

    set_color --bold yellow
    printf '%s' (whoami)
    set_color normal

    # display git branch or machine name
    if test -z (get_current_git_branch)
      printf ' at '
      set_color --bold magenta
      printf '%s' (prompt_hostname)
      set_color normal
    else
      printf ' on '
      set_color --bold magenta
      printf '%s' (get_current_git_branch)
      set_color normal
    end

    printf ' in '
    set_color --bold $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    # Line 2
    echo
    if test $VIRTUAL_ENV
      set_color cyan
      printf "(%s) " (basename (dirname $VIRTUAL_ENV))
      set_color normal
    end
    printf '↪ '
    set_color normal
end
