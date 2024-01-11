#!/bin/bash
export LC_NUMERIC="en_US.UTF-8"
IS_DAY=$(cat ~/.cache/my-weather.json | jq -r '.current.is_day')
WEATHER_CODE=$(cat ~/.cache/my-weather.json | jq -r '.current.weather_code')
WEATHER_ICON=

player_elapsed(){
total_string=$(playerctl metadata --format '{{duration(mpris:length)}}')
progress_string=$(playerctl metadata --format '{{duration(position)}}')

if [[ $total_string == *":"*":"* ]]; then
    total_hours=$(echo $total_string | cut -d':' -f1)
    total_minutes=$(echo $total_string | cut -d':' -f2)
    total_seconds=$(echo $total_string | cut -d':' -f3)
else
    total_hours=0
    total_minutes=$(echo $total_string | cut -d':' -f1)
    total_seconds=$(echo $total_string | cut -d':' -f2)
fi

if [[ $progress_string == *":"*":"* ]]; then
    progress_hours=$(echo $progress_string | cut -d':' -f1)
    progress_minutes=$(echo $progress_string | cut -d':' -f2)
    progress_seconds=$(echo $progress_string | cut -d':' -f3)
else
    progress_hours=0
    progress_minutes=$(echo $progress_string | cut -d':' -f1)
    progress_seconds=$(echo $progress_string | cut -d':' -f2)
fi
den=$((total_hours*3600 + total_minutes*60 + total_seconds*1))
num=$((progress_hours*3600 + progress_minutes*60 + progress_seconds*1))
result=$((100*num/den))
echo ${result}
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
    cat ~/.cache/my-ip.json | jq -r '.ipAddress' | cut -c -16
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
  PLAYER_ELAPSED)
    player_elapsed
  ;;
esac

