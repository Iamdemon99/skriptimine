#!/bin/bash

show_header() {
    echo "=================="
    echo "   SÜSTEEMI INFO  "
    echo "=================="
}

show_user() {
    echo "Kasutaja: $(whoami)"
}

show_host() {
    echo "Arvuti: $(hostname)"
}

# Põhiprogrammi käivitamine
show_header
show_user
show_host
