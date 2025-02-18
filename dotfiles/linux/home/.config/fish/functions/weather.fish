function weather
    curl 'wttr.in/Clearfield+PA?format=\n+Location:+Clearfield,+PA+\n+Forecast:+%c+\n+Rainfall:+%p+\n+Temp:+%t(%f)+\n+Moon:+%m+\n'
end
