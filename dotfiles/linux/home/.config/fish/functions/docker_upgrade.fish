function docker_upgrade -d "While in a directory with a Docker Compose YAML file, running this function will run a pull and restart the container if a new image was found"
    set old_images (docker compose images -q)

    docker compose pull >/dev/null 2>&1 && docker compose up -d >/dev/null 2>&1

    docker image prune -af >/dev/null 2>&1

    set new_images (docker compose images -q)

    if test $old_images != $new_images
        echo "This container has been updated!"
    else
        echo "This container is already up to date!"
    end
end
