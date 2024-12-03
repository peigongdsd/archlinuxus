# archlinuxus

基于Github Actions的AUR自动打包软件仓库。

## 为什么不使用archlinuxcn？

Archlinux US软件仓库收录所有在AUR上发布但是没有直接打包的软件。我们不依赖archlinuxcn源，因为


1. 该源不可控
2. archlinuxcn源打包经常过期
3. archlinuxcn源包不全

因此我们决定制作自己的镜像源。

## 此镜像如何工作？

archlinux-us 镜像的工作原理如下：


1. 在GitHub中，有一个仓库 Neboer/archlinuxus ，该仓库结构如下
   * .github/workflow/build-push.yml 控制整个流程的脚本。
     * 脚本流程：第一步：拉一个Ubuntu镜像。
     * 第二步：参考<https://wiki.archlinux.org/title/Install_Arch_Linux_from_existing_Linux#Method_A:_Using_the_bootstrap_tarball_(recommended)> 中的教程，拉一个archlinux镜像，chroot到容器环境。
     * 第三步：参考 https://github.com/Jguer/yay#source 安装yay到系统中。
     * 第四步：签出仓库文件，用yay安装targets.txt中的每个软件，然后yay-cache-to-repo.sh制作软件仓库，最后sync-repo-to-remote.sh更新远端仓库。
   * targets.txt 每行都是一个软件名字的文件，这是更新目标。
   * yay-cache-to-repo.sh 将yay缓存制作成软件仓库的工具，它会在主机工作目录的 archlinuxus/ 下生成完整的软件仓库。
   * sync-repo-to-remote.sh 将archlinuxus/完整同步到远程主机的工具。
2. 远端仓库每次被GitHub脚本更至最新，同时仅保留最新的软件版本，不留旧包。

   远端仓库的结构如下：
   * x86_64/
     * archlinuxus.db
     * archlinuxus.db.tar.gz
     * xxx-xxx-xxx.tar.zst
     * …
3. 远端仓库工作失败，会报错，此时远端仓库不会继续更新当天的软件。任何一个错误都会导致流程彻底退出。
4. archlinux主机需要安装此仓库中的软件时，需要指定仓库地址： https://arch-mirror.us.ygg/$arch 即可。