# ------------------------------------------------------------------------
# fzf
# ------------------------------------------------------------------------
# https://qiita.com/kamykn/items/aa9920f07487559c0c7e#:~:text=fzf%E3%81%A8%E3%81%AFCLI%E3%81%A7%E3%82%A4#:~:text=fzf%E3%81%A8%E3%81%AFCLI%E3%81%A7%E3%82%A4
# https://zenn.dev/nokogiri/articles/ec99e40df54555
# Zshのコマンド履歴からfzfを使ってコマンドを検索し、選択されたコマンドをコマンドラインに入力します。
function fzf-select-history() {
    BUFFER=$(history -n -r 1 | fzf --query "$LBUFFER" --reverse)
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N fzf-select-history

# cdrのセットアップ
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
fi

# 最近使用したディレクトリ（cdr）からfzfを使ってインタラクティブに選択し、選択したディレクトリに移動します。
function fzf-cdr() {
    local selected_dir=$(cdr -l | awk '{ print $2 }' | fzf --reverse)
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N fzf-cdr

# ------------------------------------------------------------------------
# Git
# ------------------------------------------------------------------------
# Gitブランチのチェックアウト（ローカルブランチのみ）
fbr() {
  local branches branch
  branches=$(git branch -vv) &&
  branch=$(echo "$branches" | fzf +m) &&
  git checkout $(echo "$branch" | awk '{print $1}' | sed "s/.* //")
}

# Gitブランチのチェックアウト（リモートブランチ含む）
fbrm() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# Gitコミットブラウザ
fshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# 自分のGitHub Repositoryをクエリして開く
function open-my-repos() {
    local github_username="Rockreeee"
    local selected_repo=$(curl -s https://api.github.com/users/${github_username}/repos | jq -r ".[].full_name" | fzf --height 40% --reverse)

    if [ -n "$selected_repo" ]; then
        BUFFER="open https://github.com/${selected_repo}"
        echo $BUFFER
        zle accept-line
    fi
}

# ------------------------------------------------------------------------
# oringinal
# ------------------------------------------------------------------------
# 全角文字を半角文字に変換する関数
function zsh_convert_to_halfwidth() {
    # 入力された全角文字を半角文字に変換する
    local input="$BUFFER"
    local converted=$(echo "$input" | nkf -Z)
    
    # 変換結果を表示
    BUFFER="$converted"
    
    # カーソル位置を末尾に移動
    CURSOR=$#BUFFER
    zle -R
}

# ひらがなを対応する半角英字に変換する関数
function zsh_convert_hiragana_to_english() {
    local input="$BUFFER"

    # ひらがな -> 半角英字の変換テーブル
    typeset -A hira_to_eng=(

        [しゃ]=sya [しゅ]=syu [しょ]=syo
        [ちゃ]=cha [ちゅ]=chu [ちょ]=cho
        [じゃ]=ja [じゅ]=ju [じょ]=jo

        [あ]=a [い]=i [う]=u [え]=e [お]=o
        [か]=ka [き]=ki [く]=ku [け]=ke [こ]=ko
        [が]=ga [ぎ]=gi [ぐ]=gu [げ]=ge [ご]=go
        [さ]=sa [し]=si [す]=su [せ]=se [そ]=so
        [ざ]=za [じ]=zi [ず]=zu [ぜ]=ze [ぞ]=zo
        [た]=ta [ち]=ti [つ]=tu [て]=te [と]=to
        [だ]=da [ぢ]=di [づ]=du [で]=de [ど]=do
        [な]=na [に]=ni [ぬ]=nu [ね]=ne [の]=no
        [は]=ha [ひ]=hi [ふ]=fu [へ]=he [ほ]=ho
        [ば]=ba [び]=bi [ぶ]=bu [べ]=be [ぼ]=bo
        [ぱ]=pa [ぴ]=pi [ぷ]=pu [ぺ]=pe [ぽ]=po
        [ま]=ma [み]=mi [む]=mu [め]=me [も]=mo
        [や]=ya [ゆ]=yu [よ]=yo
        [ら]=ra [り]=ri [る]=ru [れ]=re [ろ]=ro
        [わ]=wa [を]=wo [ん]=n

    )

    # ひらがなを英字に変換
    local converted="$input"

    # 複数文字の変換を優先
    for key in ${(k)hira_to_eng}; do
        # 入力文字列に変換対象が含まれていれば置換
        converted=${converted//$key/${hira_to_eng[$key]}}
    done

    # 変換結果を表示
    BUFFER="$converted"
    CURSOR=$#BUFFER
    zle -R
}

# 全角スペースを半角スペースに変換する関数
function zsh_convert_fullwidth_space_to_halfwidth() {
    local input="$BUFFER"

    # 全角スペースを半角スペースに変換
    local converted="${input//　/ }"  # 全角スペースは「　」、半角スペースは「 」

    # 変換結果を表示
    BUFFER="$converted"

    # カーソル位置を末尾に移動
    CURSOR=$#BUFFER
    zle -R
}

function zsh_convert_all() {
    zsh_convert_to_halfwidth
    zsh_convert_hiragana_to_english
    zsh_convert_fullwidth_space_to_halfwidth
}
zle -N zsh_convert_all

# git stashしたリストの中から選択し、applyする関数
function git_stash_list_action() {
    # stash list を取得して fzf で選択
    local selected_stash=$(git stash list | fzf --height=15 --prompt="Select a stash: ")

    # 選択されなかった場合は終了
    if [[ -z "$selected_stash" ]]; then
        echo "No stash selected. Aborting."
        return 1
    fi

    # 選択された stash 名を抽出 (例: 'stash@{0}')
    local stash_name=$(echo "$selected_stash" | sed -E 's/^(stash@\{[0-9]+\}):.*/\1/')

    # 操作の選択
    local action=$(echo -e "apply\npop\ndrop" | fzf --height=10 --prompt="Select an action: ")

    # 選択されなかった場合は終了
    if [[ -z "$action" ]]; then
        echo "No action selected. Aborting."
        return 1
    fi

    # 選択された操作を実行
    case "$action" in
        apply)
            git stash apply "$stash_name"
            ;;
        pop)
            git stash pop "$stash_name"
            ;;
        drop)
            git stash drop "$stash_name"
            ;;
        *)
            echo "Invalid action. Aborting."
            return 1
            ;;
    esac
}