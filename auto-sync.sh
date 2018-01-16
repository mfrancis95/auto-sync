show_usage() {
    echo 'Usage: auto-sync directory destination...'
    exit $1
}

if [ $# -eq 0 ]; then
    show_usage 1
elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_usage 0
elif [ $# -eq 1 ]; then
    show_usage 1
elif [ ! -d $1 ]; then
    echo "$1 is not a directory."
    exit 1
else
    while true; do
        inotifywait -e close_write -e delete -e move -r $1
        for host in ${@:2}; do
            echo "Syncing $host..."
            rsync --delete -rt $1 $host:
        done
    done
fi
