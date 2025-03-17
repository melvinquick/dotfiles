function weather_checker -a city state -d "Quickly get your local weather in your terminal using wttr.in"
    if test -z "$city"
        echo "You need to provide the City AND State arguments! e.g., weather Philadelphia Pennsylvania"
    else if test -z "$state"
        echo "You need to provide the City AND State arguments! e.g., weather Philadelphia Pennsylvania"
    else
        curl "wttr.in/$city+$state+USA?format=\n+Location:+$city,+$state+\n+Forecast:+%c+\n+Rainfall:+%p+\n+Temp:+%t(%f)+\n+Moon:+%m+\n"
    end
end
