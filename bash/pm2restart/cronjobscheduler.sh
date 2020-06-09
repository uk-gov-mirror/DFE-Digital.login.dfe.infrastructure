#!/bin/bash
#How to use
#To run cron every day at certain time:
#cronjobscheduler.sh [HH:MM] daily [command]
#example:
#cronjobscheduler.sh 14:14 daily "/usr/local/bin/pm2 restart 0"
#To run cron weekly (one time a week) at certain day and time:
#cronjobscheduler.sh [HH:MM] weekly_[sun-sat] [command]
#example:
#cronjobscheduler.sh 23:45 weekly_mon "pm2 restart 1"
#To run cron monthly (one time a month) at certain day and time:
#cronjobscheduler.sh [HH:MM] monthly_[1-31] [command]
#example:
#cronjobscheduler.sh 23:45 monthly_1 "pm2 restart jobs"
# Time parameter
HM=$1
# Parse hours
H=`echo $1|cut -d ':' -f 1`
# Parse minutes
M=`echo $1|cut -d ':' -f 2`
# This util ignoring case sensitivity
shopt -s nocasematch
# Regularity parameter
R=$2
# Command parameter
CMD=$3
case ${R} in
  daily)
    (crontab -l; echo "${M} ${H} * * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  weekly_sun)
    (crontab -l; echo "${M} ${H} * * SUN ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  weekly_mon)
    (crontab -l; echo "${M} ${H} * * MON ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  weekly_tue)
    (crontab -l; echo "${M} ${H} * * TUE ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  weekly_wed)
    (crontab -l; echo "${M} ${H} * * WED ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  weekly_thu)
    (crontab -l; echo "${M} ${H} * * THU ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  weekly_fri)
    (crontab -l; echo "${M} ${H} * * FRI ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  weekly_sat)
    (crontab -l; echo "${M} ${H} * * SAT ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_1)
    (crontab -l; echo "${M} ${H} 1 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_2)
    (crontab -l; echo "${M} ${H} 2 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_3)
    (crontab -l; echo "${M} ${H} 3 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_4)
    (crontab -l; echo "${M} ${H} 4 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_5)
    (crontab -l; echo "${M} ${H} 5 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_6)
    (crontab -l; echo "${M} ${H} 6 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_7)
    (crontab -l; echo "${M} ${H} 7 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_8)
    (crontab -l; echo "${M} ${H} 8 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_9)
    (crontab -l; echo "${M} ${H} 9 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_10)
    (crontab -l; echo "${M} ${H} 10 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_11)
    (crontab -l; echo "${M} ${H} 11 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_12)
    (crontab -l; echo "${M} ${H} 12 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_13)
    (crontab -l; echo "${M} ${H} 13 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_14)
    (crontab -l; echo "${M} ${H} 14 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_15)
    (crontab -l; echo "${M} ${H} 15 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_16)
    (crontab -l; echo "${M} ${H} 16 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_17)
    (crontab -l; echo "${M} ${H} 17 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_18)
    (crontab -l; echo "${M} ${H} 18 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_19)
    (crontab -l; echo "${M} ${H} 19 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_20)
    (crontab -l; echo "${M} ${H} 20 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_21)
    (crontab -l; echo "${M} ${H} 21 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_22)
    (crontab -l; echo "${M} ${H} 22 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_23)
    (crontab -l; echo "${M} ${H} 23 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_24)
    (crontab -l; echo "${M} ${H} 24 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_25)
    (crontab -l; echo "${M} ${H} 25 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_26)
    (crontab -l; echo "${M} ${H} 26 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_27)
    (crontab -l; echo "${M} ${H} 27 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_28)
    (crontab -l; echo "${M} ${H} 28 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_29)
    (crontab -l; echo "${M} ${H} 29 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_30)
    (crontab -l; echo "${M} ${H} 30 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
  monthly_31)
    (crontab -l; echo "${M} ${H} 31 * * ${CMD} > /tmp/cronlog 2>&1") | crontab -
    ;;
esac