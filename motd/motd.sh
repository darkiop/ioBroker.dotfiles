#!/bin/bash

# uptime
upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
secs=$((${upSeconds}%60))
mins=$((${upSeconds}/60%60))
hours=$((${upSeconds}/3600%24))
days=$((${upSeconds}/86400))
UP=`printf "%d days, %02dh:%02dm:%02ds" "$days" "$hours" "$mins" "$secs"`

# size of /
root_usage=$(df -h / | awk '/\// {print $(NF-1)}' | sed 's/%//g')
root_usage_gb=$(df -h / | awk '/\// {print $(NF-3)}')
root_total=$(df -h / | awk '/\// {print $(NF-4)}')

# size of /home
if [ -d /home ]; then
  home_usage_gb=$(df -h /home | awk '/\// {print $(NF-3)}')
  home_total=$(df -h /home | awk '/\// {print $(NF-4)}')
fi

# get hostname
get_host_name=$(hostname)

# get os version & ip & cputemp
get_plat_data=$(cat /etc/os-release | grep PRETTY_NAME | awk -F"=" '{print $2}' | awk -F'"' '{ print $2 }')
get_cpu_temp=$(($(cat /sys/class/hwmon/hwmon0/temp1_input)/1000))"°C"
get_ip_host=$(/sbin/ip -o -4 addr list | awk '{print $4}' | cut -d/ -f1 | tail -1)

# cpu load av
get_os_load_1=$(cat /proc/loadavg | awk '{ print $1 }')
get_os_load_5=$(cat /proc/loadavg | awk '{ print $2 }')
get_os_load_15=$(cat /proc/loadavg | awk '{ print $3 }')
get_os_loadavg=`echo -e "$get_os_load_1" / " $get_os_load_5 $get_os_load_15"`

get_proc_ps=$(ps -Afl | wc -l)
get_swap=$(free -m | tail -n 1 | awk {'print $3'})

# set colors
blue_color="\e[38;5;33m"
light_blue_color="\e[38;5;39m"
red_color="\e[38;5;196m"
green_color="\e[38;5;42m"
green_color_bold="\e[1;38;5;42m"
yellow_color="\e[38;5;227m"
close_color="$(tput sgr0)"

# set title of terminal
trap 'echo -ne "\033]0;${HOSTNAME}\007"' DEBUG

# use toilet for title of motd
# show all available fonts: https://gist.github.com/itzg/b889534a029855c018813458ff24f23c
if [ -x "$(command -v toilet)" ]; then
  echo -e "$yellow_color"
  toilet -f smblock -w 150 $get_host_name
  echo -e "$close_color"
else 
  echo -e "$yellow_color$get_host_name$close_color
  $yellow_color"──────────────────────────────────────────────────""$close_color
fi

# echo infos
echo -e "$blue_color"hostname"$close_color          `echo -e "$green_color$get_host_name$close_color"`
$blue_color"ip"$close_color                `echo -e "$green_color$get_ip_host$close_color"`
$blue_color"load"$close_color              `echo -e "$green_color$get_os_load_1$close_color" / "$green_color$get_os_load_5$close_color" / "$green_color$get_os_load_15$close_color"`
$blue_color"cpu-temp"$close_color          `echo -e "$green_color$get_cpu_temp$close_color"`
$blue_color"uptime"$close_color            `echo -e "$green_color$UP$close_color"`
$blue_color"os"$close_color                `echo -e "$green_color$get_plat_data$close_color"`
$blue_color"usage of /"$close_color        `echo -e "$green_color$root_usage% $close_color"`/ ` echo -e "$green_color$root_usage_gb$close_color"` "of" `echo -e "$green_color$root_total$close_color"`"

# iobroker motd
if [ -f ~/iobroker-dotfiles/motd/motd-iobroker.sh ]; then
  source ~/iobroker-dotfiles/motd/motd-iobroker.sh
else
  # print empty line
  echo
fi

# show OS updates
echo -e "$light_blue_color"
printf "Checking for OS updates ...\n\n"
if [ "$(which apt-get)" ]; then echo "`apt-get -s -o Debug::NoLocking=true upgrade | grep ^Inst | wc -l` updates to install." ; fi
printf "\n"

# EOF
