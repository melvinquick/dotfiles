function docker_upgrade -d "While in a directory with a Docker Compose YAML file, running this function will run a pull and restart the container if a new image was found"

    set container_name (basename $(pwd))

    docker compose pull >/dev/null 2>&1 && docker compose down >/dev/null 2>&1 && docker compose up -d >/dev/null 2>&1 && docker image prune -af >/dev/null 2>&1

    if test $container_name = nextcloud
        sleep 5
        docker compose exec -u www-data app php occ upgrade >/dev/null 2>&1
        docker compose exec -u www-data app php occ db:add-missing-indices >/dev/null 2>&1
        docker compose exec -u www-data app php occ maintenance:repair --include-expensive >/dev/null 2>&1
    end

    echo 'The container upgrade process is complete!'
end
