__BASH_COMPLETION_USER_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions:$HOME/.guix-home/profile/etc/bash_completion.d

__load_completion() {
   dirs=(
        ${__BASH_COMPLETION_USER_DIR:-${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion}/completions
        "$HOME/.guix-profile/share/bash-completion/completions/$base"
        "$HOME/.guix-profile/etc/bash_completion.d/$base"
        "/run/current-system/profile/share/bash-completion/completions/$base"
        "/run/current-system/profile/etc/bash_completion.d/$base" )

    local OIFS=$IFS IFS=: dir cmd="${1##*/}" compfile
    for dir in ${XDG_DATA_DIRS:-/usr/local/share:/usr/share}; do
#        echo hoho $dir
        dirs+=( $dir/bash-completion/completions )
    done
    IFS=$OIFS

    if [[ $BASH_SOURCE == */* ]]; then
        dirs+=( "${BASH_SOURCE%/*}/completions" )
    else
        dirs+=( ./completions )
    fi

    for dir in "${dirs[@]}"; do
        echo haha $dir
        for compfile in "$cmd" "$cmd.bash" "_$cmd"; do
            compfile="$dir/$compfile"
            # Avoid trying to source dirs; https://bugzilla.redhat.com/903540
            #[[ -f "$compfile" ]] && . "$compfile" &>/dev/null && return 0
        done
    done

    # Look up simple "xspec" completions
#    [[ "${_xspecs[$cmd]}" ]] && complete -F _filedir_xspec "$cmd" && return 0
}

__load_completion
