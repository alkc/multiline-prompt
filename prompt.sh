function parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/[ on branch -> \1 ]/'
}

function parse_conda_env() {
    if [ -z $CONDA_PREFIX ]; then
        echo ""
    else
	echo "[ conda -> $(basename $CONDA_PREFIX) ]"
    fi
}

function title_bar() {
    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;\w\a\]$PS1"
            ;;
        *)
            ;;
    esac
}

function multiline_prompt() {
    GREEN='\[\033[01;32m\]'
    BLUE='\[\033[01;34m\]'
    ORANGE='\[\033[38;5;202m\]'
    RESET='\[\033[00m\]'
    if [ "$color_prompt" = yes ]; then
        # MODLINE="(${GREEN}\u@\h${RESET})-[${BLUE}\w${RESET}]${ORANGE}\`parse_git_branch\`${RESET}"
        MODLINE="\u@\h \[\e[32m\]\w \[\e[91m\]\}\$(parse_conda_env)\$(parse_git_branch)\[\e[00m\]"
    else
        # MODLINE="(\u@\h)-[\[\w\]]\`parse_git_branch\`"
        MODLINE="\u@\h \[\e[32m\]\w \[\e[91m\]\$(parse_conda_env)\$(parse_git_branch)\[\e[00m\]"
    fi

    export PS1="┌──$MODLINE\n└─\$ "
    unset color_prompt force_color_prompt
    title_bar
 }
