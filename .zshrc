#補間
autoload -U compinit
compinit

#文字コード
export LANG=ja_JP.UTF-8

#プロンプト
autoload -U colors

#colors

# 色を使用
autoload -Uz colors ; colors

# エディタをvimに設定
export EDITOR=vim

# パスを追加したい場合
export PATH="$HOME/bin:$PATH"

#履歴

#履歴を保持するファイル指定
HISTFILE="$HOME/.zsh_history"

#履歴の件数
HISTSIZE=100000
SAVEHIST=100000

#履歴の検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end 

#cdの設定

#ディレクトリ名だけで移動する。
setopt auto_cd

#自動でpushdする
setopt auto_pushd

# bgプロセスの状態変化を即時に知らせる
setopt notify

# 8bit文字を有効にする
setopt print_eight_bit

#pushdの履歴は残さない。
setopt pushd_ignore_dups

#ターミナルのタイトル
case "${TERM}" in
kterm*|xterm)
    precmd() {
        echo -ne "\033]0;${USER}@${HOST}\007"
    }
    ;;
esac  

# コマンドミスを修正
setopt correct

# 補完の選択を楽にする
zstyle ':completion:*' menu select

# カレントディレクトリに候補がない場合のみ cdpath 上のディレクトリを候補に出す
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

#cd は親ディレクトリからカレントディレクトリを選択しないので表示させないようにする (例: cd ../<TAB>):
zstyle ':completion:*:cd:*' ignore-parents parent pwd

# 補完候補をできるだけ詰めて表示する
setopt list_packed

#色の設定
export LSCOLORS=Exfxcxdxbxegedabagacad

# 補完時の色設定
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
autoload -U colors ; colors ; zstyle ':completion:*' list-colors "${LS_COLORS}"

# ワイルドカード展開を使用する
setopt extended_glob

#alias
case "${OSTYPE}" in
freebsd*|darwin*)
  alias ls="ls -GF"
  ;;
linux*)
  alias ls="ls -F --color"
  alias lst='ls -ltr --color=auto'
  alias ls='ls --color=auto'
  alias la='ls -la --color=auto'
  alias ll='ls -l --color=auto'
  ;;
esac
#w3mでALC検索
function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    w3m "http://www.alc.co.jp/"
  fi
}
#cdを打ったら自動的にlsを打ってくれる関数
function cd(){
    builtin cd $@ && ls;
}
#その他

#キーバインド
bindkey -e

#ビープ音ならなさない
setopt nobeep

#エディタ
export EDITOR=emacs

#改行のない出力をプロンプトで上書きするのを防ぐ
unsetopt promptcr

#個別設定を読み込む
[ -f ~/.zshrc.mine ] && source ~/.zshrc.mine
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# git設定
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{yellow}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{red}+"
zstyle ':vcs_info:*' formats "%F{green}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
# -----------------------------
# Prompt
# -----------------------------
# %M    ホスト名
# %m    ホスト名
# %d    カレントディレクトリ(フルパス)
# %~    カレントディレクトリ(フルパス2)
# %C    カレントディレクトリ(相対パス)
# %c    カレントディレクトリ(相対パス)
# %n    ユーザ名
# %#    ユーザ種別
# %?    直前のコマンドの戻り値
# %D    日付(yy-mm-dd)
# %W    日付(yy/mm/dd)
# %w    日付(day dd)
# %*    時間(hh:flag_mm:ss)
# %T    時間(hh:mm)
# %t    時間(hh:mm(am/pm))
# PROMPT='[%n][%c]'\$vcs_info_msg_0_' $ '
PROMPT='%B%F{32}~/%C%f'\$vcs_info_msg_0_' $ '
#'di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
precmd(){ vcs_info }

# 補完の選択を楽にする
zstyle ':completion:*' menu select

# ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt mark_dirs

# コマンドライン全てのスペルチェックをする
setopt correct_all

# 上書きリダイレクトの禁止
setopt no_clobber
# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# パスの最後のスラッシュを削除しない
setopt noautoremoveslash

# 各コマンドが実行されるときにパスをハッシュに入れる
setopt hash_cmds

# rsysncでsshを使用する
export RSYNC_RSH=ssh

# その他
umask 022
ulimit -c 0

# グローバルエイリアス
alias -g L='| less'
alias -g H='| head'
alias -g G='| grep'
alias -g GI='| grep -ri'

# エイリアス

alias du="du -Th"
alias df="df -Th"
alias su="su -l"
alias so='source'
alias vi='vim'
alias vz='vim ~/.zshrc'
alias c='cdr'
alias cp='cp -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias ..='c ../'
alias back='pushd'
alias diff='diff -U1'

alias tma='tmux attach'
alias tml='tmux list-window'

alias dki="docker run -i -t -P"
alias dex="docker exec -i -t"
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'

#function h {
#  history
#}

#function g() {
#  egrep -r "$1" .
#}

function t()
{
  tmux new-session -s $(pwd |sed -E 's!^.+/([^/]+/[^/]+)$!\1!g' | sed -e 's/\./-/g')
}

function psgrep() {
  ps aux | grep -v grep | grep "USER.*COMMAND"
  ps aux | grep -v grep | grep $1
}

function dstop()
{
  docker stop $(docker ps -a -q);
}

function drm()
{
  docker rm $(docker ps -a -q);
}

# Git
# -----------------------------
function gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {} | head -200'
}

function gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -200' |
  cut -d$'\t' -f1
}

function gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

