show_usage() {
    echo 'Usage: auto-sync directory destination...'
}

if [ $# -eq 0 ]; then
    show_usage
    exit 1
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_usage
elif [ $# -eq 1 ]; then
    show_usage
    exit 1
else
    while true; do
        inotifywait -e close_write -e delete -r $1
        for host in ${@:2}; do
            echo "Syncing $host..."
            rsync --delete -rt $1 $host:
        done
    done
fi
