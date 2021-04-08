#!/usr/bin/env bash

## 路径
ShellDir=$(cd "$(dirname "$0")";pwd)
ConfigDir=${ShellDir}/config
FileConf=${ConfigDir}/config.sh
ScriptsDir=${ShellDir}/scripts
LogDir=${ShellDir}/log
ListScripts=($(cd ${ScriptsDir}; ls *.js | grep -E "j[drx]_"))
ListCron=${ConfigDir}/crontab.list


## 导入 config.sh
function Import_Conf {
  if [ -f ${FileConf} ]
  then
    . ${FileConf}
    if [ -z "${Cookie1}" ]; then
      echo -e "请先在 config.sh 中配置好 Cookie\n"
      exit 1
    fi
  else
    echo -e "配置文件 ${FileConf} 不存在，请先按教程配置好该文件\n"
    exit 1
  fi
}


## 更新 Crontab
function Detect_Cron {
  if [[ $(cat ${ListCron}) != $(crontab -l) ]]; then
    crontab ${ListCron}
  fi
}


## 用户数量 UserSum
function Count_UserSum {
  for ((i=1; i<=35; i++)); do
    Tmp=Cookie$i
    CookieTmp=${!Tmp}
    [[ ${CookieTmp} ]] && UserSum=$i || break
  done
}


## 组合 Cookie 和互助码子程序
function Combin_Sub {
  CombinAll=""
  for ((i=1; i<=${UserSum}; i++)); do
    for num in ${TempBlockCookie}; do
      if [[ $i -eq $num ]]; then
        continue 2
      fi
    done
    Tmp1=$1$i
    Tmp2=${!Tmp1}
    CombinAll="${CombinAll}&${Tmp2}"
  done
  echo ${CombinAll} | perl -pe "{s|^&||; s|^@+||; s|&@|&|g; s|@+&|&|g; s|@+|@|g; s|@+$||}"
}


## 组合Cookie、Token与互助码
function Combin_All {
  export JD_COOKIE=$(Combin_Sub Cookie)
  ## 东东农场(jd_fruit.js)
  export FRUITSHARECODES=$(Combin_Sub ForOtherFruit "0e5acaee5f154eeaa43e15b2db729043@f6b0b7cd6a89476d896995520bd38fe0@6a29fffaca384b0bbc310c0413ac74ae" "354d1e4fe24c4a7fb135aeb797b490fe")
  ## 东东萌宠(jd_pet.js)
  export PETSHARECODES=$(Combin_Sub ForOtherPet "MTE1NDQ5OTIwMDAwMDAwNDM3MDU4NjM=@MTE1NDQ5MzYwMDAwMDAwNDM3MDU4NjU=@MTE1NDQ5MzYwMDAwMDAwNDM3MDU4Njc="
  ## 种豆得豆(jd_plantBean.js)
  export PLANT_BEAN_SHARECODES=$(Combin_Sub ForOtherBean "irm5rsgr4uhh5ysapvwbnwdbaq@6jh35f4aentjqg5sc7jkjfalyta42sgqgwrzxra@4npkonnsy7xi2khs4lfudyqyky62c55urmdh6vq" "gde5d4nyazgsyldpydoejl3fhx5a3o7p2eyg2wy")
  ## 东东工厂(jd_jdfactory.js)
  export DDFACTORY_SHARECODES=$(Combin_Sub ForOtherJdFactory)
  ## 京喜工厂(jd_dreamFactory.js)
  export DREAM_FACTORY_SHARE_CODES=$(Combin_Sub ForOtherDreamFactory)
  ## 京东赚赚(jd_jdzz.js)
  export JDZZ_SHARECODES=$(Combin_Sub ForOtherJdzz "S-awnH1xG@Sv_9zRRcZ91LRPRP9nf4PfDOb@S5KkcR0oe_FDRckz3xaEDIg" "S-ak2NUlgjCKrYnqgz7Q")
  ## 疯狂的Joy(jd_crazy_joy.js)
  export JDJOY_SHARECODES=$(Combin_Sub ForOtherJoy)
  ## 口袋书店(jd_bookshop.js)
  export BOOKSHOP_SHARECODES=$(Combin_Sub ForOtherBookShop)
  ## 签到领现金(jd_cash.js)
  export JD_CASH_SHARECODES=$(Combin_Sub ForOtherCash "ZEpjM67t@Ihk3aeWyZPog7GfcwnoW3lRg@eU9Ya7i1b_ggozjWmiUagA" "ZE9yGbvLH4pasw6BkDA")
  ## 京喜农场(jd_jxnc.js)
  export JXNC_SHARECODES=$(Combin_Sub ForOtherJxnc)
  ## 闪购盲盒(jd_sgmh.js)
  export JDSGMH_SHARECODES=$(Combin_Sub ForOtherSgmh "T008-awnH1xGCjVWmIaW5kRrbA@T024v_9zRRcZ91LRPRP9nf4PfDObCjVWmIaW5kRrbA@T0225KkcR0oe_FDRckz3xaEDIgCjVWmIaW5kRrbA" "T019-ak2NUlgjCKrYnqgz7QCjVWmIaW5kRrbA")
  ## 京喜财富岛(jd_cfd.js)
  export JDCFD_SHARECODES=$(Combin_Sub ForOtherCfd "7A94E4F107FA337A402CA23A3C979CAC71310967BE165544D8C825F27C4A2BA3@424B6B788CB7A7D8681DE878117FD32C224A50FB00405B475357DCA709823A03@E37E3204C41C90EC298F95026713E1017C89B27B703C85C4154F8DF02545DFCE" "087EDECCD0B9F45DBEBDD18F8F300D5B0FC8DE37D15CA2DBB47BE866DF9FE6E9")
  ## 环球挑战赛(jd_global.js)
  export JDGLOBAL_SHARECODES=$(Combin_Sub ForOtherGlobal "MjNtTnVxbXJvMGlWTHc5Sm9kUXZ3VUM4R241aDFjblhybHhTWFYvQmZUOD0")
  ## 京东手机狂欢城(jd_carnivalcity.js)
  export JD818_SHARECODES=$(Combin_Sub ForOtherCarnivalcity "8587fdbc-4a2e-49ba-aabc-b004756f2a2b@bbf6bf83-7695-4d11-a83d-1a94c2708071@2ba37e0e-1454-441c-97a2-b3ac39fbb651" "1a35ca83-baee-4983-b06a-a278ff828cd1")
}


## 转换 JD_BEAN_SIGN_STOP_NOTIFY 或 JD_BEAN_SIGN_NOTIFY_SIMPLE
function Trans_JD_BEAN_SIGN_NOTIFY {
  case ${NotifyBeanSign} in
    0)
      export JD_BEAN_SIGN_STOP_NOTIFY="true"
      ;;
    2)
      export JD_BEAN_SIGN_STOP_NOTIFY="false"
      export JD_BEAN_SIGN_NOTIFY_SIMPLE="false"
      ;;
    *)
      export JD_BEAN_SIGN_STOP_NOTIFY="false"
      export JD_BEAN_SIGN_NOTIFY_SIMPLE="true"
      ;;
  esac
}


## 转换 UN_SUBSCRIBES
function Trans_UN_SUBSCRIBES {
  export UN_SUBSCRIBES="${goodPageSize}\n${shopPageSize}\n${jdUnsubscribeStopGoods}\n${jdUnsubscribeStopShop}"
}


## 设置获取共享池助力码个数
function Get_HelpPoolNum {
  HelpPoolNum=$( printf "%d" "$HelpPoolNum" 2> /dev/null )
  if [ $HelpPoolNum -lt 0 ] || [ $HelpPoolNum -gt 25 ]; then
      HelpPoolNum=0
  fi
  HelpPoolNum16=0x$( printf %x $HelpPoolNum )
}


## 申明全部变量
function Set_Env {
  Count_UserSum
  Combin_All
  Trans_JD_BEAN_SIGN_NOTIFY
  Trans_UN_SUBSCRIBES
  Get_HelpPoolNum
}


## 随机延迟
function Random_Delay {
  if [[ -n ${RandomDelay} ]] && [[ ${RandomDelay} -gt 0 ]]; then
    CurMin=$(date "+%-M")
    if [[ ${CurMin} -gt 2 && ${CurMin} -lt 30 ]] || [[ ${CurMin} -gt 31 && ${CurMin} -lt 59 ]]; then
      CurDelay=$((${RANDOM} % ${RandomDelay} + 1))
      echo -e "\n命令未添加 \"now\"，随机延迟 ${CurDelay} 秒后再执行任务，如需立即终止，请按 CTRL+C\n"
      sleep ${CurDelay}
    fi
  fi
}


## 使用说明
function Help {
  echo -e "本脚本的用法为："
  echo -e "1. bash jd.sh xxx      # 如果设置了随机延迟并且当时时间不在 0-2、30-31、59 分内，将随机延迟一定秒数"
  echo -e "2. bash jd.sh xxx now  # 无论是否设置了随机延迟，均立即运行"
  echo -e "3. bash jd.sh hangup   # 重启挂机程序"
  echo -e "4. bash jd.sh resetpwd # 重置控制面板用户名和密码"
  echo -e "\n针对用法1、用法2中的 \"xxx\"，无需输入后缀 \".js\"，另外，如果前缀是 \"jd_\" 的话前缀也可以省略。"
  echo -e "当前有以下脚本可以运行（仅列出 jd_scripts 中以 jd_、jr_、jx_ 开头的脚本）："
  cd ${ScriptsDir}
  for ((i=0; i<${#ListScripts[*]}; i++)); do
    Name=$(grep "new Env" ${ListScripts[i]} | awk -F "'|\"" '{print $2}')
    echo -e "$(($i + 1)).${Name}：${ListScripts[i]}"
  done
}


## 查找脚本路径与准确的文件名
function Find_FileDir {
  FileNameTmp1=$(echo $1 | perl -pe "s|\.js||")
  FileNameTmp2=$(echo $1 | perl -pe "{s|jd_||; s|\.js||; s|^|jd_|}")
  for ((i=0; i<${#DiyDirs[*]}; i++)); do
    DiyDirs[i]=${ShellDir}/${DiyDirs[i]}
  done
  SeekDir="${ScriptsDir} ${ScriptsDir}/backUp ${DiyDirs[*]}"
  FileName=""
  WhichDir=""

  for dir in ${SeekDir}
  do
    if [ -f ${dir}/${FileNameTmp1}.js ]; then
      FileName=${FileNameTmp1}
      WhichDir=${dir}
      break
    elif [ -f ${dir}/${FileNameTmp2}.js ]; then
      FileName=${FileNameTmp2}
      WhichDir=${dir}
      break
    fi
  done
}


## nohup
function Run_Nohup {
  nohup node $1.js 2>&1 > ${LogFile} &
}


## 运行挂机脚本
function Run_HangUp {
  HangUpJs="jd_crazy_joy_coin"
  cd ${ScriptsDir}
  for js in ${HangUpJs}; do
    Import_Conf ${js}
    Count_UserSum
    Set_Env
    if type pm2 >/dev/null 2>&1; then
      pm2 stop ${js}.js 2>/dev/null
      pm2 flush
      pm2 start -a ${js}.js --watch "${ScriptsDir}/${js}.js" --name="${js}"
    else
      if [ $(. /etc/os-release && echo "$ID") == "openwrt" ]; then
        if [[ $(ps | grep "${js}" | grep -v "grep") != "" ]]; then
          ps | grep "${js}" | grep -v "grep" | awk '{print $1}' | xargs kill -9
        fi
      else
        if [[ $(ps -ef | grep "${js}" | grep -v "grep") != "" ]]; then
          ps -ef | grep "${js}" | grep -v "grep" | awk '{print $2}' | xargs kill -9
        fi
      fi
      [ ! -d ${LogDir}/${js} ] && mkdir -p ${LogDir}/${js}
      LogTime=$(date "+%Y-%m-%d-%H-%M-%S")
      LogFile="${LogDir}/${js}/${LogTime}.log"
      Run_Nohup ${js} >/dev/null 2>&1
    fi
  done
}


## 重置密码
function Reset_Pwd {
  cp -f ${ShellDir}/sample/auth.json ${ConfigDir}/auth.json
  echo -e "控制面板重置成功，用户名：admin，密码：password\n"
}


## 运行京东脚本
function Run_Normal {
  Import_Conf $1
  Detect_Cron
  Count_UserSum
  Find_FileDir $1
  Set_Env

  if [[ ${FileName} ]] && [[ ${WhichDir} ]]
  then
    [ $# -eq 1 ] && Random_Delay
    LogTime=$(date "+%Y-%m-%d-%H-%M-%S")
    LogFile="${LogDir}/${FileName}/${LogTime}.log"
    [ ! -d ${LogDir}/${FileName} ] && mkdir -p ${LogDir}/${FileName}
    cd ${WhichDir}
    sed -i "s/randomCount = .* [0-9]* : [0-9]*;/randomCount = $HelpPoolNum;/g" ${FileName}.js
    sed -i "s/randomCount=.*?0x[0-9a-f]*:0x[0-9a-f]*;/randomCount=$HelpPoolNum16;/g" ${FileName}.js
    node ${FileName}.js 2>&1 | tee ${LogFile}
  else
    echo -e "\n在有关目录下均未检测到 $1 脚本的存在\n"
    Help
  fi
}


## 命令检测
case $# in
  0)
    echo
    Help
    ;;
  1)
    case $1 in
      hangup)
        Run_HangUp
        ;;
      resetpwd)
        Reset_Pwd
        ;;
      *)
        Run_Normal $1
        ;;
    esac
    ;;
  2)
    case $2 in
      now)
        Run_Normal $1 $2
        ;;
      *)
        echo -e "\n命令输入错误\n"
        Help
        ;;
    esac
    ;;
  *)
    echo -e "\n命令输入错误\n"
    Help
    ;;
esac
