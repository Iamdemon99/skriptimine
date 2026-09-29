naita_argumendid() {
    echo "Kokku anti $# argumenti:"
    for arg in "$@"; do
        echo " - $arg"
    done
}

naita_argumendid "üks" "kaks" "kolm"
