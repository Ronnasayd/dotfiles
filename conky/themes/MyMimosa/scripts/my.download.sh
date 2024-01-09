#!/bin/bash
curl -o ~/.cache/my-weather.json "https://api.open-meteo.com/v1/forecast?latitude=-5.0892&longitude=-42.8019&current=relative_humidity_2m,is_day,rain,temperature_2m,wind_speed_10m,precipitation,cloud_cover,weather_code&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,showers_sum,wind_speed_10m_max,precipitation_probability_max,precipitation_probability_min,precipitation_probability_mean&timezone=America%2FSao_Paulo&forecast_days=3"
curl -o ~/.cache/my-ip.json "https://freeipapi.com/api/json/"
exit