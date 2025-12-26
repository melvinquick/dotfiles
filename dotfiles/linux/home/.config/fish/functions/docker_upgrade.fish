function docker_upgrade -d "While in a directory with a Docker Compose YAML file, running this function will run a pull and restart the container if a new image was found"
    set old_image_count (docker image ls --format table | wc -l)

    docker compose pull >/dev/null 2>&1 && docker compose up -d >/dev/null 2>&1

    set new_image_count (docker image ls --format table | wc -l)

    if test $old_image_count -ne $new_image_count
        echo "This container has been updated!"
    else
        echo "This container is already up to date!"
    end

    docker image prune -af >/dev/null 2>&1
end
