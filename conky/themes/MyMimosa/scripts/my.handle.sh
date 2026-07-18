#!/bin/bash
export LC_NUMERIC="en_US.UTF-8"
IS_DAY=$(cat ~/.cache/my-weather.json | jq -r '.current.is_day')
WEATHER_CODE=$(cat ~/.cache/my-weather.json | jq -r '.current.weather_code')
WEATHER_ICON=
function icons(){
  if [ $(docker ps | wc -l) -gt 1 ]; then
    DOCKER_RUNNING=$(docker ps --filter "status=running" -q | wc -l)
    DOCKER_ICON="$DOCKER_RUNNING  "
  fi
  if [[ -n "$(nmcli con | grep -i vpn | grep wlp6s0)" ]]; then
    VPN_ICON="󰷛 "
  fi
  if [[ -n "$(amixer get Headphone | grep '\[on\]')" ]]; then
    HEADSET_ICON="󰋎 "
  fi
  if [[ "$(lsmod | grep uvcvideo | head -n 1 | awk '{print $3}')" -eq "1" ]]; then
    CAM_ICON="󰄀 "
  fi
  echo "${DOCKER_ICON}${VPN_ICON}${HEADSET_ICON}${CAM_ICON}"
}
case $1 in
  CUR_IS_DAY)
    if [ "$IS_DAY" -eq "0" ];then
      echo ""
    else
      echo ""
    fi
  ;;
  CUR_TEMP)
    cat ~/.cache/my-weather.json | jq -r '.current.temperature_2m' | xargs printf "%04.1f"
  ;;
  IP_ADDRESS)
    cat ~/.cache/my-ip.json | jq -r '.ip' | cut -c -16
  ;;
  PLAYER_STATUS)
    playerctl status
  ;;
  CUR_HUM)
    cat ~/.cache/my-weather.json | jq -r '.current.relative_humidity_2m' | xargs printf "%02d"
  ;;
  CUR_WS)
    cat ~/.cache/my-weather.json | jq -r '.current.wind_speed_10m'
  ;;
  CUR_PREC)
    PRECIPITATION=$(cat ~/.cache/my-weather.json | jq -r '.current.precipitation')
    PROB_PRECIPITATION=$(cat ~/.cache/my-weather.json | jq -r '.daily.precipitation_probability_mean[0]')
    if [ "$PRECIPITATION" -eq "0" ];then
      echo "$PROB_PRECIPITATION" | xargs printf "%02d%%"
    else
      echo "$PRECIPITATION mm"
    fi
  ;;
  CUR_ICON)
    if [[ "${WEATHER_CODE}" -lt 50 ]]; then
      WEATHER_ICON=
    elif [[ "${WEATHER_CODE}" = 80 || "${WEATHER_CODE}" = 61 ]]; then
      WEATHER_ICON=
    elif [[ "${WEATHER_CODE}" = 81 || "${WEATHER_CODE}" = 63 ]]; then
      WEATHER_ICON=
    elif [[ "${WEATHER_CODE}" = 82 || "${WEATHER_CODE}" = 65 ]]; then
      WEATHER_ICON=󰖖
    elif [[ "${WEATHER_CODE}" -gt 82 ]]; then
      WEATHER_ICON=
    fi
    echo "${WEATHER_ICON}"
  ;;
  DAILY_DAY)
    cat ~/.cache/my-weather.json | jq -r '.daily.time['$2']' | awk -F- '{print $3}'
  ;;
  DAILY_MIN)
    cat ~/.cache/my-weather.json | jq -r '.daily.temperature_2m_min['$2']' | xargs printf "%04.1f"
  ;;
  DAILY_MAX)
    cat ~/.cache/my-weather.json | jq -r '.daily.temperature_2m_max['$2']' | xargs printf "%04.1f"
  ;;
  DAILY_PREC_MEAN)
    cat ~/.cache/my-weather.json | jq -r '.daily.precipitation_probability_mean['$2']'| xargs printf "%02d"
  ;;
  SERVICES)
    icons
  ;;
esac
