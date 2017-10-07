function __promptline_host {
  retval=""
  if [ -n "${SSH_CLIENT}" ]; then
    if [[ -n ${ZSH_VERSION-} ]]; then retval="%m";
    else retval="\\h"; fi
  fi
}
function __promptline_cwd {
  local dir_limit="4"
  local truncation="⋯"
  local first_char
  local part_count=0
  local formatted_cwd=""
  local dir_sep="  "
  local tilde="~"

  local cwd="${PWD/#$HOME/$tilde}"

  retval=""
  # get first char of the path, i.e. tilde or slash
  [[ -n ${ZSH_VERSION-} ]] && first_char=$cwd[1,1] || first_char=${cwd::1}

  if [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
    cwd="/${match[2]#/}"
    first_char='//'
  fi

  # remove leading tilde
  cwd="${cwd#\~}"

  while [[ "$cwd" == */* && "$cwd" != "/" ]]; do
    # pop off last part of cwd
    local part="${cwd##*/}"
    cwd="${cwd%/*}"

    formatted_cwd="$dir_sep$part$formatted_cwd"
    ((part_count++))

    [[ $part_count -eq $dir_limit ]] && first_char="$truncation" && break
  done

  retval="$first_char$formatted_cwd"
}
function custom_git_branch {
  local branch
  local branch_symbol=" "
  retval=""

  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 || return
  if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
    branch=${branch##*/}
    retval="${branch_symbol}${branch:-unknown} "
    [[ $(git rev-parse --is-inside-git-dir) = "true" ]] && return
    local added_symbol="⚫ "
    local unmerged_symbol="✗ "
    local modified_symbol="+"
    local clean_symbol="✔"
    local has_untracked_files_symbol="…"

    local ahead_symbol="↑"
    local behind_symbol="↓"

    local unmerged_count=0 modified_count=0 has_untracked_files=0 added_count=0 is_clean=""

    set -- $(git rev-list --left-right --count @{upstream}...HEAD 2>/dev/null)
    local behind_count=$1
    local ahead_count=$2

    added_count=$(git diff --name-status --cached | wc -l)
    modified_count=$(git diff --name-status --diff-filter=M | wc -l)
    unmerged_count=$(git diff --name-status --diff-filter=U | wc -l)

    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      has_untracked_files=1
    fi

    if [ $(( unmerged_count + modified_count + has_untracked_files + added_count )) -eq 0 ]; then
      is_clean=1
    fi

    local leading_whitespace=""
    [[ $ahead_count -gt 0 ]]         && { retval="$retval$leading_whitespace$ahead_symbol$ahead_count"; leading_whitespace=" "; }
    [[ $behind_count -gt 0 ]]        && { retval="$retval$leading_whitespace$behind_symbol$behind_count"; leading_whitespace=" "; }
    [[ $modified_count -gt 0 ]]      && { retval="$retval$leading_whitespace$modified_symbol$modified_count"; leading_whitespace=" "; }
    [[ $unmerged_count -gt 0 ]]      && { retval="$retval$leading_whitespace$unmerged_symbol$unmerged_count"; leading_whitespace=" "; }
    [[ $added_count -gt 0 ]]         && { retval="$retval$leading_whitespace$added_symbol$added_count"; leading_whitespace=" "; }
    [[ $has_untracked_files -gt 0 ]] && { retval="$retval$leading_whitespace$has_untracked_files_symbol"; leading_whitespace=" "; }
    [[ $is_clean -gt 0 ]]            && { retval="$retval$leading_whitespace$clean_symbol"; leading_whitespace=" "; }
      return
  elif [[ $PWD =~ '/google/src/cloud/[^/]+/(.+)/google3(.*)' ]]; then
    retval="${branch_symbol}${match[1]}"
  fi
  return 1
}
function __promptline_ps1 {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1
  tmp_retval=""

  # section "a" header
  slice_prefix="${a_bg}${sep}${a_fg}${a_bg}${space}" slice_suffix="$space${a_sep_fg}" slice_joiner="${a_fg}${a_bg}${alt_sep}${space}" slice_empty_prefix="${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_host
  if [[ -n "$retval" ]]; then
    tmp_retval="$tmp_retval$slice_prefix$retval$slice_suffix"
    slice_prefix="$slice_joiner"
    is_prompt_empty=0
  fi

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}" slice_suffix="$space${b_sep_fg}" slice_joiner="${b_fg}${b_bg}${alt_sep}${space}" slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  if [[ -n ${ZSH_VERSION-} ]]; then
    tmp_retval="$tmp_retval$slice_prefix%n$slice_suffix"
  else
    tmp_retval="$tmp_retval$slice_prefix\\u$slice_suffix"
  fi
  slice_prefix="$slice_joiner"
  is_prompt_empty=0

  # section "c" header
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}" slice_suffix="$space${c_sep_fg}" slice_joiner="${c_fg}${c_bg}${alt_sep}${space}" slice_empty_prefix="${c_fg}${c_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "c" slices
  __promptline_cwd
  if [[ -n "$retval" ]]; then
    tmp_retval="$tmp_retval$slice_prefix$retval$slice_suffix"
    slice_prefix="$slice_joiner"
    is_prompt_empty=0
  fi

  # section "y" header
  #slice_prefix="${y_bg}${sep}${y_fg}${y_bg}${space}" slice_suffix="$space${y_sep_fg}" slice_joiner="${y_fg}${y_bg}${alt_sep}${space}" slice_empty_prefix="${y_fg}${y_bg}${space}"
  #[ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "y" slices
  #custom_get_branch
  #if [[ -n "$retval" ]]; then
  #  tmp_retval="$tmp_retval$slice_prefix$retval$slice_suffix"
  #  slice_prefix="$slice_joiner"
  #  is_prompt_empty=0
  #fi

  # section "warn" header
  retval=""
  if [ "$last_exit_code" -ne "0" ];then
    retval="${last_exit_code}"
  fi
  slice_prefix="${warn_bg}${sep}${warn_fg}${warn_bg}${space}" slice_suffix="$space${warn_sep_fg}" slice_joiner="${warn_fg}${warn_bg}${alt_sep}${space}" slice_empty_prefix="${warn_fg}${warn_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "warn" slices
  if [[ -n "$retval" ]]; then
    tmp_retval="$tmp_retval$slice_prefix$retval$slice_suffix"
    slice_prefix="$slice_joiner"
    is_prompt_empty=0
  fi

  # close sections
  retval="$tmp_retval${reset_bg}${sep}$reset$space"
}
function __promptline_left_prompt {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1
  tmp_retval=""

  # section "a" header
  slice_prefix="${a_bg}${sep}${a_fg}${a_bg}${space}" slice_suffix="$space${a_sep_fg}" slice_joiner="${a_fg}${a_bg}${alt_sep}${space}" slice_empty_prefix="${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_host
  if [[ -n "$retval" ]]; then
    tmp_retval="$tmp_retval$slice_prefix$retval$slice_suffix"
    slice_prefix="$slice_joiner"
    is_prompt_empty=0
  fi

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}" slice_suffix="$space${b_sep_fg}" slice_joiner="${b_fg}${b_bg}${alt_sep}${space}" slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  if [[ -n ${ZSH_VERSION-} ]]; then
    tmp_retval="$tmp_retval$slice_prefix%n$slice_suffix"
  else
    tmp_retval="$tmp_retval$slice_prefix\\u$slice_suffix"
  fi
  slice_prefix="$slice_joiner"
  is_prompt_empty=0

  # section "c" header
  slice_prefix="${c_bg}${sep}${c_fg}${c_bg}${space}" slice_suffix="$space${c_sep_fg}" slice_joiner="${c_fg}${c_bg}${alt_sep}${space}" slice_empty_prefix="${c_fg}${c_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "c" slices
  __promptline_cwd
  if [[ -n "$retval" ]]; then
    tmp_retval="$tmp_retval$slice_prefix$retval$slice_suffix"
    slice_prefix="$slice_joiner"
    is_prompt_empty=0
  fi

  # close sections
  retval="$tmp_retval${reset_bg}${sep}$reset$space"
}
function __promptline_right_fast {
  retval=""
  if [ "$last_exit_code" -ne "0" ]; then
    retval="${warn_sep_fg}${rsep}${warn_fg}${warn_bg}${space}${last_exit_code}$space${warn_sep_fg}"
  fi
}
function __promptline_right_slow {
  tmp_retval=""

  custom_git_branch
  if [[ -n "$retval" ]]; then
    tmp_retval="$tmp_retval${y_sep_fg}${rsep}${y_fg}${y_bg}${space}$retval$space${y_sep_fg}"
  fi
  retval=$tmp_retval
}
function __promptline {
  local last_exit_code="${PROMPTLINE_LAST_EXIT_CODE:-$?}"

  local esc=$'['
  if [[ -n ${ZSH_VERSION-} ]]; then
    local noprint='%{' end_noprint='%}'
  else
    local noprint='\[' end_noprint='\]'
  fi
  local wrap="$noprint$esc" end_wrap="m$end_noprint"
  local space=" "
  local sep=""
  local rsep=""
  local alt_sep=""
  local alt_rsep=""
  local reset="${wrap}0${end_wrap}"
  local reset_bg="${wrap}49${end_wrap}"
  local a_fg="${wrap}38;5;17${end_wrap}"
  local a_bg="${wrap}48;5;190${end_wrap}"
  local a_sep_fg="${wrap}38;5;190${end_wrap}"
  local b_fg="${wrap}38;5;255${end_wrap}"
  local b_bg="${wrap}48;5;238${end_wrap}"
  local b_sep_fg="${wrap}38;5;238${end_wrap}"
  local c_fg="${wrap}38;5;85${end_wrap}"
  local c_bg="${wrap}48;5;234${end_wrap}"
  local c_sep_fg="${wrap}38;5;234${end_wrap}"
  local warn_fg="${wrap}38;5;232${end_wrap}"
  local warn_bg="${wrap}48;5;166${end_wrap}"
  local warn_sep_fg="${wrap}38;5;166${end_wrap}"
  local y_fg="${wrap}38;5;255${end_wrap}"
  local y_bg="${wrap}48;5;238${end_wrap}"
  local y_sep_fg="${wrap}38;5;238${end_wrap}"

  function async() {
      # save to temp file
      __promptline_right_slow
      printf "%s" "$retval" > "/dev/shm/zsh_prompt_$$"
      # signal parent
      kill -s USR1 $$
  }
  if [[ -n ${ZSH_VERSION-} ]]; then
    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi
    # start background computation
    if [ "$PWD" != "$NOT_GIT_DIR" ]; then
      async &!
      ASYNC_PROC=$!
    else
      RPROMPTSLOW=""
    fi
    __promptline_left_prompt
    PROMPT="$retval"
    __promptline_right_fast
    RPROMPT="$retval"'$RPROMPTSLOW'"$reset"
  else
    __promptline_ps1
    PS1="$retval"
  fi
}

ASYNC_PROC=0
function TRAPUSR1() {
    # read from temp file
    read RPROMPTSLOW < "/dev/shm/zsh_prompt_$$"
    if [[ -z $RPROMPTSLOW ]]; then
      NOT_GIT_DIR=$PWD
    fi

    # reset proc number
    ASYNC_PROC=0

    # redisplay
    zle && zle reset-prompt
}

if [[ -n ${ZSH_VERSION-} ]]; then
  if [[ ! ${precmd_functions[(r)__promptline]} == __promptline ]]; then
    precmd_functions+=(__promptline)
  fi
else
  if [[ ! "$PROMPT_COMMAND" == *__promptline* ]]; then
    PROMPT_COMMAND='__promptline;'$'\n'"$PROMPT_COMMAND"
  fi
fi
