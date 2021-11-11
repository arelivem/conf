# Installation Steps

1. Install **wget, curl, tldr, git, gcc, gdb, vim, tmux, zip, unzip**

    `sudo apt install wget curl tldr git gcc gdb vim tmux zip unzip`

2. Execute **install.sh**

    `bash install.sh`

3. Install **nvm** and **node.js**

    * open [nvm website](https://github.com/nvm-sh/nvm), follow the manual to install

    * configure default nvm version, eg (*to default to the latest LTS version*): `echo "lts/*" > .nvmrc`

    * configure source mirror [**option**]

    * install and use **node.js**

        * show node versions: `nvm ls-remote`

        * install a version: `nvm install node-version`

        * use a version: `nvm use node-version`

4. Configure **vim**

    * install plug-in: `:PlugInstall`

    * update plug-in: `:PlugUpdate`

    * update **[plug.vim](https://github.com/junegunn/vim-plug)**: `:PlugUpgrade`

    * install **[coc.nvim](https://github.com/neoclide/coc.nvim) extensions**: `CocInstall coc-sh coc-json coc-markdownlint coc-pyright coc-metals coc-clangd coc-java` for language **shell, json, markdown, python, scala, c/c++, java**

    * install **clangd.install**: `:CocCommand clangd.install`, then add **clangd** into **$PATH**

    * update **coc.nvim update extensions**: `:CocUpdate`

5. Install **anaconda**

    * download [anaconda installer](https://www.anaconda.com/products/individual#Downloads)

    * execute installer and configure conda-path [~/.local/anaconda].

    * choose **not** to **conda init**

    * cancel the **base** environment that is automatically activated every time conda starts: `conda config --set auto_activate_base false`

    * configure source mirror [**option**], profile: `~/.condarc`

    * conda usage:

        * install plug-in: `conda install nb_conda`

        * uninstall plug-in: `conda remove nb_conda` or `conda uninstall nb_conda`

        * create environment: `conda create -n py-2.7 python=2.7.15 ipykernel` or `conda create -n py-3.6 python=3.6.5 ipykernel`

        * remove environment: `conda remove -n py-2.7 --all`

        * activate environment: `conda activate py-2.7`

        * deactivate environment: `conda deactivate`

        * show python versions: `conda search python`

        * install a specific version package: `conda install package=version` or `pip install package==version`

