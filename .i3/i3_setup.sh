#!/bin/bash

[[ ! -d ${GIT_REPOS} ]] && mkdir ${GIT_REPOS}

repos="
https://github.com/horst3180/Vertex-Icons.git
https://github.com/m13253/BiliDan.git
https://github.com/PeterDing/iScript.git
https://github.com/xyl0n/iris-light.git
https://github.com/soimort/you-get.git
https://github.com/NitruxSA/flattr-icons.git
"

for repo in $repos; do
    repo_dir_name=`echo $repo | sed "s#.*\/\(.*\)\.git#\1#"`
    repo_dir=${GIT_REPOS}/$repo_dir_name
    [[ -d $repo_dir ]] && continue
    echo -e "\e[36mPull $repo\e[0m"
    cd ${GIT_REPOS}
    git clone $repos
done

# set theme
echo -e "\e[36mInstall themes\e[0m"
[[ ! -d ~/.icons ]] && mkdir ~/.icons
ln -svf ${GIT_REPOS}/Vertex-Icons ~/.icons/

[[ ! -d ~/.themes ]] && mkdir ~/.themes
ln -svf ${GIT_REPOS}/iris-light ~/.themes/

# if [ ! -e ~/.vim/bundle/Vundle.vim/.git ]; then
    # echo  -e "\e[36mInstall Vundle\e[0m"
    # git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    # vim +PluginInstall! +PluginClean +qall
# else
    # echo  -e "\e[36mUpdate Vundle\e[0m"
    # cd ~/.vim/bundle/Vundle.vim && git pull origin master
# fi

# cd  ~/.vim/bundle/YouCompleteMe
# python install.py --clang-completer --system-libclang
# END
