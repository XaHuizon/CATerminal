#!/data/data/com.termux/files/usr/bin/bash
# 调节>
cd /data/data/com.termux/files/home
CPUNAME=$(cat /proc/cpuinfo | grep "Hardware" | sed 's/H[^: ]*: //g' | sed 's/, /-/g')
MD5="/data/data/com.termux/files/usr"
OSV=$(getprop ro.build.version.release)
CPUUN=$(grep -o 'processor' /proc/cpuinfo | wc -l)
DEVONE=$(getprop ro.product.device)
DEVTWO=$(getprop ro.product.model)
UINAME=$(getprop ro.build.display.id)
KERNEL=$(uname -r)
ABLOCK=$(getprop ro.build.ab_update)
WIFI=$(getprop gsm.version.baseband | sed 's/,.*//' | sed 's/,//g')
BASE_BAK=$(echo  | base64 -d)
BASE_OK=$(echo  | base64 -d)
AVB() {
if [ "$ABLOCK" = "true" ]
then
    AORB=$(getprop ro.boot.slot_suffix)
    AB_YN=支持
    if [ "$AORB" = "_a" ]
    then
        ECHO_AB="\033[0;33;1mAVB分区:\033[0;32;1m$AB_YN-当前A分区\033[0m"
    elif [ "$AORB" = "_b" ]
    then
        ECHO_AB="\033[0;33;1mAVB分区:\033[0;32;1m$AB_YN-当前B分区\033[0m"
    else
        ECHO_AB="\033[0;33;1mAVB分区:\033[0;32;1m$AB_YN-当前分区未知\033[0m"
    fi
else
    ECHO_AB="\033[0;33;1mAVB分区:\033[0;32;1m不支持\033[0m"
fi
AVB="$ECHO_AB"
echo -e "$ECHO_AB"
}
NOWV_="V_5.3.6-Official正式版"
THE_LOG="/storage/emulated/0/Termux_Log/Termux.log"
THE_LOG_PATH="/storage/emulated/0/Termux_Log/"
# -------------填充函数->>
REBOOTCA() {
    echo
    echo -e -n "$COLOR[CA]\033[0;33;1m点按回车返回主页\033[0m"
    read
    echo -e -n "\033[0;33;1m [-]返回主页...\033[0m\r"
    sleep 0.5
    exec bash "$0"
}
SUREBOOT() {
    echo -e -n "\033[0;33;1m [-]返回主页...\033[0m\r"
    sleep 0.5
    exec bash "$0"
}
REBOOT_RE() {
    read
    echo -e -n "\033[0;33;1m [-]返回主页...\033[0m\r"
    sleep 0.5
    exec bash "$0"
}
ECHO_HEAD() {
    clear
    echo -e "\033[0;30;1m___________________________________________________________\033[0m"
    echo -e "\033[0;33;1m--〔 -$COLOR『CA终端』\033[0;33;1m≡≡ \033[0;32;1m[当前版本>$NOWV_]\033[0;33;1m - 〕--\033[0m"
}
ECHO_ALL_DEV() {
    sleep 0.1
    echo -e -n "$COLOR   ______  _     |\033[0m"
    echo -e "\033[0;33;1m设备:\033[0;32;1m$DEVTWO ($DEVONE)\033[0m"
    sleep 0.04
    echo -e -n "$COLOR  / ____/ / \\    |\033[0m"
    echo -e "\033[0;33;1mCPU:\033[0;32;1m$CPUNAME\033[0;33;1m/核心:\033[0;32;1m$CPUUN核\033[0m"
    sleep 0.04
    echo -e -n "$COLOR  | |    / | \\   |\033[0m"
    echo -e "\033[0;33;1m内核:\033[0;32;1m$KERNEL\033[0m"
    sleep 0.04
    echo -e -n "$COLOR  | |___/ ___ \\  |\033[0m"
    echo -e "\033[0;33;1m基带:\033[0;32;1m$WIFI\033[0m"
    sleep 0.04
    echo -e -n "$COLOR  \\____/_/   \\_\\ |\033[0m"
    echo -e "\033[0;33;1m系统:\033[0;32;1m$UINAME\033[0;33;1m/\033[0;32;1mAndroid $OSV\033[0m"
    echo -e "\033[0;30;1m===========================================================\033[0m"
    sleep 0.5
    echo -e "$COLOR[CA]\033[0;33;1m当前时间:[\033[0;32;1m$(date +%Y.%m.%d) - $(date +%H:%M:%S)\033[0;33;1m] Ξ \033[0;33;1m当前用户UID:[$COLOR$UID\033[0;33;1m]\033[0m"
}
ECHO_COM_A() {
    echo -e "$COLOR[>_]\033[0;33;1m在这里可以输入Termux中的命令 并且支持ROOT模式与普通模式互换\033[0m"
    echo -e "\033[0;32;1m[>]\033[0;33;1m部分常用命令 >>\033[0m"
    echo -e "\033[0;33;1m - 换源:\033[0;36;1m termux-change-repo \033[0;33;1m- 请求存储: \033[0;36;1mtermux-setup-storage\033[0m"
    echo -e "\033[0;33;1m - 查询: \033[0;36;1mpkg search [名称]\033[0;33;1m  - 切换ROOT: \033[0;36;1msu/tsu/sudo\033[0m"
    echo -e "\033[0;33;1m - 恢复工作目录: \033[0;36;1mtermux-path\033[0m"
    echo
}
termux-path() {
if cd /data/data/com.termux/files/home
then
    echo -e "\033[0;32;1m - 成功切换为原工作目录:\033[0;36;1m$(pwd)\033[0m"
else
    echo -e "\033[0;31;1m - 切换原工作目录失败 当前工作目录:\033[0;36;1m$(pwd)\033[0m"
fi
}
# ------函数填充到此为止->>
if [ "$UID" = "0" ]
then
     COLOR="\033[0;31;1m"
     ISROOT="\033[0;31;1m#\033[0;32;1m"
else
     COLOR="\033[0;36;1m"
     ISROOT="\033[0;36;1m$\033[0;32;1m"
fi
ECHO_HEAD
if [ "$PREFIX" = "$MD5" ]
then
    if [ -f "TSU_IS_OKAY" ] && [ -f "$THE_LOG" ]
    then
        LOGKB=$(stat -c%s "$THE_LOG")
        if [ $LOGKB -gt 10240 ]
        then
            echo "" &>$THE_LOG
        fi
        mkdir -p $THE_LOG_PATH
        touch $THE_LOG &>>$THE_LOG
    else
        echo -e -n "$COLOR [CA]\033[0;33;1m正在初始化CA终端 稍等...\033[0m\r"
        mkdir -p $THE_LOG_PATH
        touch $THE_LOG &>>$THE_LOG
        pkg install tsu -y &>>$THE_LOG
        pkg install git -y &>>$THE_LOG
        termux-setup-storage -y &>>$THE_LOG
        touch TSU_IS_OKAY &>>$THE_LOG
    fi
else
    ECHO_ALL_DEV
    echo -e "\033[0;31;1m -! 必须以Termux运行\033[0m"
    echo -e "\033[0;33;1m[>_]在Termux中输入' \033[0;36;1mbash $0 \033[0;33;1m'命令即可使用\033[0m"
    echo -e -n "\033[0;32;1m[>]\033[0;33;1m点按回车跳转至Termux\033[0m"
    read
    NO_SEE_AM=$(su -c am start com.termux/com.termux.app.TermuxActivity )
    exit 0
fi
ECHO_ALL_DEV
echo -e "\033[0;35;1m[>_]\033[0;33;1m›1*-\033[0;36;1m命令行界面\033[0;35;1m[?]\033[0;33;1m›2*-\033[0;36;1m关于/帮助 \033[0;35;1m [#]\033[0;33;1m›3*-\033[0;36;1m切换ROOT模式\033[0m"
echo -e "\033[0;35;1m[RE]\033[0;33;1m›4*-\033[0;36;1m重启CA终端\033[0;35;1m[GAME]\033[0;33;1m›5*-\033[0;36;1m小游戏\033[0;35;1m \033[0;35;1m [PKG]\033[0;33;1m›6*-\033[0;36;1m安装Termux包\033[0m"
echo -e "\033[0;35;1m[FX]\033[0;33;1m›7*-\033[0;36;1m固化CA终端\033[0;35;1m[NEW]\033[0;33;1m›8*-\033[0;36;1m更新日志\033[0;35;1m [LOG]\033[0;33;1m›9*-\033[0;36;1m运行日志\033[0m"
echo -e "\033[0;35;1m[E]\033[0;33;1m›10*-\033[0;36;1m切换Termux源为国内清华镜像源\033[0;35;1m[X]\033[0;33;1m›11*-\033[0;36;1m退出CA终端\033[0m"
echo -e "\033[0;35;1m[ADB]\033[0;33;1m›12*-\033[0;36;1m为Termux提供ShizukuADB支持\033[0;35;1m[UP]\033[0;33;1m›13*-\033[0;36;1m云更新CA终端\033[0m"
echo -e -n "\033[0;33;1m->输入选项*ᐷ\033[0;1m"
read CAONE
echo -e "\033[0;37;1m------------------------------\033[0m"
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
if [ "$CAONE" = "1" ] || [ "$CAONE" = ">_" ] || [ "$CAONE" = "命令行界面" ]
then
    echo -e -n " $COLOR[CA]\033[0;33;1m打开命令行界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    ECHO_COM_A
    while true
    do
    echo -e -n "$COLOR[CA]\033[0;32;1m输入命令*$ISROOT>\033[0;1m"
    read EXEC
    if [ "$EXEC" = "exit" ]
    then
        echo -e "\033[0;35;1m[EXIT]\033[0;33;1m即将退出命令行界面并返回主页\033[0m"
        SUREBOOT
    elif [ "$(echo $EXEC | cut -c1-2)" = "cd" ]
    then
        EXEC_CD=$(echo $EXEC | sed 's/cd //g')
        if cd $EXEC_CD &>>$THE_LOG
        then
            echo -e "\033[0;35;1m[CD]\033[0;33;1m已定位至'\033[0;36;1m$(pwd)\033[0;33;1m'目录\033[0m"
        else
            echo -e "\033[0;35;1m[CD]\033[0;33;1m无法定位至'\033[0;36;1m$EXEC_CD\033[0;33;1m'目录\033[0m"
            echo -e "\033[0;33;1m[建议]\033[0;36;1m检查拼写是否正确或是否已授予Termux存储访问权限\033[0m"
        fi
    elif [ "$EXEC" = "clear" ]
    then
        echo -e -n "\033[0;35;1m [EXIT]\033[0;33;1m正在重置...\033[0m\r"
        sleep 0.3
        ECHO_HEAD
        ECHO_ALL_DEV
        ECHO_COM_A
    elif [ "$EXEC" = "ls" ]
    then
        echo -e "\033[0;35;1m[LS]\033[0;33;1m文件/权限列表 >>\033[0m"
        ECHO_TIME_LS=$(timeout 3 ls)
        if [ "$?" = "124" ]
        then
            echo -e "\033[0;31;1m[!]\033[0;33;1mls命令超时未列出列表 已强制终止\033[0m"
            continue
         fi
         echo -e "\033[0;36;1m$(echo -e "$ECHO_TIME_LS" | sed 's/^/ - /')\033[0m"
         continue
    elif [ "$EXEC" = "su" ] || [ "$EXEC" = "tsu" ] || [ "$EXEC" = "sudo" ]
    then
        ECHOSUDO_A=$(sudo echo | head -c 2)
        THESUDO_A="No"
        if [ "$ECHOSUDO_A" = "$THESUDO_A" ]
        then
            echo -e "\033[0;31;1m[!]\033[0;33;1m没有获取到ROOT权限 无法使用该命令\033[0m"
            continue
        fi
        if [ "$UID" = "0" ]
        then
            echo -e "\033[0;33;1m[-]已是ROOT模式无需切换\033[0m"
            continue
        fi
        echo -e "\033[0;35;1m[SU]\033[0;33;1m已切换至\033[0;31;1mROOT\033[0;33;1m模式\033[0m"
        while true
        do
            echo -e -n "\033[0;31;1m[CA]\033[0;32;1m输入命令*#>\033[0;1m"
            read EXEC_A
            if [ "$EXEC_A" = "exit" ]
            then
                echo -e "\033[0;35;1m[EXIT]\033[0;33;1m即将退出命令行界面并返回主页\033[0m"
                SUREBOOT
            elif [ "$(echo $EXEC_A | cut -c1-2)" = "cd" ]
            then
                EXEC_CD_A=$(echo $EXEC_A | sed 's/cd //g')
                if cd $EXEC_CD_A &>>$THE_LOG
                then
                    echo -e "\033[0;35;1m[CD]\033[0;33;1m已定位至'\033[0;36;1m$(pwd)\033[0;33;1m'目录\033[0m"
                else
                    echo -e "\033[0;35;1m[CD]\033[0;33;1m无法定位至'\033[0;36;1m$EXEC_CD_A\033[0;33;1m'目录\033[0m"
                    echo -e "\033[0;33;1m[建议]\033[0;36;1m检查拼写是否正确或是否已授予Termux存储访问权限\033[0m"
                fi
            elif [ "$EXEC_A" = "ls" ]
            then
                echo -e "\033[0;35;1m[LS]\033[0;33;1m文件/权限列表 >>\033[0m"
                ECHO_TIME_LS_SU=$(timeout 3 ls)
                if [ "$?" = "124" ]
                then
                    echo -e "\033[0;31;1m[!]\033[0;33;1mls命令超时未列出列表 已强制终止\033[0m"
                    continue
                fi
                echo -e "\033[0;36;1m$(echo -e "$ECHO_TIME_LS_SU" | sed 's/^/ - /')\033[0m"
                continue
            elif [ "$EXEC_A" = "clear" ]
            then
                echo -e -n "\033[0;35;1m [CLEAR]\033[0;33;1m正在重置...\033[0m\r"
                sleep 0.3
                ECHO_HEAD
                ECHO_ALL_DEV
                ECHO_COM_A
            elif [ "$EXEC_A" = "su" ] || [ "$EXEC_A" = "tsu" ] || [ "$EXEC_A" = "sudo" ]
            then
                echo -e "\033[0;31;1m[!]\033[0;33;1m此处无法使用'\033[0;36;1m$EXEC_A\033[0;33;1m'命令\033[0m"
            else
                echo -e -n "\033[0;32;1m[>]输出:\033[0;37;1m"
                sudo $EXEC_A | tee -a $THE_LOG
                PVCEXEC_A=${PIPESTATUS[0]}
                if [ "$PVCEXEC_A" = "0" ]
                then
                    echo -e "\033[0;32;1m - 运行成功\033[0m"
                else
                    echo -e "\033[0;31;1m -! 执行失败\033[0m"
                fi
            fi
        done
    else
        echo -e -n "\033[0;32;1m[>]输出:\033[0;37;1m"
        eval "$EXEC" | tee -a $THE_LOG
        PVCEXEC=${PIPESTATUS[0]}
        if [ "$PVCEXEC" = "0" ]
        then
            echo -e "\033[0;32;1m - 运行成功\033[0m"
        else
            echo -e "\033[0;31;1m -! 执行失败\033[0m"
        fi
    fi
    done
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "2" ] || [ "$CAONE" = "?" ] || [ "$CAONE" = "关于/帮助" ]
then
    echo -e -n "$COLOR [CA]\033[0;33;1m正在打开关于/帮助界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[?]\033[0;33;1m在'关于/帮助'中可以查看CA终端的开发背景以及一些常见问题解答\033[0m"
    echo
    echo -e "\033[0;33;1m[-关于-] >>\033[0m"
    echo -e "\033[0;32;1m[CA][当前版本>$NOWV_]\033[0m"
    echo -e "\033[0;33;1m[ - CA终端作者: \033[0;36;1mks\033[0;33;1m/\033[0;36;1mbilibili\033[0;33;1m \033[0;35;1m*Mi丶XaFlash \033[0;33;1m- ]\033[0m"
    echo -e "\033[0;33;1m -〔\033[0;32;1m (</>)\033[0;36;1m 本脚本允许任何人随意查看/修改代码\033[0;33;1m 〕-\033[0m"
    echo
    echo -e "\033[0;36;1m[-CA终端介绍-]:\033[0;33;1m一个在\033[0;36;1;4mTermux\033[0;33;1m中运行的\033[0;36;1;4m脚本终端\033[0;33;1m，该终端的开发旨在帮助Android系统的Termux用户能够\033[0;36;1;4m更加轻松\033[0;33;1m地使用Termux终端模拟器，在这里\033[0;36;1;4m无需记住\033[0;33;1mTermux终端的\033[0;36;1;4m任何特殊命令/代码\033[0;33;1m，提供了\033[0;36;1;4m全自动\033[0;33;1m的终端使用体验，即使对Termux终端模拟器\033[0;36;1;4m完全不懂\033[0;33;1m的小白也能够在CA终端中的一些引导下\033[0;36;1;4m慢慢学会\033[0;33;1mTermux的一些使用技巧，对于一些本身就熟练使用Termux终端模拟器的用户更是\033[0;36;1;4m如虎添翼\033[0m"
    echo
    echo -e "\033[0;33;1m[-帮助-] >>\033[0m"
    echo -e "\033[0;36;1m[问]:在'安装Termux软件包'中总安装失败?\033[0m"
    echo -e "\033[0;32;1m[答]:如果该Termux软件包确实存在于Termux服务器中 那么先检查安装的软件包是否存在拼写错误 如果拼写正确则尝试配置魔法环境 如果该软件包为'wget https://...'格式那么需要在'命令行界面'中安装\033[0m"
    echo -e "\033[0;36;1m[问]:不能从ROOT模式切换为普通模式?\033[0m"
    echo -e "\033[0;32;1m[答]:目前CA终端暂不支持从ROOT模式切换至普通模式 如确实需要切换模式那么可以在主页输入'6'退出CA终端后再手动启动CA终端(不要使用su/sudo/tsu命令以ROOT权限启动)即可从ROOT模式切换为普通模式\033[0m"
    echo -e "\033[0;36;1m[问]:在固化终端后如何更新已经固化的CA终端?\033[0m"
    echo -e "\033[0;32;1m[答]:目前暂不支持直接对已固化的CA终端进行更新，如果需要更新那么可以在主页输入'1'进入'命令行界面' 然后在'命令行界面'中输入' bash (需要更新的新版本CA终端完整路径) '并在新版本的CA终端界面输入'3'进入'固化CA终端'功能进行固化即可完成更新\033[0m"
    REBOOTCA
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "3" ] || [ "$CAONE" = "#" ] || [ "$CAONE" = "切换ROOT模式" ]
then
    echo -e -n "$COLOR [CA]\033[0;33;1m正在打开切换ROOT界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[#]\033[0;33;1m目前仅支持对ROOT模式单向切换 如需从ROOT模式切换为普通模式需在主页退出CA终端后再手动启动CA终端(不要使用ROOT启动)\033[0m"
    echo
    if [ "$UID" = "0" ]
    then
        echo -e "\033[0;31;1m[CA]\033[0;33;1m当前用户UID:[\033[0;31;1m$UID\033[0;33;1m]-$COLOR已是ROOT权限\033[0m"
        echo -e -n "\033[0;33;1m[-]无需切换为ROOT权限 点按回车返回主页\033[0m"
        REBOOT_RE
    else
        echo -e "\033[0;36;1m[CA]\033[0;33;1m当前用户UID:[\033[0;36;1m$UID\033[0;33;1m]-$COLOR非ROOT权限\033[0m"
        echo -e "\033[0;33;1m[-]是否切换至ROOT权限并重启CA终端 >>\033[0m"
        echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
        read YN_A
        if [ "$YN_A" = "1" ]
        then
            echo -e -n "\033[0;33;1m[提示]\033[0;36;1m在切换至ROOT权限后如需切换回普通权限则需要先输入'6'退出CA终端后再手动启动CA终端 \033[0;33;1m点按回车继续\033[0m"
            read
            echo -e "\033[0;31;1m[CA]\033[0;33;1m正在切换至\033[0;31;1mROOT\033[0;33;1m权限...\033[0m"
            sleep 0.5
            ECHOSUDO=$(sudo echo | head -c 2)
            THESUDO="No"
            if [ "$ECHOSUDO" = "$THESUDO" ]
            then
                echo -e "\033[0;31;1m[!]\033[0;33;1m当前设备没有ROOT或没有为Termux授予ROOT权限\033[0m"
                echo -e "\033[0;33;1m[建议]\033[0;36;1m检查是否已为Termux授予ROOT权限\033[0m"
                REBOOTCA
            fi
            sudo bash "$0"
        else
            echo -e "\033[0;33;1m[×]\033[0;36;1m已取消切换至ROOT权限\033[0m"
            REBOOTCA
        fi
    fi
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "4" ] || [ "$CAONE" = "RE" ] || [ "CAONE" = "重启CA终端" ]
then
    echo -e "$COLOR[CA]\033[0;33;1m重启CA终端\033[0m"
    SUREBOOT
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "5" ] || [ "$CAONE" = "GAME" ] || [ "$CAONE" = "小游戏" ]
then
    echo -e -n " $COLOR[CA]\033[0;33;1m正在打开小游戏界面...\033[0m\r"
    sleep 0.3
    while true
    do
        ECHO_HEAD
        ECHO_ALL_DEV
        echo -e "$COLOR[GAME]\033[0;33;1m在Termux服务器中的一些小游戏命令都可以直接通过输入对应选项进入游戏\033[0m"
        echo
        if [ -f "GAME_IS_OKAY" ]
        then
            sleep 0
        else
            echo -e "\033[0;35;1m[NOT]\033[0;33;1m该功能暂未初始化 是否立即初始化 >>\033[0m"
            echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
            read GAME_YN
            if [ "$GAME_YN" = "1" ]
            then
                echo -e "\033[0;33;1m->正在初始化小游戏功能[需要一些时间]...\033[0m"
                pkg install pacman4console -y &>>$THE_LOG
                pkg install bastet -y &>>$THE_LOG
                pkg install moon-buggy -y &>>$THE_LOG
                echo -e "\033[0;32;1m - 小游戏功能初始化完成\033[0m"
                touch GAME_IS_OKAY
                echo
                echo -e -n "$COLOR[CA]\033[0;33;1m点按回车进入菜单 输入'1'返回主页\033[0m"
                read YN_GA
                if [ "$YN_GA" = "1" ]
                then
                    SUREBOOT
                fi
                continue
            else
                echo -e -n "$COLOR[CA]\033[0;33;1m已取消初始化 点按回车返回主页\033[0m"
                REBOOT_RE
            fi
        fi
        echo -e "\033[0;33;1m[GAME]已支持的小游戏列表 >>\033[0m"
        echo -e "\033[0;36;1m›1*-俄罗斯方块 \033[0;33;1m[ \033[0;32;1mbasdet\033[0;33;1m ]\033[0m"
        echo -e "\033[0;36;1m›2*-赛车弹跳 \033[0;33;1m[ \033[0;32;1mmmoon-buggy\033[0;33;1m ]\033[0m"
        echo -e "\033[0;36;1m›3*-吃豆人 \033[0;33;1m[ \033[0;32;1mpacman4console\033[0;33;1m/\033[0;32;1mpacmanplay \033[0;33;1m]\033[0m"
        echo -e "\033[0;35;1m›4*-返回主页\033[0m"
        echo -e -n "\033[0;33;1m[>_]输入选项*ᐷ\033[0;1m"
        read GAME_CA
        echo -e "\033[0;33;1m[提示]\033[0;36;1m使用终端的'CLRL'与键盘的'C'键可强制退出游戏\033[0m"
        echo
        if [ "$GAME_CA" = "1" ]
        then
            echo -e "\033[0;33;1m[-俄罗斯方块玩法介绍-]:\033[0;36;1m进入界面后使用终端中的上下键选择选项，Play有两个难度可选(Normal为简单模式可以看到下个方块是什么，Harder为困难模式看不到下个方块是什么)，View highscores选项可以查看历史分数，Quit选项可退出游戏，回车键确定; 进入游戏后使用左右键可以左右移动方块，下键可以快速下落，上键可以切换方块形状\033[0m"
            echo -e -n "\033[0;35;1m[PLAY]\033[0;33;1m充分了解后点击回车进入游戏\033[0m"
            read
            bastet
        elif [ "$GAME_CA" = "2" ]
        then
            echo -e "\033[0;33;1m[-赛车弹跳玩法介绍-]:\033[0;36;1m进入界面后点击任意键可直接进入游戏，游戏中的车辆形状为控制对象，遇到地面缺陷时点击空格可跳跃，点按L键可发射子弹\033[0m"
            echo -e -n "\033[0;35;1m[PLAY]\033[0;33;1m充分了解后点击回车进入游戏\033[0m"
            read
            moon-buggy
        elif [ "$GAME_CA" = "3" ]
        then
           echo -e "\033[0;33;1m[-吃豆人玩法介绍-]:\033[0;36;1m进入界面后等待加载完成自动进入游戏，在游戏中有一个淡黄色'C'符号，它就是控制对象，游戏中需要使用上下左右键让其在迷宫中吃豆，在中间部分会有彩色的'&'符号，在游戏中吃豆时需要避免被它们抓到\033[0m"
           echo -e -n "\033[0;35;1m[PLAY]\033[0;33;1m充分了解后点击回车进入游戏\033[0m"
            read
            pacmanplay
        else
            REBOOTCA
        fi
        echo -e "\033[0;32;1m[>]已退出游戏\033[0m"
        echo
        echo -e -n "$COLOR[CA]\033[0;33;1m点按回车返回主页 输入'1'重新进入菜单:\033[0;1m"
        read YN_M
        if [ "$YN_M" = "1" ]
        then
            continue
        fi
        SUREBOOT
    done
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "6" ] || [ "$CAONE" = "PKG" ] || [ "$CAONE" = "安装Termux软件包" ]
then
    echo -e -n " $COLOR[CA]\033[0;33;1m正在打开安装Termux软件包界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[PKG]\033[0;33;1m安装Termux软件包时确保要安装的软件包确实存在于Termux的库中 一些特殊的软件包(例如'\033[0;36;1mwget https://...\033[0;33;1m'或'\033[0;36;1mgit clone https://...\033[0;33;1m')需要在'命令行界面'中安装\033[0m"
    echo
    if [ "$UID" = "0" ]
    then
        echo -e "\033[0;31;1m[!]\033[0;36;1mROOT模式无法使用'安装Termux软件包'功能 切换为普通模式后再尝试进入页面\033[0m"
        REBOOTCA
    fi
    echo -e "\033[0;35;1m[YN]\033[0;33;1m选择一个包管理器 >>\033[0m"
    echo -e -n "\033[0;36;1m[1›PKG/2›APT/3›PIP/4›退出]*ᐷ\033[0;1m"
    read APT_YN
    if [ "$APT_YN" = "1" ] || [ "$APT_YN" = "PKG" ]
    then
        AG_UPAE() {
            pkg update -y &>>$THE_LOG
            pkg upgrade -y &>>$THE_LOG
        }
        AG_INSTALL() {
            pkg install $PKGINSTALL -y &>>$THE_LOG
        }
        PKG_OR_APT="pkg"
        AKGT="PKG"
        TE_OR_PY="Termux"
    elif [ "$APT_YN" = "2" ] || [ "$APT_YN" = "APT" ]
    then
        AG_UPAE() {
            apt update -y &>>$THE_LOG
            apt upgrade -y &>>$THE_LOG
        }
        AG_INSTALL() {
            apt install $PKGINSTALL -y &>>$THE_LOG
        }
        PKG_OR_APT="apt"
        AKGT="APT"
        TE_OR_PY="Termux"
    elif [ "$APT_YN" = "3" ] || [ "$APT_YN" = "PIP" ]
    then
        AG_UPAE() {
            apt install python -y &>>$THE_LOG
            pkg install python -y &>>$THE_LOG
        }
        AG_INSTALL() {
            pip install $PKGINSTALL -y &>>$THE_LOG
        }
        PKG_OR_APT="pip"
        AKGT="PIP"
        TE_OR_PY="python"
    else
        echo -e "$COLOR[CA]\033[0;33;1m正在返回主页...\033[0m"
        SUREBOOT
    fi
    echo -e "\033[0;33;1m->正在更新软件包管理服务...\033[0m"
    AG_UPAE
    echo -e "\033[0;32;1m - 软件包管理服务更新完成\033[0m"
    while true
    do
        echo -e "\033[0;35;1m[$AKGT]\033[0;33;1m输入要安装的$TE_OR_PY软件包名称 >>\033[0m"
        echo -e -n "\033[0;36;1m[>_]输入名称:\033[0;32;1m$PKG_OR_APT install \033[0;1m"
        read PKGINSTALL
        echo -e "\033[0;33;1m->正在安装$PKGINSTALL...\033[0m"
        AG_INSTALL
        YN_B=$(tail -n 1 "$THE_LOG" | cut -c1)
        if [ "$YN_B" = "E" ]
        then
            echo -e "\033[0;31;1m -! $PKGINSTALL软件包安装失败\033[0m"
            echo -e "\033[0;33;1m[可能/建议]:\033[0;36;1m确保在Termux的仓库中确实存在该Termux软件包 如果确认存在可以尝试使用魔法环境或换为国内清华镜像源再试一次\033[0m"
            echo
            echo -e -n "$COLOR[CA]\033[0;33;1m点按回车继续安装Termux软件包 输入'1'返回主页:\033[0;1m"
            read YN_T
            if [ "$YN_T" = "1" ]
            then
                SUREBOOT
            fi
        else
            echo -e "\033[0;32;1m - $PKGINSTALL软件包安装成功\033[0m"
            echo -e -n "$COLOR[CA]\033[0;33;1m点按回车继续安装Termux软件包 输入'1'返回主页:\033[0;1m"
            read YN_Y
            if [ "$YN_Y" = "1" ]
            then
                SUREBOOT
            fi
        fi
    done
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "7" ] || [ "$CAONE" = "CA" ] || [ "$CAONE" = "固化CA终端" ]
then
    echo -e -n "$COLOR [CA]\033[0;33;1m正在打开固化CA终端界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[FX]\033[0;33;1m固化CA终端将直接替换Termux的欢迎启动界面 每次打开Termux时将自动进入CA终端 在执行前确保已备份Termux以便出现问题时能恢复修改 \033[0;36;1m更新CA终端需进入'命令行界面'后使用'bash (新版本CA终端的完整路径)'命令\033[0m"
    echo
    if [ "$0" = "/data/data/com.termux/files/usr/bin/CA" ]
    then
        echo -e "\033[0;31;1m[!]\033[0;33;1m当前状态无法使用固化功能 如需更新可前往'命令行界面'输入' bash (新版本CA终端的完整路径) '后在新版本CA终端中使用固化进行更新\033[0m"
        REBOOTCA
    fi
    BASHRCPA="/data/data/com.termux/files/usr/etc/bash.bashrc"
    TERMUX_CA="\033[0;33;1m[建议]\033[0;36;1m检查目标文件是否已存在或原文件是否被意外删除 不要在Termux启动时自动打开的CA终端中进入固化功能 更新CA终端需进入'命令行界面'后使用'bash (新版本CA终端的完整路径)'命令 均无效可尝试切换CA终端为ROOT模式\033[0m"
    echo -e "\033[0;33;1m[-]是否立即开始固化CA终端 >>\033[0m"
    echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
    read YN_C
    if [ "$YN_C" = "1" ]
    then
        echo -e "\033[0;33;1m[>]开始固化CA终端...\033[0m"
        BASHNAME=$(basename $0 | sed 's/终端.bash//g')
        OKPATH="/data/data/com.termux/files/usr/bin/$BASHNAME"
        cp "$0" "$OKPATH" &>>$THE_LOG
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 成功命令化文件\033[0m"
        else
            echo -e "\033[0;31;1m -! 命令化文件失败\033[0m"
            echo -e "$TERMUX_CA"
            REBOOTCA
        fi
        MD5TORC=$(cat $BASHRCPA | grep "CA")
        if [ -z "$MD5TORC" ]
        then
            echo " # okay" &>>$BASHRCPA
            echo "CA # 启动CA终端" &>>$BASHRCPA
            if [ "$?" = "0" ]
            then
                echo -e "\033[0;32;1m - 成功修改启动文件\033[0m"
            else
                echo -e "\033[0;31;1m -! 启动文件修改失败\033[0m"
                echo -e "$TERMUX_CA"
                REBOOTCA
            fi
        else
            echo -e "\033[0;32;1m - 启动文件已修改跳过该步骤\033[0m"
        fi
        echo "" &>/data/data/com.termux/files/usr/etc/motd
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 成功修改启动界面\033[0m"
        else
            echo -e "\033[0;31;1m -! 启动界面修改失败\033[0m"
            echo -e "$TERMUX_CA"
            REBOOTCA
        fi
        chmod +x /data/data/com.termux/files/usr/bin/CA
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 成功赋予执行权限\033[0m"
        else
            echo -e "\033[0;31;1m -! 执行权限赋予失败\033[0m"
            echo -e "$TERMUX_CA"
            REBOOTCA
        fi
        echo -e "\033[0;32;1m[-]\033[0;33;1m成功固化CA终端 此后每次启动Termux时将自动打开CA终端\033[0m"
        REBOOTCA
    else
        echo
        echo -e -n "$COLOR[CA]\033[0;33;1m已取消固化CA终端 点按回车返回主页\033[0m"
        REBOOT_RE
    fi
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "8" ] || [ "$CAONE" = "NEW" ] || [ "$CAONE" = "更新日志" ]
then
    WHILE_NEW() {
        echo -e -n "\033[0;33;1m[>_]输入要查找日志的版本号*ᐷ\033[0;1m"
        read OK_NEW
        if echo "$OK_NEW" | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' >>log
        then
            sleep 0
        else
            echo -e "\033[0;31;1m[!]\033[0;33;1m只有输入符合\033[0;36;1m1.0.0\033[0;33;1m格式的版本号才能进行搜索\033[0m"
            echo -e -n "\033[0;33;1m[-]输入'1'重新搜索 点按回车返回主页:\033[0;1m"
            read YN_W
            if [ "$YN_W" = "1" ]
            then
                echo
                WHILE_NEW
            else
                SUREBOOT
            fi
        fi
    }
    ALL_NEW="[版本]>V_1.3.2-Debug调试版
 - 初步完成'CA'图案打印
 - 初步完成菜单
 - 基本结构已确认
[版本]>V_1.7.3-Debug调试版
 - 命令行界面基本完成
[版本]>V_1.7.5-Debug调试版
 - 修复命令行界面中无法执行命令
[版本]>V_1.7.7-Debug调试版
 - 优化菜单界面 使菜单不在杂乱
[版本]>V_1.9.2-Debug调试版
 - 完善'安装Termux软件包'功能
 - 进一步完善命令行功能
 - 完善从普通权限切换为ROOT权限
 - 完善'关于'页面
 - 菜单中新增'切换清华源'功能[待完善]
 - 优化整体界面美观度
[版本]>V_1.9.3-Beta2测试版
 - 修改版本号
[版本]>V_1.9.4-Beta2测试版
 - 修复无法切换权限
[版本]>V_1.9.6-Beta2测试版
 - 修复切换ROOT权限取消后直接退出CA终端
[版本]>V_2.1.4-Beta3测试版
 - 将'检测更新'替换为'固化CA终端'并完善功能
 - 修复命令行界面每个命令都报错的bug
 - 优化整体界面美观度
[版本]>V_2.4.3-Beta3测试版
 - 完善'为Termux提供Shizuku ADB'功能
 - 新增除了序号外输入符号也能进入对应功能
 - 修复一些已知问题
[版本]>V_3.0.0-Official正式版
 - 修复一些bug
 - 更换版本为正式版
[版本]>V_3.1.2-Official正式版
 - 更换固化CA终端逻辑
 - 优化整体界面美观度
 - 修复部分已知问题
[版本]>V_3.4.1-Official正式版
 - 优化'更新日志'界面美观度
 - 将部分代码替换为函数
 - 新增'查看日志'
[版本]>V_3.4.2-Official正式版
 - 修复查看日志后未经回车立即返回主页
[版本]>V_3.4.5-Official正式版
 - 修复命令行界面中本该报错的命令没有报错
[版本]>V_3.4.8-Official正式版
 - 优化命令行界面输入一些命令后需执行完毕后才能回显
[版本]>V_3.5.0-Official正式版
 - 优化了日志写入
 - 修复读取tee退出码导致本该报错的命令没有报错的问题
 - 优化界面显示
[版本]>V_3.7.0-Official正式版
 - 在'安装Termux软件包'中支持连续安装
 - 在'关于/帮助'中新增部分常见问题解答
 - 在'安装Termux软件包'中新增ROOT模式检测
 - 在'切换Termux源为国内清华源'中新增ROOT模式检测
 - 新增多个'echo'以优化界面美观度
 - 新增多个函数以简化对应代码块
[版本]>V_4.0.0-Official正式版
 - 真正意义上实现了固化CA终端
[版本]>V_4.8.3-Official正式版
 - 修复'固化CA终端'中执行异常的问题
 - '命令行界面'新增ROOT模式无法使用su/tsu/sudo命令
 - 在'安装Termux软件包'中将输入'1'与回车条件互换
 - 略微优化代码结构
 - 优化'更新日志'界面美观度
 - 在'关于/帮助'中新增部分常见问题解答
 - 优化'关于/帮助'界面美观度
 - 在菜单中支持输入功能名称进入对应功能
 - 优化'切换至ROOT权限'界面美观度
 - 优化'切换Termux源为国内清华镜像源'界面美观度
 - 修复tee覆盖记录日志导致日志记录丢失的问题
 - 运行日志支持在存储目录'Termux_Log'文件夹中查看
 - 新增初始化项目
 - 修改主页'CA'标志
 - 修复'命令行界面'中切换至ROOT模式后无法执行命令
[版本]>V_5.1.0-Official正式版
 - 新增进入功能后不显示菜单
 - '更新日志'界面新增可选完整日志/特定版本日志
 - 优化'切换至ROOT模式'功能布局
 - '命令行界面'新增部分常用命令示例
 - 解决在安装软件包时因YN询问导致卡住的问题
 - 使子shell也能使用函数
 - 优化部分函数结构
 - 优化'命令行界面'函数调用
 - 略微优化代码结构
 - '关于/帮助界面新增代码使用许可
 - 新增AVB信息函数 在'命令行界面'中使用' AVB '命令或查看' AVB '变量即可查看是否为AVB分区设备
[版本]>V_5.2.0-Official正式版
 - 优化整体代码块 使代码块更易于维护
 - 调整菜单排版
 - 新增'小游戏'功能 目前支持三个游戏
 - 新增'设置CA终端'功能[待完善]
[版本]>V_5.2.1-Official正式版
 - 新增菜单输入选项部分可执行命令
 - 优化'小游戏'功能
 - 新增使用非Termux终端打开脚本指引进入Termux使用
[版本]>V_5.2.4-Official正式版
 - 命令行界面新增对'cd'命令特殊处理
 - 命令行界面新增切换为原Termux工作目录
 - 优化'小游戏'界面美观度
[版本]>V_5.2.8-Official正式版
 - 修复'命令行界面'中使用su命令导致部分命令没被特殊处理
 - 优化'命令行界面'的整体显示
 - 优化'命令行'界面命令执行
[版本]>V_5.3.0-Official正式版
 - '安装Termux软件包'页面新增apt/pkg管理器可选
 - 优化界面显示
[版本]>V_5.3.6-Official正式版
 - 将原'设置CA终端'功能改为'云更新CA终端'并完善功能
 "
    IFS=$'\n'
    echo -e -n "$COLOR [CA]\033[0;33;1m正在打开更新日志界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[NEW]\033[0;33;1m所有版本或特定版本的更新内容都可以在这里查看\033[0m"
    echo -e -n "\033[0;36;1m[1›完整日志/2›特定版本]*ᐷ\033[0;1m"
    read YN_LOG
    if [ "$YN_LOG" = "1" ]
    then
        echo -e "$COLOR[CA]\033[0;33;1m完整更新日志 >>\033[0m"
        IFS=$'\n'
        for NO_TWO_A in $ALL_NEW
        do
            sleep 0.03
            ECHO_THE_HEAD=$(echo "$NO_TWO_A" | cut -c1)
            if [ "$ECHO_THE_HEAD" = ' ' ]
            then
                echo -e "\033[0;36;1m$NO_TWO_A\033[0m"
            elif [ "$ECHO_THE_HEAD" = '[' ]
            then
                echo -e "\033[0;33;1m$NO_TWO_A\033[0m"
            fi
        done
        echo -e "\033[0;33;1m  < [ - \033[0;32;1m到此为最新版本 \033[0;33;1m- ] >\033[0m"
        REBOOTCA
    else
        WHILE_NEW
        ONLY_NEW=$(echo "$ALL_NEW" | grep "$OK_NEW")
        if [ -z "$ONLY_NEW" ]
        then
            echo -e "\033[0;31;1m[!]\033[0;33;1m没有关于\033[0;36;1m$OK_NEW\033[0;33;1m的更新日志\033[0m"
    REBOOTCA
        fi
        ONE_NEW=$(echo "$ALL_NEW" | grep -A 999 "$OK_NEW" | sed -n '1,/\[版本\]/p' | sed '$d' | sed '1d')
        echo -e "$COLOR[CA]\033[0;33;1m有关\033[0;36;1m$OK_NEW\033[0;33;1m的更新日志 >>\033[0m"
        echo -e "\033[0;33;1m$ONLY_NEW\033[0m"
        echo -e "\033[0;36;1m$ONE_NEW\033[0m"
        REBOOTCA
    fi
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "9" ] || [ "$CAONE" = "LOG" ] || [ "$CAONE" = "运行日志" ]
then
    echo -e -n "$COLOR [CA]\033[0;33;1m正在打开查看日志界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[LOG]\033[0;33;1m查看日志功能仅用于查看问题来源以方便反馈或调试 可选择查看完整日志或搜索关键字 >>\033[0m"
    echo
    echo -e -n "\033[0;36;1m[1›查看完整日志/2›搜索关键字]*ᐷ\033[0;1m"
    read YN_J
    if [ "$YN_J" = "1" ]
    then
        echo -e "\033[0;33;1m[-]完整日志文件如下 >>\033[0m"
        echo -e "\033[0;37;1m$(cat $THE_LOG)\033[0m"
        echo -e -n "$COLOR[CA]\033[0;33;1m以上为完整日志 点按回车返回主页\033[0m"
        REBOOT_RE
    else
        echo -e -n "\033[0;33;1m[-]输入关键字进行搜索:\033[0;1m"
        read LOGDOD
        echo -e "\033[0;33;1m[-]依据关键字'\033[0;32;1m$LOGDOD\033[0;33;1m'搜索内容如下 >>\033[0m"
        echo -e "\033[0;37;1m$(cat $THE_LOG | grep "$LOGDOD")\033[0m"
        echo -e -n "$COLOR[CA]\033[0;33;1m以上为搜索关键字结果 点按回车返回主页\033[0m"
        REBOOT_RE
    fi
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "10" ] || [ "$CAONE" = "E" ] || [ "$CAONE" = "切换Termux源为国内清华镜像源" ]
then
    echo -e -n "$COLOR [CA]\033[0;33;1m正在打开切换Termux源功能...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[E]\033[0;33;1m切换Termux源后如需切换回原Termux源可前往命令行界面使用' termux-change-repo '命令并在随后界面中选择要切换的源\033[0m"
    echo
    if [ "$UID" = "0" ]
    then
        echo -e "\033[0;31;1m[!]\033[0;33;1mROOT模式无法使用'切换Termux源为国内清华镜像源'功能 切换为普通模式后再尝试进入页面\033[0m"
        REBOOTCA
    fi
    echo -e "$COLOR[CA]\033[0;33;1m是否切换Termux源为国内清华镜像源 >>\033[0m"
    echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
    read YN_D
    if [ "$YN_D" = "1" ]
    then
        echo -e "\033[0;33;1m->正在切换为国内清华镜像源...\033[0m"
        sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/apt/termux-main stable main@' $PREFIX/etc/apt/sources.list &>>$THE_LOG
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 已成功切换Termux源为国内清华镜像源\033[0m"
        else
            echo -e "\033[0;31;1m -! 切换失败\033[0m"
            echo -e "\033[0;33;1m[建议]\033[0;36;1m检查网络连接或前往网站 \033[32;4mhttps://mirrors.tuna.tsinghua.edu.cn/help/termux/ \033[0;33;1m查看\033[0m"
            REBOOTCA
        fi
        echo -e "\033[0;33;1m->正在更新软件包管理服务...\033[0m"
        yes | apt update &>>$THE_LOG
        YN_F=$(tail -n 1 "$THE_LOG" | cut -c1)
        if [ "$YN_F" = "E" ]
        then
            echo -e "\033[0;31;1m[!]\033[0;33;1m软件包管理服务更新失败 检查网络连接或重新进入'切换Termux源为国内清华镜像源'功能再试一次\033[0m"
            REBOOTCA
        else
            echo -e "\033[0;32;1m - 软件包管理服务更新成功\033[0m"
            echo -e "\033[0;32;1m[CA]\033[0;36;1m已成功将Termux源切换为国内清华镜像源\033[0m"
            REBOOTCA
        fi
    else
        echo -e -n "$COLOR[CA]\033[0;33;1m已取消换源 点按回车返回主页\033[0m"
        REBOOT_RE
    fi
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "11" ] || [ "$CAONE" = "X" ] || [ "$CAONE" = "退出CA终端" ]
then
    echo -e "$COLOR[CA]\033[0;33;1m正在退出CA终端...\033[0m"
    echo
    exit 0
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "12" ] || [ "$CAONE" = "ADB" ] || [ "$CAONE" = "为Termux提供ShizukuADB支持" ]
then
    echo -e -n "$COLOR [CA]\033[0;33;1m正在进入为Termux提供ShizukuADB界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[ADB]\033[0;33;1m为Termux提供Shizuku ADB支持 该ADB权限可在'命令行界面'中使用' sh rish '进入由Shizuku提供的命令行对话\033[0m"
    echo
    echo -e "\033[0;33;1m[-]是否立即进行 >>\033[0m"
    echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
    read YN_G
    if [ "$YN_G" = "1" ]
    then
        echo -e "\033[0;33;1m[-]开始执行 >>\033[0m"
        echo -e "\033[0;33;1m[+]输入'rish'文件的完整路径:"
        echo -e -n "\033[0;33;1m*ᐷ\033[0;1m"
        read RISHPATH
        echo -e "\033[0;33;1m[+]输入'rish_shizuku.dex'文件的完整路径:\033[0m"
        echo -e -n "\033[0;33;1m*ᐷ\033[0;1m"
        read DEXPATH
        echo -e -n "\033[0;33;1m->正在校验'rish'的路径:\033[0m"
        if [ -e "$RISHPATH" ]
        then
            echo -e "\033[0;32;1m存在\033[0m"
        else
            echo -e "\033[0;31;1m不存在\033[0m"
            echo -e -n "\033[0;31;1m[!]缺失文件无法继续 \033[0;33;1m点按回车返回主页\033[0m"
            REBOOT_RE
        fi
        echo -e -n "\033[0;33;1m->正在校验'rish_shizuku.dex'的路径:\033[0m"
        if [ -e "$DEXPATH" ]
        then
            echo -e "\033[0;32;1m存在\033[0m"
        else
            echo -e "\033[0;31;1m不存在\033[0m"
            echo -e -n "\033[0;31;1m[!]缺失文件无法继续 \033[0;33;1m点按回车返回主页\033[0m"
            REBOOT_RE
        fi
        HOME_A=/data/data/com.termux/files/home
        cp $RISHPATH $HOME_A/rish &>>$THE_LOG
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 执行成功 第[1/5]步\033[0m"
        else
            echo -e "\033[0;31;1m -! 执行失败\033[0m"
            echo -e "\033[0;33;1m[建议]\033[0;36;1m检查文件是否被意外删除或是否为官方版Termux\033[0m"
            REBOOTCA
        fi
        cp $DEXPATH $HOME_A/rish_shizuku.dex &>>$THE_LOG
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 执行成功 第[2/5]步\033[0m"
        else
            echo -e "\033[0;31;1m -! 执行失败\033[0m"
            echo -e "\033[0;33;1m[建议]\033[0;36;1m检查文件是否被意外删除或是否为官方版Termux\033[0m"
            REBOOTCA
        fi
        chmod 777 $HOME_A/rish &>>$THE_LOG
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 执行成功 第[3/5]步\033[0m"
        else
            echo -e "\033[0;31;1m -! 执行失败\033[0m"
            echo -e "\033[0;33;1m[建议]\033[0;36;1m检查文件是否被意外删除或是否为官方版Termux\033[0m"
            REBOOTCA
        fi
        chmod 777 $HOME_A/rish_shizuku.dex &>>$THE_LOG
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 执行成功 第[4/5]步\033[0m"
        else
            echo -e "\033[0;31;1m -! 执行失败\033[0m"
            echo -e "\033[0;33;1m[建议]\033[0;36;1m检查文件是否被意外删除或是否为官方版Termux\033[0m"
            REBOOTCA
        fi
        sed -i 's/PKG/com.termux/g' $HOME_A
        if [ "$?" = "0" ]
        then
            echo -e "\033[0;32;1m - 执行成功 第[5/5]步\033[0m"
        else
            echo -e "\033[0;31;1m -! 执行失败\033[0m"
            echo -e "\033[0;33;1m[建议]\033[0;36;1m检查文件是否被意外删除或是否为官方版Termux\033[0m"
            REBOOTCA
        fi
        echo -e "\033[0;32;1m[CA]\033[0;33;1m全部执行完毕 可选退出CA终端或返回主页\033[0m"
        echo -e -n "\033[0;36;1m[1›退出CA终端/2›返回主页]*ᐷ\033[0;1m"
        read YN_H
        if [ "$YN_H" = "1" ]
        then
            echo -e "\033[0;33;1m[-]退出后可尝试在Termux的命令提示符中执行' sh rish '命令以使用由Shizuku提供的ADB服务\033[0m"
            exit 0
        else
            SUREBOOT
        fi
    else
        echo -e -n "\033[0;33;1m[-]已取消执行 点按回车返回主页\033[0m"
        REBOOT_RE
    fi
# ——————————————————————————————————
# ——————功能间分隔——————
# ——————————————————————————————————
elif [ "$CAONE" = "13" ] || [ "$CAONE" = "云更新CA终端" ] || [ "$CAONE" = "UP" ]
then
    echo -e -n "$COLOR [CA]\033[0;33;1m正在进入为云更新CA终端界面...\033[0m\r"
    sleep 0.3
    ECHO_HEAD
    ECHO_ALL_DEV
    echo -e "$COLOR[UP]\033[0;33;1m更新CA终端已支持从云端(GitHub)更新\033[0m"
    echo
    echo -e "\033[0;33;1m[-]是否立即开始检查更新 >>\033[0m"
    echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
    read UP_YN
    if [ "$UP_YN" = "1" ] || [ "$UP_YN" = "是" ]
    then
        GIT_OK_PATH=/storage/emulated/0/Download/CATerminal/
        GITURL=$(echo aHR0cHM6Ly9naXRodWIuY29tL1hhSHVpem9uL0NBVGVybWluYWwK | base64 -d)
        NEWURL=$(echo aHR0cHM6Ly9naXRodWIuY29tL1hhSHVpem9uL05FV1ZTCg== | base64 -d)
        echo -e "\033[0;33;1m->正在从云端获取新版本信息...\033[0m"
        rm -rf $GIT_OK_PATH{,.[!.],}* &>>$THE_LOG
        if git clone $NEWURL $GIT_OK_PATH &>>$THE_LOG
        then
            NOW_VS=$(echo $NOWV_ | cut -c3-7)
            NEW_VS=$(cat $GIT_OK_PATH/NEW)
            NEW_VS_UN=$(echo "$NEW_VS" | cut -c3-7)
            if [ "$NOW_VS" \< "$NEW_VS_UN" ]
            then
                echo -e "\033[0;35;1m[UP]\033[0;33;1m发现新版本: \033[0;36;1m$NEW_VS\033[0m"
                echo -e "\033[0;33;1m[YN]是否立即下载更新 >>\033[0m"
                echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
                read NEW_YN
                if [ "$NEW_YN" = "1" ] || [ "$NEW_YN" = "是" ]
                then
                    echo -e "\033[0;33;1m->正在下载最新版本...\033[0m"
                    rm -rf $GIT_OK_PATH{,.[!.],}* &>>$THE_LOG
                    if git clone $GITURL $GIT_OK_PATH &>>$THE_LOG
                    then
                        echo -e "\033[0;32;1m - 下载完成 \033[0m"
                        echo -e "\033[0;33;1m[>]新版本CA终端文件位于'\033[0;36;1m$GIT_OK_PATH\033[0;33;1m'\033[0m"
                        echo -e "\033[0;33;1m[YN]是否立即启动新版本CA终端 >>\033[0m"
                        echo -e -n "\033[0;36;1m[1›是/2›否]*ᐷ\033[0;1m"
                        read STCA_YN
                        if [ "$STCA_YN" = "1" ] || [ "$STCA_YN" = "是" ]
                        then
                            echo -e "\033[0;35;1m[START]\033[0;33;1m正在启动最新版本CA终端 \033[0;36;1m版本>$NEW_VS\033[0;33;1m...\033[0m"
                            bash ${GIT_OK_PATH}CA终端.bash
                            echo -e -n "$COLOR[CA]\033[0;33;1m已退出最新版本CA终端 点按回车返回主页\033[0m"
                            REBOOT_RE
                        else
                            echo -e "\033[0;35;1m[CL]\033[0;33;1m已取消启动 新版本CA终端位于'\033[0;36;1m${GIT_OK_PATH}CA终端.bash\033[0;33;1m'目录\033[0m"
                            REBOOTCA
                        fi
                    else
                        echo -e "\033[0;31;1m[!]\033[0;33;1m无法下载最新版本CA终端 检查网络后再试一次\033[0m"
                        REBOOTCA
                    fi
                else
                    echo -e -n "$COLOR[CA]\033[0;33;1m已取消更新 点按回车返回主页\033[0m"
                    REBOOT_RE
                fi
            else
                echo -e "\033[0;35;1m[UP]\033[0;33;1m当前版本>\033[0;36;1m${NOWV_}\033[0;33;1m-\033[0;32;1m已是最新版本\033[0m"
                REBOOTCA
            fi
        else
            echo -e "\033[0;31;1m[!]\033[0;33;1m无法从云端获取最新版本 检查网络后再试一次\033[0m"
            REBOOTCA
        fi
    else
        echo -e "$COLOR[CA]\033[0;33;1m已取消检测更新 点按回车返回主页\033[0m"
        REBOOT_RE
    fi
else
    if [ -z "$CAONE" ]
    then
        echo -e "\033[0;31;1m[!]\033[0;33;1m输入内容不可为空\033[0m"
        SUREBOOT
    fi
    if [ "$CAONE" = "su" ] || [ "$CAONE" = "sudo" ] || [ "$CAONE" = "tsu" ] || [ "$CAONE" = "clear" ] || [ "$CAONE" = "exit" ]
    then
        echo -e "\033[0;31;1m[!]\033[0;33;1m此处无法使用'\033[0;36;1m$CAONE\033[0;33;1m'命令\033[0m"
        sleep 0.5
        SUREBOOT
    else
        EVAL_CAONE=$(timeout 1 $CAONE 2>&1)
        EVAL_EXIT_CA="$?"
        if [ "$EVAL_EXIT_CA" = "127" ]
        then
            echo -e "\033[0;31;1m[!]\033[0;33;1m'\033[0;36;1m$CAONE\033[0;33;1m'不是菜单中的选项/可执行的命令\033[0m"
            REBOOTCA
        else
            echo -e "\033[0;32;1m[>]\033[0;33;1m输出 >>\033[0;1m"
            eval $CAONE 2>>$THE_LOG
            echo
            echo -e -n "$COLOR[CA]\033[0;33;1m命令已执行完毕 点按回车返回主页\033[0m"
            REBOOT_RE
        fi
    fi
fi
